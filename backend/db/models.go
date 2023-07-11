package db

import (
	"go.mongodb.org/mongo-driver/bson/primitive"
)

type User struct {
	ID   primitive.ObjectID `bson:"_id,omitempty"`
	Name string             `bson:"name"`
}

type ProjectType string

const (
	Web     ProjectType = "Web"
	Android ProjectType = "Android"
	Other   ProjectType = "Other"
)

type Project struct {
	ID              primitive.ObjectID   `bson:"_id,omitempty"`
	Image           string               `bson:"image"`
	Title           string               `bson:"title"`
	Description     string               `bson:"description"`
	CreatedDate     primitive.DateTime   `bson:"createdDate"`
	Technologies    []string             `bson:"technologies"`
	CollaboratorsID []primitive.ObjectID `bson:"collaboratorsID"`
	ProjectType     ProjectType          `bson:"projectType"`
	Hashtags        []string             `bson:"hashtags"`
}
