package db

import (
	"context"
	"errors"

	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/bson/primitive"
	"go.mongodb.org/mongo-driver/mongo"
)

func (q *Queries) CreateContact(ctx context.Context, contact Contact) error {
	_, err := q.contactCollection.InsertOne(ctx, contact)
	return err
}

func (store *MongoDBStore) UpdateContact(ctx context.Context, ID primitive.ObjectID, contact Contact) error {
	// Try to update the user document, if not found, insert a new one
	filter := bson.M{"userid": ID}
	update := bson.M{"$set": contact}

	_, err := store.GetCollection("contact").UpdateOne(ctx, filter, update)
	if err != nil {
		return err
	}
	return nil
}

func (store *MongoDBStore) FindContact(ctx context.Context, userID primitive.ObjectID) (Contact, error) {
	var result Contact

	filter := bson.M{"userid": userID}

	err := store.GetCollection("contact").FindOne(ctx, filter).Decode(&result)
	if err != nil {
		if errors.Is(err, mongo.ErrNoDocuments) {
			// If no contact document found, return an empty Contact struct without error
			return Contact{}, nil
		}
		return Contact{}, err
	}

	return result, nil
}
