package models

type LoginRequest struct {
	UsernameOrEmail string `json:"usernameOrEmail"`
	Password        string `json:"password"`
	FCMToken        string `json:"fcmtoken"`
}
