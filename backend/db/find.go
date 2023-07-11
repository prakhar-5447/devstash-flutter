package db

import (
	"context"
	"net/http"

	"github.com/prakhar-5447/models"
	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/mongo"
)

func (q *Queries) FindUserByUsername(ctx context.Context, username string) (*User, error) {
	var user User
	err := q.usersCollection.FindOne(ctx, bson.M{"username": username}).Decode(&user)
	if err != nil {
		return nil, err
	}
	return &user, nil
}

// Implement other find-related query methods here
func (store *MongoDBStore) CheckUserByEmail(ctx context.Context, email string) (bool, error) {
	filter := bson.M{"email": email}
	count, err := store.collection.CountDocuments(ctx, filter)
	if err != nil {
		return false, err
	}

	if count > 0 {
		return true, &models.HTTPError{
			StatusCode: http.StatusConflict,
			Message:    "User with the same email already exists.",
		}
	}

	return false, nil
}

func (store *MongoDBStore) CheckUserByUsername(ctx context.Context, username string) (bool, error) {
	filter := bson.M{"username": username}
	count, err := store.collection.CountDocuments(ctx, filter)
	if err != nil {
		return false, err
	}

	if count > 0 {
		return true, &models.HTTPError{
			StatusCode: http.StatusConflict,
			Message:    "User with the same username already exists.",
		}
	}

	return false, nil
}

func (store *MongoDBStore) FindByUsernameOrEmail(ctx context.Context, usernameOrEmail string, password string) (*User, error) {
	filter := bson.M{"$or": []bson.M{
		{"username": usernameOrEmail},
		{"email": usernameOrEmail},
	}}
	user := &User{}
	err := store.collection.FindOne(ctx, filter).Decode(user)
	if err != nil {
		if err == mongo.ErrNoDocuments {
			return nil, &models.HTTPError{
				StatusCode: http.StatusUnauthorized,
				Message:    "Invalid username or email.",
			}
		}
		return nil, err
	}

	if user.Password != password {
		return nil, &models.HTTPError{
			StatusCode: http.StatusUnauthorized,
			Message:    "Invalid password.",
		}
	}

	return user, nil
}