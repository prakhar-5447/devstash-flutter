package models

type FetchCollaborator struct {
	UserId string `json:"userId"`
	Avatar string `json:"avatar"`
	Name   string `json:"name"`
}
