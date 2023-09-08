package db

import (
	"context"
	"io"
	"mime/multipart"

	"github.com/prakhar-5447/models"
	"go.mongodb.org/mongo-driver/bson/primitive"
	"go.mongodb.org/mongo-driver/mongo"
	"go.mongodb.org/mongo-driver/mongo/options"
)

type Store interface {
	Create_User(ctx context.Context, user *User) (primitive.ObjectID, error)
	Find_User_By_UserId(ctx context.Context, userId primitive.ObjectID) (*User, error)
	Get_User_By_Id(ctx context.Context, userID primitive.ObjectID) (*User, error)
	Check_User_By_Email(ctx context.Context, email string) (bool, error)
	Check_User_By_Username(ctx context.Context, username string) (bool, error)
	Find_User_By_Username_Or_Email(ctx context.Context, usernameOrEmail string) (*User, error)
	Update_User(ctx context.Context, user *User) error
	Update_Avatar(ctx context.Context, avatar string, userID primitive.ObjectID) error
	Update_User_Profile(ctx context.Context, user *User) bool
	Delete_User(ctx context.Context, userID string) error

	Add_Favorite(ctx context.Context, userID primitive.ObjectID, projectID primitive.ObjectID) (bool, error)
	Remove_Favorite(ctx context.Context, userID primitive.ObjectID, projectID primitive.ObjectID) (bool, error)
	Get_Favorite_By_Id(ctx context.Context, userID primitive.ObjectID) (*Favorite, error)

	Add_Bookmark(ctx context.Context, userID primitive.ObjectID, otherUserID primitive.ObjectID) (bool, error)
	Remove_Bookmark(ctx context.Context, userID primitive.ObjectID, otherUserID primitive.ObjectID) (bool, error)
	Get_Bookmark_By_Id(ctx context.Context, userID primitive.ObjectID) (*Bookmark, error)
	Check_Value_In_Array(ctx context.Context, userID primitive.ObjectID, arrayField string, value primitive.ObjectID) bool

	Create_Project(ctx context.Context, project *Project) (*Project, error)
	Update_Project(ctx context.Context, projectID primitive.ObjectID, userID primitive.ObjectID, update models.ProjectRequest) (*Project, error)
	Delete_Project(ctx context.Context, projectID primitive.ObjectID, userID primitive.ObjectID) (bool, error)
	Get_Projects_By_UserId(ctx context.Context, userID primitive.ObjectID) ([]*Project, error)
	Get_Project_By_Id(ctx context.Context, projectID string) (*Project, error)

	UploadFileToGridFS(file multipart.File, handler *multipart.FileHeader) error
	GetImageURL(filename string) (string, error)
	GetClient() *mongo.Client
	GetConnectionString() string
	GetDatabase() *mongo.Database
	GetCollection(collectionName string) *mongo.Collection
	GetFileByID(fileID primitive.ObjectID) (io.ReadCloser, string, error)

	Create_Contact(ctx context.Context, contact Contact) error
	Update_Contact(ctx context.Context, ID primitive.ObjectID, contact Contact) error
	Find_Contact(ctx context.Context, userID primitive.ObjectID) (*Contact, error)

	Create_Education(ctx context.Context, education Education) error
	Find_Education_By_UserId(ctx context.Context, userID primitive.ObjectID) ([]Education, error)
	Update_Education_By_UserId(ctx context.Context, userID primitive.ObjectID, educationList Education) error
	Delete_Education_By_Id(ctx context.Context, educationID primitive.ObjectID) error

	Add_Skill_To_List(ctx context.Context, userID primitive.ObjectID, skill string) error
	Delete_Skill_From_List(ctx context.Context, userID primitive.ObjectID, skill string) error
	Find_Skills_By_UserId(ctx context.Context, userID primitive.ObjectID) (*Skills, error)

	Create_Socials(ctx context.Context, socials *Socials) error
	Find_Socials_By_UserId(ctx context.Context, userID primitive.ObjectID) (*Socials, error)
	Update_Socials_By_UserId(ctx context.Context, userID primitive.ObjectID, socials Socials) error
}

type MongoDBStore struct {
	client           *mongo.Client
	database         *mongo.Database
	connectionString string
	*Queries
}

func NewStore(connectionString string, databaseName string) (Store, error) {
	client, err := mongo.Connect(context.Background(), options.Client().ApplyURI(connectionString))
	if err != nil {
		return nil, err
	}

	database := client.Database(databaseName)
	queries := NewQueries(database)
	return &MongoDBStore{
		client:           client,
		database:         database,
		connectionString: connectionString,
		Queries:          queries,
	}, nil
}
