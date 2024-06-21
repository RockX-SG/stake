# balance monitor

## feature
The Balance Monitor :
    
    1. Daily summary report;
    2. Monitored min balance(0.01 ~ 0.1 ether) of all executors;
    3. Monitored max balance(0 ether) of all CelerMinterSenders (should be 0, otherwise there are refunds);
    4. Monitored max balance(1 ether) of CelerMinterReceiver (indicates high transaction volume, accumulating more gas fees);
    5. Monitored totalSupply of erc20 token address;

## usage
```
test:
    make test
build:
    make build
run:
    ./bin/balance-monitor -c ./config.yaml

```

## how to config
config.yaml
```

#if not empty, will send message notify to slack
slack: "" 

#how many frequece to run
check_time: 60s 

# summary notify time in UTC
summary_time: [01, 10] 

#chains list config, watch_list referer the name.
chain_list:
  - { chain_id: 1, name: "Ethereum", symbol: "ETH", native: true, endpoint: "https://ethereum-rpc.publicnode.com", explorer: "https://etherscan.io/" }

#watch address list and alert
#op is one of lt, le, ge, gt, compare with balance.
watch_list:
  - { name: "address_name" , address: "0x1234567890" , op: "lt", balance: 0.1 , chain: "Ethereum"} # the balance < 0.1 will alert to slack.


```