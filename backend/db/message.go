package db

import (
	"context"
	"errors"

	"go.mongodb.org/mongo-driver/bson/primitive"
)

func (store *MongoDBStore) Create_Message(ctx context.Context, message *Message) (primitive.ObjectID, error) {
	result, err := store.GetCollection("messages").InsertOne(ctx, message)
	if err != nil {
		return primitive.NilObjectID, err
	}

	messageId, ok := result.InsertedID.(primitive.ObjectID)
	if !ok {
		return primitive.NilObjectID, errors.New("failed to convert inserted ID to ObjectID")
	}

	return messageId, nil
}
