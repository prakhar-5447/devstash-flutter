package db

import (
	"context"
)

func (q *Queries) CreateUser(ctx context.Context, user *User) error {
	_, err := q.usersCollection.InsertOne(ctx, user)
	return err
}
