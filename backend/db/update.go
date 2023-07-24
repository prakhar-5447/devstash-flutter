package db

import (
	"context"

	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/bson/primitive"
	"go.mongodb.org/mongo-driver/mongo"
)

func (store *MongoDBStore) UpdateUser(ctx context.Context, user *User) error {
	filter := bson.M{"_id": user.ID}
	update := bson.M{"$set": user}
	_, err := store.GetCollection("users").UpdateOne(ctx, filter, update)
	return err
}

// Implement other update-related query methods here
func (store *MongoDBStore) UpdateUserProfile(ctx context.Context, user *User) bool {
	filter := bson.M{"_id": user.ID}
	update := bson.M{}

	// Only include the fields that need to be updated
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
	if user.Phone != "" {
		update["phone"] = user.Phone
	}
	if user.Description != "" {
		update["description"] = user.Description
	}

	result, err := store.GetCollection("users").UpdateOne(ctx, filter, bson.M{"$set": update})
	if err != nil {
		return false
	}

	return result.ModifiedCount > 0
}

func (store *MongoDBStore) AddFavorite(ctx context.Context, userID primitive.ObjectID, projectId primitive.ObjectID) (bool, error) {
	// Check if the user document already exists
	var user Favorite
	err := store.GetCollection("favorite").FindOne(ctx, bson.M{"userId": userID}).Decode(&user)
	if err != nil {
		if err == mongo.ErrNoDocuments {
			// User document does not exist, create a new user document with the project IDs
			user = Favorite{
				UserId:     userID,
				ProjectIds: []primitive.ObjectID{projectId},
			}
			_, err = store.GetCollection("favorite").InsertOne(ctx, user)
			if err != nil {
				return false, err
			}
			return true, nil
		}
		return false, err
	}

	// Update the user document with the updated project IDs
	query := bson.M{"$addToSet": bson.M{"projectIds": projectId}}
	_, err = store.GetCollection("favorite").UpdateOne(ctx, bson.M{"userId": userID}, query)
	if err != nil {
		return false, err
	}

	return true, nil
}

func (store *MongoDBStore) RemoveFavorite(ctx context.Context, userID primitive.ObjectID, projectID primitive.ObjectID) (bool, error) {
	// Check if the user document exists
	var user Favorite
	err := store.GetCollection("favorite").FindOne(ctx, bson.M{"userId": userID}).Decode(&user)
	if err != nil {
		if err == mongo.ErrNoDocuments {
			// User document doesn't exist, return without making any changes
			return false, nil
		}
		return false, err
	}

	// Find the index of the project ID in the ProjectIDs slice
	index := -1
	for i, id := range user.ProjectIds {
		if id == projectID {
			index = i
			break
		}
	}

	// If the project ID is found, remove it from the slice
	if index != -1 {
		user.ProjectIds = append(user.ProjectIds[:index], user.ProjectIds[index+1:]...)
	} else {
		// Project ID not found, return without making any changes
		return false, nil
	}

	// Update the user document with the updated project IDs
	_, err = store.GetCollection("favorite").UpdateOne(ctx, bson.M{"userId": userID}, bson.M{"$set": bson.M{"projectIds": user.ProjectIds}})
	if err != nil {
		return false, err
	}

	return true, nil
}

func (store *MongoDBStore) AddUserToBookmark(ctx context.Context, userID primitive.ObjectID, otherUserId primitive.ObjectID) (bool, error) {
	// Check if the user document exists
	var user Bookmark
	err := store.GetCollection("bookmark").FindOne(ctx, bson.M{"userId": userID}).Decode(&user)
	if err != nil {
		if err == mongo.ErrNoDocuments {
			// User document doesn't exist, create a new user document with the other user ID
			user = Bookmark{
				UserId:       userID,
				OtherUserIds: []primitive.ObjectID{otherUserId},
			}
			_, err = store.GetCollection("bookmark").InsertOne(ctx, user)
			if err != nil {
				return false, err
			}
			return true, nil
		}
		return false, err
	}

	// Update the user document with the updated other user IDs
	query := bson.M{"$addToSet": bson.M{"otherUserIds": otherUserId}}
	_, err = store.GetCollection("bookmark").UpdateOne(ctx, bson.M{"userId": userID}, query)
	if err != nil {
		return false, err
	}

	return true, nil
}

func (store *MongoDBStore) RemoveUserFromBookmark(ctx context.Context, userID primitive.ObjectID, otherUserId primitive.ObjectID) (bool, error) {
	// Check if the user document exists
	var user Bookmark
	err := store.GetCollection("bookmark").FindOne(ctx, bson.M{"userId": userID}).Decode(&user)
	if err != nil {
		if err == mongo.ErrNoDocuments {
			// User document doesn't exist, return without making any changes
			return false, nil
		}
		return false, err
	}

	// Find the index of the other user ID in the OtherUserIDs slice
	index := -1
	for i, id := range user.OtherUserIds {
		if id == otherUserId {
			index = i
			break
		}
	}

	// If the other user ID is found, remove it from the slice
	if index != -1 {
		user.OtherUserIds = append(user.OtherUserIds[:index], user.OtherUserIds[index+1:]...)
	} else {
		// Other user ID not found, return without making any changes
		return false, nil
	}

	// Update the user document with the updated other user IDs
	_, err = store.GetCollection("bookmark").UpdateOne(ctx, bson.M{"userId": userID}, bson.M{"$set": bson.M{"otherUserIds": user.OtherUserIds}})
	if err != nil {
		return false, err
	}

	return true, nil
}
