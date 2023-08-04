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
	FindUserByUsername(ctx context.Context, username string) (*User, error)
	CreateUser(ctx context.Context, user *User) error
	UpdateUser(ctx context.Context, user *User) error
	UpdateUserProfile(ctx context.Context, user *User) bool
	DeleteUser(ctx context.Context, userID string) error
	CheckUserByEmail(ctx context.Context, email string) (bool, error)
	CheckUserByUsername(ctx context.Context, username string) (bool, error)
	FindByUsernameOrEmail(ctx context.Context, usernameOrEmail string, password string) (*User, error)
	UploadFileToGridFS(file multipart.File, handler *multipart.FileHeader) error
	GetImageURL(filename string) (string, error)
	GetClient() *mongo.Client
	GetConnectionString() string
	GetDatabase() *mongo.Database
	GetCollection(collectionName string) *mongo.Collection
	GetFileByID(fileID primitive.ObjectID) (io.ReadCloser, string, error)
	CreateProject(ctx context.Context, project *Project) (*Project, error)
	GetProjectByID(ctx context.Context, projectID string) (*Project, error)
	AddFavorite(ctx context.Context, userID primitive.ObjectID, projectID primitive.ObjectID) (bool, error)
	RemoveFavorite(ctx context.Context, userID primitive.ObjectID, projectID primitive.ObjectID) (bool, error)
	AddUserToBookmark(ctx context.Context, userID primitive.ObjectID, otherUserID primitive.ObjectID) (bool, error)
	RemoveUserFromBookmark(ctx context.Context, userID primitive.ObjectID, otherUserID primitive.ObjectID) (bool, error)
	UpdateProject(ctx context.Context, projectID primitive.ObjectID, userID primitive.ObjectID, update models.ProjectRequest) (*Project, error)
	GetProjectsByUserID(ctx context.Context, userID primitive.ObjectID) ([]*Project, error)
	DeleteProjectByUserID(ctx context.Context, projectID primitive.ObjectID, userID primitive.ObjectID) error
	GetUserFavoritesByID(ctx context.Context, userID primitive.ObjectID) (*Favorite, error)
	GetUserBookmarksByID(ctx context.Context, userID primitive.ObjectID) (*Bookmark, error)
	GetUserByID(ctx context.Context, userID primitive.ObjectID) (*User, error)
	CheckValueInArray(ctx context.Context, userID primitive.ObjectID, arrayField string, value primitive.ObjectID) bool
}

type MongoDBStore struct {
	client   *mongo.Client
	database *mongo.Database
	// usersCollection    *mongo.Collection
	// projectsCollection *mongo.Collection
	// favoriteCollection *mongo.Collection
	// imagesCollection   *mongo.Collection
	// bookmarkCollection   *mongo.Collection
	connectionString string
	*Queries
}

func NewStore(connectionString string, databaseName string, collectionName string) (Store, error) {
	client, err := mongo.Connect(context.Background(), options.Client().ApplyURI(connectionString))
	if err != nil {
		return nil, err
	}

	database := client.Database(databaseName)
	queries := NewQueries(database)
	// usersCollection := database.Collection("users")
	// projectsCollection := database.Collection("projects")
	// imagesCollection := database.Collection("fs.files")
	// favoriteCollection := database.Collection("favorite")
	// bookmarkCollection := database.Collection("bookmark")
	return &MongoDBStore{
		client:   client,
		database: database,
		// usersCollection:    usersCollection,
		// projectsCollection: projectsCollection,
		// imagesCollection:   imagesCollection,
		// favoriteCollection: favoriteCollection,
		// bookmarkCollection:   bookmarkCollection
		connectionString: connectionString,
		Queries:          queries,
	}, nil
}
