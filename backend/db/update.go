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
func (q *Queries) UpdateUserProile(ctx context.Context, user *User) bool {
	filter := bson.M{"_id": user.ID}
	update := bson.M{}

	// Only include the fields that need to be updated
	if user.Name != "" {
		update["name"] = user.Name
	}
	if user.Email != "" {
		update["email"] = user.Email
	}
	if user.Phone != "" {
		update["phone"] = user.Phone
	}
	if user.Description != "" {
		update["description"] = user.Description
	}

	result, err := q.usersCollection.UpdateOne(ctx, filter, bson.M{"$set": update})
	if err != nil {
		return false
	}

	return result.ModifiedCount > 0
}
