package router

import (
	"context"

	"firebase.google.com/go"
	"firebase.google.com/go/messaging"
	"github.com/rs/zerolog/log"
	"google.golang.org/api/option"
)

func (server *Server) sendNotification(subject, description, fcmtoken string) error {
	app, err := server.intializeFirebase()
	if err != nil {
		log.Fatal().Err(err).Msg("cannot load config")
		return err
	}

	client, err := app.Messaging(context.Background())
	if err != nil {
		return err
	}

	message := &messaging.Message{
		Notification: &messaging.Notification{
			Title: subject,
			Body:  description,
		},
		Token: fcmtoken,
	}

	_, err = client.Send(context.Background(), message)
	return err
}

func (server *Server) intializeFirebase() (*firebase.App, error) {
	opt := option.WithCredentialsFile(server.config.FIREBASE_CREDENTIALS)
	app, err := firebase.NewApp(context.Background(), nil, opt)
	if err != nil {
		log.Fatal().Err(err).Msg("cannot initialize Firebase Admin SDK")
		return nil, err
	}
	return app, nil
}
