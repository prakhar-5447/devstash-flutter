package models

type MessageRequest struct {
	Subject     string    `json:"subject"`
	Description string    `json:"description"`
	SenderEmail string    `json:"senderEmail"`
}
