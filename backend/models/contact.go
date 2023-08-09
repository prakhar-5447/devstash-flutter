package models

type ContactRequest struct {
	UserId      string `json:"userid"`
	City        string `json:"city"`
	State       string `json:"state"`
	Country     string `json:"country"`
	CountryCode string `json:"countryCode"`
	PhoneNo     string `json:"phoneNo"`
}
