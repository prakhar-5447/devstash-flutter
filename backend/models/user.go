package models

type CreateUserRequest struct {
	Name        string `bson:"name"`
	Avatar      string `bson:"avatar"`
	Username    string `bson:"username"`
	Password    string `bson:"password"`
	Email       string `bson:"email"`
	Phone       string `bson:"phone"`
	Description string `bson:"description"`
}
