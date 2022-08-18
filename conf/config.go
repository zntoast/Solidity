package conf

import (
	"os"
	"path"

	"github.com/spf13/viper"
)

func init() {
	dir, _ := os.Getwd()
	viper.SetConfigName("config")
	viper.SetConfigType("yml")
	dir = path.Join(dir, "conf")
	viper.AddConfigPath(dir)
	err := viper.ReadInConfig()
	if err != nil {
		panic(err)
	}
}
