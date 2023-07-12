package models

type LoginRequest struct {
	UsernameOrEmail string `json:"usernameOremail"`
	Password        string `json:"password"`
}
