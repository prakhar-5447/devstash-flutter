package db

import (
	"context"
	"net/http"

	"github.com/prakhar-5447/models"
	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/bson/primitive"
	"go.mongodb.org/mongo-driver/mongo"
)

func (store *MongoDBStore) FindUserByUsername(ctx context.Context, username string) (*User, error) {
	var user User
	err := store.GetCollection("users").FindOne(ctx, bson.M{"username": username}).Decode(&user)
	if err != nil {
		return nil, err
	}
	return &user, nil
}

// Implement other find-related query methods here
func (store *MongoDBStore) CheckUserByEmail(ctx context.Context, email string) (bool, error) {
	filter := bson.M{"email": email}
	count, err := store.GetCollection("users").CountDocuments(ctx, filter)
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
	count, err := store.GetCollection("users").CountDocuments(ctx, filter)
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
	err := store.GetCollection("users").FindOne(ctx, filter).Decode(user)
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

func (store *MongoDBStore) GetUserFavoritesByID(ctx context.Context, userID primitive.ObjectID) (*Favorite, error) {
	var favorite Favorite
	filter := bson.M{"userId": userID}
	err := store.GetCollection("favorite").FindOne(ctx, filter).Decode(&favorite)
	if err != nil {
		return nil, err
	}

	return &favorite, nil
}

func (store *MongoDBStore) GetUserBookmarksByID(ctx context.Context, userID primitive.ObjectID) (*Bookmark, error) {
	var bookmark Bookmark
	filter := bson.M{"userId": userID}
	err := store.GetCollection("bookmark").FindOne(ctx, filter).Decode(&bookmark)
	if err != nil {
		return nil, err
	}

	return &bookmark, nil
}

func (store *MongoDBStore) GetUserByID(ctx context.Context, userID primitive.ObjectID) (*User, error) {
	var user User

	// Get the user from the users collection using the provided userID
	err := store.GetCollection("users").FindOne(ctx, bson.M{"_id": userID}).Decode(&user)
	if err != nil {
		if err == mongo.ErrNoDocuments {
			// User not found
			return nil, err
		}
		// Other error occurred
		return nil, err
	}

	return &user, nil
}
