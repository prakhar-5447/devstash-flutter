package db

import (
	"context"

	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/bson/primitive"
	"go.mongodb.org/mongo-driver/mongo"
)

func (store *MongoDBStore) Add_Favorite(ctx context.Context, userID primitive.ObjectID, projectId primitive.ObjectID) (bool, error) {
	var user Favorite
	err := store.GetCollection("favorite").FindOne(ctx, bson.M{"userId": userID}).Decode(&user)
	if err != nil {
		if err == mongo.ErrNoDocuments {
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

	query := bson.M{"$addToSet": bson.M{"projectIds": projectId}}
	_, err = store.GetCollection("favorite").UpdateOne(ctx, bson.M{"userId": userID}, query)
	if err != nil {
		return false, err
	}

	return true, nil
}

func (store *MongoDBStore) Remove_Favorite(ctx context.Context, userID primitive.ObjectID, projectID primitive.ObjectID) (bool, error) {
	var user Favorite
	err := store.GetCollection("favorite").FindOne(ctx, bson.M{"userId": userID}).Decode(&user)
	if err != nil {
		if err == mongo.ErrNoDocuments {
			return false, nil
		}
		return false, err
	}

	index := -1
	for i, id := range user.ProjectIds {
		if id == projectID {
			index = i
			break
		}
	}

	if index != -1 {
		user.ProjectIds = append(user.ProjectIds[:index], user.ProjectIds[index+1:]...)
	} else {
		return false, nil
	}

	_, err = store.GetCollection("favorite").UpdateOne(ctx, bson.M{"userId": userID}, bson.M{"$set": bson.M{"projectIds": user.ProjectIds}})
	if err != nil {
		return false, err
	}

	return true, nil
}

func (store *MongoDBStore) Add_Bookmark(ctx context.Context, userID primitive.ObjectID, otherUserId primitive.ObjectID) (bool, error) {
	var user Bookmark
	err := store.GetCollection("bookmark").FindOne(ctx, bson.M{"userId": userID}).Decode(&user)
	if err != nil {
		if err == mongo.ErrNoDocuments {
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

	query := bson.M{"$addToSet": bson.M{"otherUserIds": otherUserId}}
	_, err = store.GetCollection("bookmark").UpdateOne(ctx, bson.M{"userId": userID}, query)
	if err != nil {
		return false, err
	}

	return true, nil
}

func (store *MongoDBStore) Remove_Bookmark(ctx context.Context, userID primitive.ObjectID, otherUserId primitive.ObjectID) (bool, error) {
	var user Bookmark
	err := store.GetCollection("bookmark").FindOne(ctx, bson.M{"userId": userID}).Decode(&user)
	if err != nil {
		if err == mongo.ErrNoDocuments {
			return false, nil
		}
		return false, err
	}

	index := -1
	for i, id := range user.OtherUserIds {
		if id == otherUserId {
			index = i
			break
		}
	}

	if index != -1 {
		user.OtherUserIds = append(user.OtherUserIds[:index], user.OtherUserIds[index+1:]...)
	} else {
		return false, nil
	}

	_, err = store.GetCollection("bookmark").UpdateOne(ctx, bson.M{"userId": userID}, bson.M{"$set": bson.M{"otherUserIds": user.OtherUserIds}})
	if err != nil {
		return false, err
	}

	return true, nil
}

func (store *MongoDBStore) Get_Favorite_By_Id(ctx context.Context, userID primitive.ObjectID) (*Favorite, error) {
	var favorite Favorite
	filter := bson.M{"userId": userID}
	err := store.GetCollection("favorite").FindOne(ctx, filter).Decode(&favorite)
	if err != nil {
		return nil, err
	}

	return &favorite, nil
}

func (store *MongoDBStore) Get_Bookmark_By_Id(ctx context.Context, userID primitive.ObjectID) (*Bookmark, error) {
	var bookmark Bookmark
	filter := bson.M{"userId": userID}
	err := store.GetCollection("bookmark").FindOne(ctx, filter).Decode(&bookmark)
	if err != nil {
		return nil, err
	}

	return &bookmark, nil
}

func (store *MongoDBStore) Check_Value_In_Array(ctx context.Context, userID primitive.ObjectID, arrayField string, value primitive.ObjectID) bool {
	switch arrayField {
	case "favorite":
		var user Favorite
		filter := bson.M{"userId": userID}
		err := store.GetCollection("favorite").FindOne(ctx, filter).Decode(&user)
		if err != nil {
			if err == mongo.ErrNoDocuments {
				return false
			}
			return false
		}

		for _, fav := range user.ProjectIds {
			if fav == value {
				return true
			}
		}
	case "bookmark":
		var user Bookmark
		filter := bson.M{"userId": userID}
		err := store.GetCollection("bookmark").FindOne(ctx, filter).Decode(&user)
		if err != nil {
			if err == mongo.ErrNoDocuments {
				return false
			}
			return false
		}

		for _, bm := range user.OtherUserIds {
			if bm == value {
				return true
			}
		}
	default:
		return false
	}

	return false
}
