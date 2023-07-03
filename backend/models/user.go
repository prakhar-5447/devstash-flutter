package models

type CreateUserRequest struct {
	Name string `bson:"name"`
}