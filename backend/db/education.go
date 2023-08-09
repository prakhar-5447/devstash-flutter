package db

import (
	"context"
	"errors"

	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/bson/primitive"
	"go.mongodb.org/mongo-driver/mongo"
)

// CreateEducation creates a new education entry in the education collection.
func (q *Queries) CreateEducation(ctx context.Context, education Education) error {
	_, err := q.educationCollection.InsertOne(ctx, education)
	return err
}

// UpdateEducationByUserID updates the education document for the given UserID with the provided education list.
// If no education document is found for the UserID, it creates a new one with the provided education list.
func (store *MongoDBStore) UpdateEducationByUserID(ctx context.Context, ID primitive.ObjectID, educationList Education) error {
	// Update the user document with the updated project IDs
	query := bson.M{"$set": educationList}
	_, err := store.GetCollection("educations").UpdateOne(ctx, bson.M{"_id": ID}, query)
	if err != nil {
		return err
	}
	return err
}

// FindEducationByUserID finds and returns the education list for the given UserID.
func (store *MongoDBStore) FindEducationByUserID(ctx context.Context, userID primitive.ObjectID) ([]Education, error) {
	var result []Education

	filter := bson.M{"userid": userID}

	cursor, err := store.GetCollection("educations").Find(ctx, filter)
	if err != nil {
		if errors.Is(err, mongo.ErrNoDocuments) {
			// If no education document found, return an empty list without error
			return []Education{}, nil
		}
		return nil, err
	}
	defer cursor.Close(ctx)

	for cursor.Next(ctx) {
		var edu Education
		if err := cursor.Decode(&edu); err != nil {
			return nil, err
		}
		result = append(result, edu)
	}

	if err := cursor.Err(); err != nil {
		return nil, err
	}

	return result, nil
}

// DeleteEducationByID deletes the education document with the given ID.
func (store *MongoDBStore) DeleteEducationByID(ctx context.Context, educationID primitive.ObjectID) error {
	filter := bson.M{"_id": educationID}

	_, err := store.GetCollection("educations").DeleteOne(ctx, filter)
	if err != nil {
		return err
	}
	return nil
}
