package models

type LoginRequest struct {
	UsernameOrEmail string `bson:"usernameOremail"`
	Password   string `bson:"password"`
}
