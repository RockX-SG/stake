package main

import (
	"fmt"
	"math"
	"math/big"
	"time"
)

type OpEnum string

const (
	OpLt OpEnum = "lt"
	OpLe OpEnum = "le"
	OpEq OpEnum = "eq"
	OpNe OpEnum = "ne"
	OpGe OpEnum = "ge"
	OpGt OpEnum = "gt"
)

type balance struct {
	contract string // token contract address, if it is not a token, it is empty
	symbol   string
	decimal  uint8
	value    *big.Int
}

func (t *balance) String() string {
	return fmt.Sprintf("%0.6f %s", t.Float(), t.symbol)
}

func (t *balance) Float() float64 {
	a := new(big.Float).SetInt(t.value)
	b := new(big.Float).SetInt64(int64(math.Pow10(int(t.decimal))))
	f, _ := new(big.Float).Quo(a, b).Float64()
	return f
}

type watchInfo struct {
	Name          string  `yaml:"name"`
	Chain         string  `yaml:"chain"`
	Address       string  `yaml:"address"`
	Op            OpEnum  `yaml:"op"`
	Balance       float64 `yaml:"balance"`
	TokenContract string  `yaml:"token_contract"`
	NotifyType    string  `yaml:"notify_type"` //default: warning
}

type config struct {
	Slack       string        `yaml:"slack"`        //notify
	CheckTime   time.Duration `yaml:"check_time"`   // 1m
	SummaryTime []int         `yaml:"summary_time"` // [1, 10]: at 09:00 and 18:00 summary notify
	ChainList   []chainInfo   `yaml:"chain_list"`
	WatchList   []watchInfo   `yaml:"watch_list"` //
}
