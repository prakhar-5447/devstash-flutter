package db

import (
	"go.mongodb.org/mongo-driver/mongo"
)

type Queries struct {
	usersCollection *mongo.Collection
}

func NewQueries(database *mongo.Database) *Queries {
	return &Queries{
		usersCollection: database.Collection("devstash"),
	}
}