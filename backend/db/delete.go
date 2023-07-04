package db

import (
	"context"
	"go.mongodb.org/mongo-driver/bson"
)

func (q *Queries) DeleteUser(ctx context.Context, userID string) error {
	_, err := q.usersCollection.DeleteOne(ctx, bson.M{"_id": userID})
	return err
}

// Implement other delete-related query methods here
