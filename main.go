package main

import (
	"fmt"
	_ "go_example/conf"

	"github.com/spf13/viper"
	"github.com/xuperchain/xuper-sdk-go/account"
	"github.com/xuperchain/xuper-sdk-go/v2/xuper"
)

var (
	node         = fmt.Sprintf("%s:%s", viper.GetString("add.ip"), viper.GetString("add.port"))
	contractName = viper.GetString("contract.name")
)

func main() {
	acc, err := account.RetrieveAccount(viper.GetString("account.mnemonic"), 2)
	if err != nil {
		fmt.Printf("err: %v\n", err)
		return
	}
	client, err := xuper.New(node)
	if err != nil {
		fmt.Printf("err: %v\n", err)
		return
	}
	fmt.Printf("node: %v\n", node)
	fmt.Printf("contractName: %v\n", contractName)
	pb, err := client.QueryAccountContracts("XC1111111111111111@xuper")
	if err != nil {
		fmt.Printf("err: %v\n", err)
		return
	}
	fmt.Printf("pb: %v\n", pb)
	balance, err := client.QueryBalance(acc.Address)
	if err != nil {
		fmt.Printf("err: %v\n", err)
		return
	}
	fmt.Printf("balance: %v\n", balance)
}
