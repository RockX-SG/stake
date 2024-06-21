package main

import (
	"math/big"
	"testing"
	"time"
)

func Test_notifySummary(t *testing.T) {
	cfg.CheckTime = 60 * time.Second
	cfg.SummaryTime = []int{1, 10}
	baseTime := time.Date(2024, 01, 01, 00, 01, 01, 0, time.UTC)
	tests := []struct {
		name       string
		t          time.Time
		wantNotify bool
	}{
		// the first start time/ every day at 9 hours/ every day at 18 hours in UTC+8 should notify
		{name: "01", t: baseTime, wantNotify: true},
		{name: "02", t: baseTime.Add(1 * time.Minute), wantNotify: false},
		{name: "03", t: baseTime.Add(1 * time.Hour), wantNotify: true},
		{name: "04", t: baseTime.Add(2 * time.Hour), wantNotify: false},
		{name: "05", t: baseTime.Add(3 * time.Hour), wantNotify: false},
		{name: "06", t: baseTime.Add(4 * time.Hour), wantNotify: false},
		{name: "07", t: baseTime.Add(5 * time.Hour), wantNotify: false},
		{name: "08", t: baseTime.Add(10 * time.Hour), wantNotify: true},
		{name: "09", t: baseTime.Add(18 * time.Hour), wantNotify: false},
		{name: "10", t: baseTime.Add(25 * time.Hour), wantNotify: true},
		{name: "11", t: baseTime.Add(32 * time.Hour), wantNotify: false},
	}
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			got := notifySummary(tt.t)
			if got != tt.wantNotify {
				t.Fatalf("%s want: %v but got: %v", tt.name, tt.wantNotify, got)
			}
		})
	}
}

func Test_balance_Float(t1 *testing.T) {

	tests := []struct {
		name string
		b    *balance
		want float64
	}{
		// TODO: Add test cases.
		{name: "", b: &balance{
			symbol:  "OKB",
			decimal: uint8(18),
			value:   big.NewInt(1e17),
		}, want: 0.1},
	}
	for _, tt := range tests {
		t1.Run(tt.name, func(t1 *testing.T) {
			if got := tt.b.Float(); got != tt.want {
				t1.Errorf("Float() = %v, want %v", got, tt.want)
			}
		})
	}
}
