package main

import (
	"context"
	"fmt"
	"math/big"
	"net/url"
	"sync"
	"time"

	"balance-monitor/token"

	"github.com/ethereum/go-ethereum/accounts/abi/bind"
	"github.com/ethereum/go-ethereum/common"
	"github.com/ethereum/go-ethereum/ethclient"
)

type chainInfo struct {
	ChainId  int    `yaml:"chain_id"`
	Name     string `yaml:"name"`
	Symbol   string `yaml:"symbol"`
	Endpoint string `yaml:"endpoint"`
	Explorer string `yaml:"explorer"`
}

type chain struct {
	cli *ethclient.Client
	chainInfo
}

var (
	_chains     = map[int]*chain{} //chain_id => chain
	_chainsLock = sync.RWMutex{}
)

func initChain(arr []chainInfo) error {
	_chainsLock.Lock()
	defer _chainsLock.Unlock()
	ctx, _ := context.WithDeadline(context.Background(), time.Now().Add(10*time.Second))
	for _, info := range arr {
		cli, err := ethclient.DialContext(ctx, info.Endpoint)
		if err != nil {
			return err
		}

		c := &chain{
			chainInfo: info, cli: cli,
		}
		_chains[info.ChainId] = c
	}
	return nil
}

// getChainByName returns the chain instance for the given chain name. If the chain is not found,
// it returns an error.
func getChainByName(name string) (*chain, error) {
	_chainsLock.RLock()
	defer _chainsLock.RUnlock()
	for id, info := range _chains {
		if info.Name == name {
			return _chains[id], nil
		}
	}
	return nil, fmt.Errorf("chain name(%s) not found", name)
}

func (c *chain) getAddressURL(addr string) (u string, err error) {
	u, err = url.JoinPath(c.Explorer, "/address/", addr)
	return
}

func (c *chain) getTokenURL(addr string) (u string, err error) {
	u, err = url.JoinPath(c.Explorer, "/token/", addr)
	return
}

type ERC20Token struct {
	inst        *token.Token
	addr        common.Address
	symbol      string
	decimal     uint8
	totalSupply *big.Int
}

func (c *chain) newERC20Token(addr string) (*ERC20Token, error) {
	contract := common.HexToAddress(addr)
	inst, err := token.NewToken(contract, c.cli)
	if err != nil {
		return nil, err
	}

	tkn := &ERC20Token{
		inst: inst,
		addr: contract,
	}
	var (
		symbol   string
		decimals uint8
	)
	opts := &bind.CallOpts{BlockNumber: nil}
	symbol, err = tkn.inst.Symbol(opts)
	if err != nil {
		return nil, err
	}
	decimals, err = tkn.inst.Decimals(opts)
	if err != nil {
		return nil, err
	}
	totalSupply, err := tkn.inst.TotalSupply(nil)
	if err != nil {
		return nil, err
	}
	tkn.symbol = symbol
	tkn.decimal = decimals
	tkn.totalSupply = totalSupply
	return tkn, nil
}
