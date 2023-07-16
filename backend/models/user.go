package models

type CreateUserRequest struct {
	Name        string `json:"name"`
	Avatar      string `json:"avatar"`
	Username    string `json:"username"`
	Password    string `json:"password"`
	Email       string `json:"email"`
	Phone       string `json:"phone"`
	Description string `json:"description"`
}
