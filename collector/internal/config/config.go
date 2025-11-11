package config

import (
	"time"

	"github.com/spf13/viper"
)

type Config struct {
	APIURL       string        `mapstructure:"api_url"`
	Assets       []string      `mapstructure:"assets"`
	TargetDSN    string        `mapstructure:"target_dsn"`
	QueueTopic   string        `mapstructure:"queue_topic"`
	PollInterval time.Duration `mapstructure:"poll_interval"`
}

func Load(prefix string) (Config, error) {
	v := viper.New()
	v.SetEnvPrefix(prefix)
	v.AutomaticEnv()
	v.SetDefault("poll_interval", "5m")

	var cfg Config
	err := v.Unmarshal(&cfg)
	return cfg, err
}


