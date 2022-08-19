package main

import (
	"errors"
	"fmt"
	_ "go_example/conf"
	q "go_example/query"

	"github.com/spf13/viper"
	"github.com/xuperchain/xuper-sdk-go/account"
	"github.com/xuperchain/xuper-sdk-go/v2/xuper"
)

var (
	node         = fmt.Sprintf("%s:%s", viper.GetString("add.ip"), viper.GetString("add.port")) // ip:port
	contractName = viper.GetString("contract.name")                                             // 合约名
	mnemonic     = viper.GetString("account.mnemonic")                                          //账户的助记词
	acc          = &account.Account{}
	client       = &xuper.XClient{}
	err          = errors.New("")
)

func init() {
	//通过助记词还原合约账号
	acc, err = account.RetrieveAccount(mnemonic, 2)
	if err != nil {
		fmt.Printf("restore account fial err: %v\n", err)
		return
	}
	//新建一个客户端
	client, err = xuper.New(node)
	if err != nil {
		fmt.Printf("client connect fail  err: %v\n", err)
		return
	}
}

func main() {
	q.QueryAccountBalance(client, acc)
	q.QueryAccountContracts(client, "XC1111111111111111@xuper")
	q.QueryAccountAcl(client, "XC2222222222222222@xuper")
	q.QueryAccount(client, "TeyyPLpp9L7QAcxHangtcHTu7HUZ6iydY")
}
