package models

type EducationRequest struct {
	Level      string `json:"level"`
	SchoolName string `json:"schoolName"`
	Subject    string `json:"subject"`
	FromYear   string `json:"fromYear"`
	ToYear     string `json:"toYear"`
}

type EditEducation struct {
	ID         string `json:"id"`
	Level      string `json:"level"`
	SchoolName string `json:"schoolName"`
	Subject    string `json:"subject"`
	FromYear   string `json:"fromYear"`
	ToYear     string `json:"toYear"`
}
