package db

import (
	"go.mongodb.org/mongo-driver/mongo"
)

type Queries struct {
	usersCollection       *mongo.Collection
	projectsCollection    *mongo.Collection
	imagesCollection      *mongo.Collection
	favoriteCollection    *mongo.Collection
	bookmarkCollection    *mongo.Collection
	socialsCollection     *mongo.Collection
	educationCollection   *mongo.Collection
	userimageCollection   *mongo.Collection
	contactCollection     *mongo.Collection
	skillsCollection      *mongo.Collection
	connectionsCollection *mongo.Collection
	messagesCollection    *mongo.Collection
	fcmtokenCollection    *mongo.Collection
}

func NewQueries(database *mongo.Database) *Queries {
	return &Queries{
		usersCollection:       database.Collection("users"),
		projectsCollection:    database.Collection("projects"),
		imagesCollection:      database.Collection("fs.files"),
		favoriteCollection:    database.Collection("favorite"),
		bookmarkCollection:    database.Collection("bookmark"),
		socialsCollection:     database.Collection("socials"),
		educationCollection:   database.Collection("educations"),
		userimageCollection:   database.Collection("userimage"),
		contactCollection:     database.Collection("contact"),
		skillsCollection:      database.Collection("skills"),
		connectionsCollection: database.Collection("connections"),
		messagesCollection:    database.Collection("messages"),
		fcmtokenCollection:    database.Collection("fcmtoken"),
	}
}
