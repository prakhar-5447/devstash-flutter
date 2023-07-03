package db

import (
	"context"

	"go.mongodb.org/mongo-driver/mongo"
	"go.mongodb.org/mongo-driver/mongo/options"
)

type Store interface {
	FindUserByID(ctx context.Context, userID string) (*User, error)
	CreateUser(ctx context.Context, user *User) error
	UpdateUser(ctx context.Context, user *User) error
	DeleteUser(ctx context.Context, userID string) error
}

type MongoDBStore struct {
	client     *mongo.Client
	database   *mongo.Database
	collection *mongo.Collection
	*Queries
}

func NewStore(connectionString string, databaseName string, collectionName string) (Store, error) {
	client, err := mongo.Connect(context.Background(), options.Client().ApplyURI(connectionString))
	if err != nil {
		return nil, err
	}

	database := client.Database(databaseName)
	queries := NewQueries(database)
	collection := database.Collection(collectionName)
	return &MongoDBStore{
		client:     client,
		database:   database,
		collection: collection,
		Queries:    queries,
	}, nil
}

func (store *MongoDBStore) execTx(ctx context.Context, fn func(*Queries) error) error {
	session, err := store.client.StartSession()
	if err != nil {
		return err
	}
	defer session.EndSession(ctx)

	err = session.StartTransaction()
	if err != nil {
		return err
	}

	q := NewQueries(store.database)
	err = fn(q)
	return nil
}