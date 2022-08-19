package invoke

import (
	"fmt"

	"github.com/xuperchain/xuper-sdk-go/v2/account"
	"github.com/xuperchain/xuper-sdk-go/v2/xuper"
)

/*
	获取主席的地址

@Params client 客户端
@Params acc  普通账户
@Params 合约名
*/
func InvokeChairperson(client *xuper.XClient, acc *account.Account, contractName string) {
	args := map[string]string{}
	tx, err := client.InvokeEVMContract(acc, contractName, "chairperson", args)
	if err != nil {
		fmt.Printf("err: %v\n", err)
		return
	}
	fmt.Printf("tx.ContractResponse: %v\n", tx.ContractResponse)
	fmt.Printf("tx.Tx.Txid: %v\n", tx.Tx.Txid)
}

/*
	给其他账户授权,只有主席有这个权限

@Params client 客户端
@Params acc  普通账户
@Params 合约名
*/
func InvokegiveRightToVote(client *xuper.XClient, acc *account.Account, contractName string) {
	args := map[string]string{
		"voter": "fcXuP6whQ4UymairVTdRtN5iDFbqyn1F8",
	}
	tx, err := client.InvokeEVMContract(acc, contractName, "giveRightToVote", args)
	if err != nil {
		fmt.Printf("err: %v\n", err)
		return
	}
	fmt.Printf("tx.ContractResponse: %v\n", tx.ContractResponse)
	fmt.Printf("tx.Tx.Txid: %v\n", tx.Tx.Txid)
}
