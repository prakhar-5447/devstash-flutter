package db

import (
	"context"
	"net/http"

	"github.com/prakhar-5447/models"
	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/bson/primitive"
	"go.mongodb.org/mongo-driver/mongo"
)

func (q *Queries) Create_User(ctx context.Context, user *User) (primitive.ObjectID, error) {
	res, err := q.usersCollection.InsertOne(ctx, user)
	if err != nil {
		return primitive.NilObjectID, err
	}
	return res.InsertedID.(primitive.ObjectID), nil
}

func (store *MongoDBStore) Find_User_By_UserId(ctx context.Context, userId primitive.ObjectID) (*User, error) {
	var user User
	err := store.GetCollection("users").FindOne(ctx, bson.M{"_id": userId}).Decode(&user)
	if err != nil {
		return nil, err
	}
	return &user, nil
}

func (store *MongoDBStore) Get_User_By_Id(ctx context.Context, userID primitive.ObjectID) (*User, error) {
	var user User

	err := store.GetCollection("users").FindOne(ctx, bson.M{"_id": userID}).Decode(&user)
	if err != nil {
		if err == mongo.ErrNoDocuments {
			return nil, err
		}
		return nil, err
	}

	return &user, nil
}

func (store *MongoDBStore) Check_User_By_Email(ctx context.Context, email string) (bool, error) {
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

func (store *MongoDBStore) Check_User_By_Username(ctx context.Context, username string) (bool, error) {
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

func (store *MongoDBStore) Find_User_By_Username_Or_Email(ctx context.Context, usernameOrEmail string) (*User, error) {
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

	return user, nil
}

func (store *MongoDBStore) Update_User(ctx context.Context, user *User) error {
	filter := bson.M{"_id": user.ID}
	update := bson.M{"$set": user}
	_, err := store.GetCollection("users").UpdateOne(ctx, filter, update)
	return err
}

func (store *MongoDBStore) Update_Avatar(ctx context.Context, avatar string, userID primitive.ObjectID) error {
	filter := bson.M{"_id": userID}
	update := bson.M{"$set": bson.M{"avatar": avatar}}
	_, err := store.GetCollection("users").UpdateOne(ctx, filter, update)
	return err
}

func (store *MongoDBStore) Update_User_Profile(ctx context.Context, user *User) bool {
	filter := bson.M{"_id": user.ID}
	update := bson.M{}

	if user.Name != "" {
		update["name"] = user.Name
	}
	if user.Avatar != "" {
		update["avatar"] = user.Avatar
	}
	if user.Username != "" {
		update["username"] = user.Username
	}
	if user.Email != "" {
		update["email"] = user.Email
	}
	if user.Description != "" {
		update["description"] = user.Description
	}
	if user.Username != "" {
		update["username"] = user.Username
	}

	result, err := store.GetCollection("users").UpdateOne(ctx, filter, bson.M{"$set": update})
	if err != nil {
		return false
	}

	return result.ModifiedCount > 0
}

func (q *Queries) Delete_User(ctx context.Context, userID string) error {
	_, err := q.usersCollection.DeleteOne(ctx, bson.M{"_id": userID})
	return err
}
