package db

import (
	"go.mongodb.org/mongo-driver/mongo"
)

func (store *MongoDBStore) GetClient() *mongo.Client {
	return store.client
}

func (store *MongoDBStore) GetCollection(collectionName string) *mongo.Collection {
	switch collectionName {
	case "users":
		return store.usersCollection
	case "projects":
		return store.projectsCollection
	case "fs.files":
		return store.imagesCollection
	default:
		return nil
	}
}

func (store *MongoDBStore) GetConnectionString() string {
	return store.connectionString
}

func (store *MongoDBStore) GetDatabase() *mongo.Database {
	return store.database
}