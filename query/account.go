package query

import (
	"fmt"

	"github.com/xuperchain/xuper-sdk-go/account"
	"github.com/xuperchain/xuper-sdk-go/v2/xuper"
)

/*
	查询账户余额

@Params client 客户端
@Params account 普通账户
*/
func QueryAccountBalance(client *xuper.XClient, acc *account.Account) {
	balance, err := client.QueryBalance(acc.Address)
	if err != nil {
		fmt.Printf("err: %v\n", err)
		return
	}
	fmt.Printf("balance: %v\n", balance)
}

/*
	查询该合约账户部署的合约

@Params client 客户端
@Params accoutName 合约账户名称
*/
func QueryAccountContracts(client *xuper.XClient, accountName string) {
	pb, err := client.QueryAccountContracts(accountName)
	if err != nil {
		fmt.Printf("err: %v\n", err)
		return
	}
	fmt.Printf("pb: %v\n", pb)
}

/*
	查询股东权重 , 以及股东的地址
	查询该合约账户的ACL: 股东投票机制

@Params client 客户端
@Params accoutName 合约账户名称
*/
func QueryAccountAcl(client *xuper.XClient, accountName string) {
	acl, err := client.QueryAccountACL(accountName)
	if err != nil {
		fmt.Printf("err: %v\n", err)
		return
	}
	fmt.Printf("acl: %v\n", acl)
}

/*
	查询该普通账户下所管理的合约账户
	AK : 一组公私钥对 addres是通过公钥经过散列算法得出的

@Params client 客户端
@Params address 普通账户的地址
*/
func QueryAccount(client *xuper.XClient, address string) {
	acc, err := client.QueryAccountByAK(address)
	if err != nil {
		fmt.Printf("err: %v\n", err)
		return
	}
	fmt.Printf("acc: %v\n", acc)
}
