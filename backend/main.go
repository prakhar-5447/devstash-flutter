package main

import (
	"github.com/prakhar-5447/db"
	"github.com/prakhar-5447/router"
	"github.com/prakhar-5447/util"
	"github.com/rs/zerolog/log"
)

func main() {
	config, err := util.LoadConfig(".")
	if err != nil {
		log.Fatal().Err(err).Msg("cannot load config")
	}

	store, err := db.NewStore(config.MONGODB_URI, config.DATABASE_NAME)
	if err != nil {
		log.Fatal().Msgf("cannot create MongoDB store: %v", err)
	}

	runGinServer(config, store)
}

func runGinServer(config util.Config, store db.Store) {
	server, err := router.NewServer(config, store)
	if err != nil {
		log.Fatal().Err(err).Msg("cannot create server")
	}

	err = server.Start(config.HTTP_SERVER_ADDRESS)
	if err != nil {
		log.Fatal().Err(err).Msg("cannot start server")
	}
}
