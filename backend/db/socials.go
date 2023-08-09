package db

import (
	"context"
	"errors"

	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/bson/primitive"
	"go.mongodb.org/mongo-driver/mongo"
)

func (q *Queries) CreateSocials(ctx context.Context, socials *Socials) error {
	_, err := q.socialsCollection.InsertOne(ctx, socials)
	return err
}

// UpdateSocialsByUserID updates the Socials document for the given UserID with the provided social handles.
func (q *Queries) UpdateSocialsByUserID(ctx context.Context, userID primitive.ObjectID, socials Socials) error {
	filter := bson.M{"userid": userID}
	update := bson.M{
		"$set": bson.M{
			"twitter":   socials.Twitter,
			"github":    socials.Github,
			"linkedin":  socials.Linkedin,
			"instagram": socials.Instagram,
			"other":     socials.Other,
		},
	}

	_, err := q.socialsCollection.UpdateOne(ctx, filter, update)
	return err
}

// FindSocialsByUserID finds and returns the Socials document for the given UserID.
func (store *MongoDBStore) FindSocialsByUserID(ctx context.Context, userID primitive.ObjectID) (*Socials, error) {
	var socials Socials
	filter := bson.M{"userid": userID}

	err := store.GetCollection("socials").FindOne(ctx, filter).Decode(&socials)
	if err != nil {
		if errors.Is(err, mongo.ErrNoDocuments) {
			// If no socials document found, return nil without error
			return nil, nil
		}
		return nil, err
	}

	return &socials, nil
}
