package db

import (
	"go.mongodb.org/mongo-driver/bson/primitive"
)

type User struct {
	ID          primitive.ObjectID `bson:"_id,omitempty"`
	Name        string             `bson:"name"`
	Avatar      string             `bson:"avatar"`
	Username    string             `bson:"username"`
	Password    string             `bson:"password"`
	Email       string             `bson:"email"`
	Phone       string             `bson:"phone"`
	Description string             `bson:"description"`
}
