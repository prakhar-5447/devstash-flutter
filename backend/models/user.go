package models

type CreateUserRequest struct {
	Name        string `json:"name"`
	Username    string `json:"username"`
	Password    string `json:"password"`
	Email       string `json:"email"`
	Description string `json:"description"`
}

type SocialEntry struct {
	Type string `json:"type"`
	URL  string `json:"url"`
}

type EducationEntry struct {
	Level      string `json:"level"`
	SchoolName string `json:"schoolName"`
	Subject    string `json:"subject"`
	FromYear   string `json:"fromYear"`
	ToYear     string `json:"toYear"`
}
