package models

type Connect struct {
	Action      string `json:"action"`
	OtherUserId string `json:"otherUserId"`
}
