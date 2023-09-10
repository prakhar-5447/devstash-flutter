package db

import (
	"context"

	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/bson/primitive"
)

func (store *MongoDBStore) FCMToken(ctx context.Context, fcmtoken *FCMToken) error {
	_, err := store.GetCollection("fcmtoken").InsertOne(ctx, fcmtoken)
	if err != nil {
		return err
	}

	return nil
}

func (store *MongoDBStore) GetFCMToken(ctx context.Context, userID primitive.ObjectID) (*FCMToken, error) {
	var token FCMToken
	err := store.GetCollection("fcmtoken").FindOne(ctx, bson.M{"userid": userID}).Decode(&token)
	if err != nil {
		return nil, err
	}

	return &token, nil
}
