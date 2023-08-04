package models

type ProjectRequest struct {
	Image           string   `json:"image"`
	Title           string   `json:"title"`
	Url           string   `json:"url"`
	Description     string   `json:"description"`
	Technologies    []string `json:"technologies"`
	CollaboratorsID []string `json:"collaboratorsID"`
	ProjectType     string   `json:"projectType"`
	Hashtags        []string `json:"hashtags"`
}
