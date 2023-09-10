package util

import (
	"github.com/spf13/viper"
)

type Config struct {
	MONGODB_URI          string `mapstructure:"MONGODB_URI"`
	DATABASE_NAME        string `mapstructure:"DATABASE_NAME"`
	TOKEN_SYMMETRIC_KEY  string `mapstructure:"TOKEN_SYMMETRIC_KEY"`
	HTTP_SERVER_ADDRESS  string `mapstructure:"HTTP_SERVER_ADDRESS"`
	FIREBASE_CREDENTIALS string `mapstructure:"FIREBASE_CREDENTIALS"`
	TOKEN_EXPIRATION     int    `mapstructure:"TOKEN_EXPIRATION"`
}

func LoadConfig(path string) (config Config, err error) {
	viper.AddConfigPath(path)
	viper.SetConfigName("app")
	viper.SetConfigType("env")

	viper.AutomaticEnv()

	err = viper.ReadInConfig()
	if err != nil {
		return
	}

	err = viper.Unmarshal(&config)
	return
}
