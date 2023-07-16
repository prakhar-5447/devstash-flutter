package db

import (
	"go.mongodb.org/mongo-driver/mongo"
)

type Queries struct {
	usersCollection    *mongo.Collection
	projectsCollection *mongo.Collection
	imagesCollection   *mongo.Collection
	favoriteCollection *mongo.Collection
	bookmarkCollection *mongo.Collection
}

func NewQueries(database *mongo.Database) *Queries {
	return &Queries{
		usersCollection:    database.Collection("users"),
		projectsCollection: database.Collection("projects"),
		imagesCollection:   database.Collection("fs.files"),
		favoriteCollection: database.Collection("favorite"),
		bookmarkCollection: database.Collection("bookmark"),
	}
}
