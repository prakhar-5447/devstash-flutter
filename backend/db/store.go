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
	FindUserByID(ctx context.Context, userID string) (*User, error)
	CreateUser(ctx context.Context, user *User) error
	UpdateUser(ctx context.Context, user *User) error
	DeleteUser(ctx context.Context, userID string) error
	UploadFileToGridFS(file multipart.File, handler *multipart.FileHeader) error
	GetImageURL(filename string) (string, error)
	GetClient() *mongo.Client
	GetConnectionString() string
	GetDatabase() *mongo.Database
	GetCollection(collectionName string) *mongo.Collection
	GetFileByID(fileID primitive.ObjectID) (io.ReadCloser, string, error)
	CreateProject(ctx context.Context, project *Project) (*Project, error)
	GetProjectByID(ctx context.Context, projectID string) (*Project, error)
	UpdateProject(ctx context.Context, projectID primitive.ObjectID, project models.ProjectRequest) (*Project, error)
}

type MongoDBStore struct {
	client             *mongo.Client
	database           *mongo.Database
	usersCollection    *mongo.Collection
	projectsCollection *mongo.Collection
	imagesCollection   *mongo.Collection
	connectionString   string
	*Queries
}

func NewStore(connectionString string, databaseName string, collectionName string) (Store, error) {
	client, err := mongo.Connect(context.Background(), options.Client().ApplyURI(connectionString))
	if err != nil {
		return nil, err
	}

	database := client.Database(databaseName)
	queries := NewQueries(database)
	usersCollection := database.Collection("users")
	projectsCollection := database.Collection("projects")
	imagesCollection := database.Collection("fs.files")
	return &MongoDBStore{
		client:             client,
		database:           database,
		usersCollection:    usersCollection,
		projectsCollection: projectsCollection,
		imagesCollection:   imagesCollection,
		connectionString:   connectionString,
		Queries:            queries,
	}, nil
}
