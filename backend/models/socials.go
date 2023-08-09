package models

type SocialsRequest struct {
	Twitter   string `json:"twitter"`
	Github    string `json:"github"`
	Linkedin  string `json:"linkedin"`
	Instagram string `json:"instagram"`
	Other     string `json:"other"`
}
