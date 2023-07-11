package db

import (
	"go.mongodb.org/mongo-driver/mongo"
)

type Queries struct {
	usersCollection  *mongo.Collection
	projectssCollection  *mongo.Collection
	imagesCollection *mongo.Collection
}

func NewQueries(database *mongo.Database) *Queries {
	return &Queries{
		usersCollection:  database.Collection("users"),
		projectssCollection:  database.Collection("projects"),
		imagesCollection: database.Collection("fs.files"),
	}
}
