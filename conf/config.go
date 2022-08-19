package conf

import (
	"os"
	"path"

	"github.com/spf13/viper"
)

func init() {
	dir, _ := os.Getwd()          //获取当前目录,一般是 main.go所在的目录
	viper.SetConfigName("config") //设置配置文件的名称
	viper.SetConfigType("yml")    //设置文件的类型
	dir = path.Join(dir, "conf")  // 拼接路径
	viper.AddConfigPath(dir)      // 添加文件路径
	err := viper.ReadInConfig()   // 读取配置文件
	if err != nil {
		panic(err)
	}
}
