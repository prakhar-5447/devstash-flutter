package db

import (
	"context"

	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/bson/primitive"
)

func (store *MongoDBStore) AddFollowing(ctx context.Context, userID primitive.ObjectID, targetUserID primitive.ObjectID) error {
	following := Connections{
		UserId: userID,
		Follow: targetUserID,
	}
	_, err := store.GetCollection("connections").InsertOne(ctx, following)
	return err
}

func (store *MongoDBStore) RemoveFollowing(ctx context.Context, userID primitive.ObjectID, targetUserID primitive.ObjectID) error {
	filter := bson.M{"userID": userID, "targetID": targetUserID}
	_, err := store.GetCollection("connections").DeleteOne(ctx, filter)
	return err
}

func (store *MongoDBStore) GetFollowing(ctx context.Context, userID primitive.ObjectID) ([]primitive.ObjectID, error) {
	var results []Connections

	filter := bson.M{"userId": userID}
	cursor, err := store.GetCollection("connections").Find(ctx, filter)
	if err != nil {
		return nil, err
	}
	defer cursor.Close(ctx)

	for cursor.Next(ctx) {
		var following Connections
		if err := cursor.Decode(&following); err != nil {
			return nil, err
		}
		results = append(results, following)
	}
	if err := cursor.Err(); err != nil {
		return nil, err
	}

	var following []primitive.ObjectID
	for _, result := range results {
		following = append(following, result.Follow)
	}

	return following, nil
}

func (store *MongoDBStore) GetFollowers(ctx context.Context, userID primitive.ObjectID) ([]primitive.ObjectID, error) {
	var results []Connections

	filter := bson.M{"follow": userID}
	cursor, err := store.GetCollection("connections").Find(ctx, filter)
	if err != nil {
		return nil, err
	}
	defer cursor.Close(ctx)

	for cursor.Next(ctx) {
		var following Connections
		if err := cursor.Decode(&following); err != nil {
			return nil, err
		}
		results = append(results, following)
	}
	if err := cursor.Err(); err != nil {
		return nil, err
	}

	var followers []primitive.ObjectID
	for _, result := range results {
		followers = append(followers, result.UserId)
	}

	return followers, nil
}
