package db

import (
	"context"
	"errors"

	"go.mongodb.org/mongo-driver/bson"
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

func (store *MongoDBStore) GetMessagesByUserID(ctx context.Context, userID primitive.ObjectID) ([]*Message, error) {
	var messages []*Message
	cursor, err := store.GetCollection("messages").Find(ctx, bson.M{"userid": userID})
	if err != nil {
		return nil, err
	}

	defer cursor.Close(ctx)

	for cursor.Next(ctx) {
		var message Message
		if err := cursor.Decode(&message); err != nil {
			return nil, err
		}
		messages = append(messages, &message)
	}

	return messages, nil
}