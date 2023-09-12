package db

import (
	"go.mongodb.org/mongo-driver/bson/primitive"
)

type UserProfile struct {
	User    User    `bson:"user"`
	Socials Socials `bson:"socials"`
}

type User struct {
	ID          primitive.ObjectID `bson:"_id,omitempty"`
	Name        string             `bson:"name"`
	Avatar      string             `bson:"avatar"`
	Username    string             `bson:"username"`
	Password    string             `bson:"password"`
	Email       string             `bson:"email"`
	Description string             `bson:"description"`
}

type Socials struct {
	ID        primitive.ObjectID `bson:"_id,omitempty"`
	UserId    primitive.ObjectID `bson:"userId,omitempty"`
	Twitter   string             `bson:"twitter,omitempty"`
	Github    string             `bson:"github,omitempty"`
	Linkedin  string             `bson:"linkedin,omitempty"`
	Instagram string             `bson:"instagram,omitempty"`
	Other     string             `bson:"other,omitempty"`
}

type Contact struct {
	ID          primitive.ObjectID `bson:"_id,omitempty"`
	UserId      primitive.ObjectID `bson:"userId,omitempty"`
	City        string             `bson:"city,omitempty"`
	State       string             `bson:"state,omitempty"`
	Country     string             `bson:"country,omitempty"`
	CountryCode string             `bson:"countryCode,omitempty"`
	PhoneNo     string             `bson:"phoneNo,omitempty"`
}

type Education struct {
	ID         primitive.ObjectID `bson:"_id,omitempty"`
	UserId     primitive.ObjectID `bson:"userId,omitempty"`
	Level      string             `bson:"level,omitempty"`
	SchoolName string             `bson:"schoolName,omitempty"`
	Subject    string             `bson:"subject,omitempty"`
	FromYear   string             `bson:"fromYear,omitempty"`
	ToYear     string             `bson:"toYear,omitempty"`
}

type Skills struct {
	ID     primitive.ObjectID `bson:"_id,omitempty"`
	UserID primitive.ObjectID `bson:"userId,omitempty"`
	Skills []string           `bson:"skills,omitempty"`
}

type ProjectType string

const (
	Web     ProjectType = "Web"
	Android ProjectType = "Android"
	Other   ProjectType = "Other"
)

type Project struct {
	UserID          primitive.ObjectID   `bson:"userID"`
	ID              primitive.ObjectID   `bson:"_id,omitempty"`
	Image           string               `bson:"image"`
	Title           string               `bson:"title"`
	Url             string               `bson:"url"`
	Description     string               `bson:"description"`
	CreatedDate     primitive.DateTime   `bson:"createdDate"`
	Technologies    []string             `bson:"technologies"`
	CollaboratorsID []primitive.ObjectID `bson:"collaboratorsID"`
	ProjectType     ProjectType          `bson:"projectType"`
	Hashtags        []string             `bson:"hashtags"`
}

type Favorite struct {
	UserId     primitive.ObjectID   `bson:"userId"`
	ProjectIds []primitive.ObjectID `bson:"projectIds"`
}

type Bookmark struct {
	UserId       primitive.ObjectID   `bson:"userId"`
	OtherUserIds []primitive.ObjectID `bson:"otherUserIds"`
}

type FCMToken struct {
	ID       primitive.ObjectID `bson:"_id,omitempty"`
	UserId   primitive.ObjectID `bson:"userid,omitempty"`
	FCMToken string             `bson:"fcmtoken"`
}

type Message struct {
	ID          primitive.ObjectID `bson:"_id,omitempty"`
	UserId      primitive.ObjectID `bson:"userid,omitempty"`
	Subject     string             `bson:"subject"`
	Description string             `bson:"description"`
	SenderEmail string             `bson:"senderEmail"`
	CreatedAt   primitive.DateTime `bson:"createdAt,omitempty"`
}
