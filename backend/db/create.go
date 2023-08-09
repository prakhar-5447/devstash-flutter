package db

import (
	"context"

	"go.mongodb.org/mongo-driver/bson/primitive"
)

func (q *Queries) CreateUser(ctx context.Context, user *User) (primitive.ObjectID, error) {
	res, err := q.usersCollection.InsertOne(ctx, user)
	if err != nil {
		return primitive.NilObjectID, err
	}
	return res.InsertedID.(primitive.ObjectID), nil
}
