package main

import (
	"context"
	"fmt"
	"log"
	"math/big"
	"os"
	"path/filepath"
	"slices"
	"strings"
	"sync"
	"time"

	"github.com/ethereum/go-ethereum/common"
	"github.com/slack-go/slack"
	"github.com/urfave/cli/v2"
	"gopkg.in/yaml.v3"
)

const (
	minCheckTime = 60 * time.Second
)

type multiBalance struct {
	sync.Mutex
	amount map[string]*balance // chain: balance
}

func (m *multiBalance) set(k string, v *balance) {
	m.Lock()
	m.amount[k] = v
	m.Unlock()
}

var (
	cfg               = &config{}
	balances          = make(map[watchInfo]*multiBalance)
	bLock             = sync.Mutex{}
	lastNotifySummary = time.Time{}
	notifyTypeMessage = map[string]string{
		"ok":      "✅️✅️✅️ : 🙂",
		"bad":     "❌️❌️❌️ : 🙃",
		"warning": "🆘🆘🆘 : 😱",
		"notice":  "⚠️⚠️⚠️ : 😬",
		"wining":  "💰️💰️💰️ : 🤩",
		"normal":  "◽️◽️◽️ : ",
	}
)

func run(ctx *cli.Context) error {
	// Load configuration from config.yaml
	dir, _ := os.Getwd()
	filename := filepath.Join(dir, ctx.String("config"))
	log.Println("load config: ", filename)
	data, err := os.ReadFile(filename)
	if err != nil {
		return err
	}
	err = yaml.Unmarshal(data, &cfg)
	if err != nil {
		return err
	}
	//validate the configuration
	if cfg.CheckTime < minCheckTime {
		cfg.CheckTime = minCheckTime
	}
	log.Printf("Loaded configuration: %+v", cfg)
	err = initChain(cfg.ChainList)
	if err != nil {
		return err
	}

	bLock.Lock()
	for _, wInfo := range cfg.WatchList {
		if balances[wInfo] == nil {
			balances[wInfo] = &multiBalance{amount: make(map[string]*balance)}
		}
	}
	bLock.Unlock()

	watch := func() {
		wg := &sync.WaitGroup{}
		for i := range cfg.WatchList {
			time.Sleep(time.Second) //some rpc rate limit about 1 req/sec
			wl := cfg.WatchList[i]
			wg.Add(1)
			go func(wInfo watchInfo) {
				var err error
				defer wg.Done()
				defer func() {
					if err != nil {
						log.Println("error: ", err)
					}
				}()

				if wInfo.Address == "" {
					if wInfo.TokenContract == "" {
						err = fmt.Errorf("address is empty, but token contract is not set")
						return
					}
					chainCli, err := getChainByName(wInfo.Chain)
					if err != nil {
						return
					}
					//call contract method(ERC20)
					tkn, err := chainCli.newERC20Token(wInfo.TokenContract)
					if err != nil {
						return
					}
					tk := &balance{
						contract: wInfo.TokenContract, symbol: tkn.symbol, decimal: tkn.decimal, value: tkn.totalSupply,
					}
					log.Println("get balance for ", tk, " on chain ", wInfo.Chain)
					bLock.Lock()
					_b := balances[wInfo]
					bLock.Unlock()
					_b.set(tk.contract, tk)

				} else {
					tk, err := getBalance(&wInfo)
					if err != nil {
						log.Printf("get balance for %s on chain %s : %v", wInfo.Address, wInfo.Chain, err)
						return
					}
					if wInfo.Op != "" && compare(wInfo.Op, tk.Float(), wInfo.Balance) {
						txt := fmt.Sprintf("%s️ # %s(addr: %s) on %s balance: %s %v (%v)",
							lookupNotifyMsg(wInfo.NotifyType), wInfo.Name, wInfo.Address, wInfo.Chain, wInfo.Op, wInfo.Balance, tk.String())
						log.Println(txt)
						slackNotify(txt)
					}

					bLock.Lock()
					_b := balances[wInfo]
					bLock.Unlock()
					_b.set(tk.contract, tk)
				}
			}(wl)
		}
		wg.Wait()

	}

	for {
		watch()
		notifySummary(time.Now().UTC())

		//wait next
		time.Sleep(cfg.CheckTime)
	}
}

func summary() string {
	msg := strings.Builder{}
	msg.WriteString("Balance Summary:\n")
	var group = make(map[string][]watchInfo)
	bLock.Lock()
	defer bLock.Unlock()
	for i := range balances {
		group[i.Name] = append(group[i.Name], i)
	}
	for name, g := range group {
		msg.WriteString(name + ":\n")
		for _, c := range g {
			mb := balances[c]
			mb.Lock()
			for _, val := range mb.amount {
				msg.WriteString(fmt.Sprintf("    %s on: %-10s %s\n", formatAddr(&c, val), c.Chain, val))
			}
			mb.Unlock()
		}
	}

	return msg.String()
}

func formatAddr(c *watchInfo, ba *balance) string {
	s := c.Address
	if s == "" {
		s = ba.contract
	}
	l := len(s)
	ss := s[:min(l, 8)] + "..." + s[max(0, l-6):]
	if c.Chain == "" {
		return ss
	}
	info, err := getChainByName(c.Chain)
	if err != nil {
		panic(err)
	}
	var url string
	if c.TokenContract != "" {
		url, err = info.getTokenURL(s)
	} else {
		url, err = info.getAddressURL(s)
	}
	if err != nil {
		log.Println("get url: ", err)
		return ss
	}
	return fmt.Sprintf("<%s|%s>", url, ss)
}

func getBalance(wInfo *watchInfo) (t *balance, err error) {

	chainCli, err := getChainByName(wInfo.Chain)
	if err != nil {
		return nil, err
	}
	ctx := context.Background()
	var value *big.Int
	var decimals uint8 = 18
	var symbol = chainCli.Symbol
	if wInfo.TokenContract != "" {
		tkn, err := chainCli.newERC20Token(wInfo.TokenContract)
		if err != nil {
			return nil, err
		}
		value, err = tkn.inst.BalanceOf(nil, common.HexToAddress(wInfo.Address))
		if err != nil {
			return nil, err
		}
		decimals = tkn.decimal
		symbol = tkn.symbol

	} else {
		value, err = chainCli.cli.BalanceAt(ctx, common.HexToAddress(wInfo.Address), nil)
		if err != nil {
			return nil, err
		}
	}
	//balance in ether
	t = &balance{
		contract: wInfo.TokenContract,
		symbol:   symbol,
		decimal:  decimals,
		value:    value,
	}
	return t, nil
}

func slackNotify(txt string) {
	if cfg.Slack == "" {
		return
	}
	msg := slack.WebhookMessage{
		Text: txt,
	}
	err := slack.PostWebhook(cfg.Slack, &msg)
	if err != nil {
		log.Println(err)
	}
}

func notifySummary(t time.Time) (notify bool) {
	info := summary()
	cur := t.Truncate(1 * time.Hour)
	hours := cur.Sub(lastNotifySummary).Hours()
	if lastNotifySummary.IsZero() ||
		(hours > 0 && slices.Contains(cfg.SummaryTime, cur.Hour())) {
		notify = true
		slackNotify(info)
		lastNotifySummary = cur
	}
	log.Println(info)
	return
}

func compare(o OpEnum, a, b float64) bool {
	switch o {
	case OpLt:
		return a < b
	case OpLe:
		return a <= b
	case OpEq:
		return a == b
	case OpNe:
		return a != b
	case OpGe:
		return a >= b
	case OpGt:
		return a > b
	}
	return false
}

func lookupNotifyMsg(t string) string {
	if notifyTypeMessage[t] == "" {
		return notifyTypeMessage["warning"]
	}
	return notifyTypeMessage[t]
}
