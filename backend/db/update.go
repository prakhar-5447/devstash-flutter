package db

import (
	"context"
	"go.mongodb.org/mongo-driver/bson"
)

func (q *Queries) UpdateUser(ctx context.Context, user *User) error {
	filter := bson.M{"_id": user.ID}
	update := bson.M{"$set": user}
	_, err := q.usersCollection.UpdateOne(ctx, filter, update)
	return err
}

// Implement other update-related query methods here
