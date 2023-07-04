package db

import (
	"context"
	"go.mongodb.org/mongo-driver/bson"
)

func (q *Queries) FindUserByID(ctx context.Context, userID string) (*User, error) {
	var user User
	err := q.usersCollection.FindOne(ctx, bson.M{"_id": userID}).Decode(&user)
	if err != nil {
		return nil, err
	}
	return &user, nil
}

// Implement other find-related query methods here
