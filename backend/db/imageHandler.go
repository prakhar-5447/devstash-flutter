package db

import (
	"context"
	"fmt"
	"io"
	"mime/multipart"
	"time"

	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/bson/primitive"
	"go.mongodb.org/mongo-driver/mongo"
	"go.mongodb.org/mongo-driver/mongo/gridfs"
	"go.mongodb.org/mongo-driver/x/mongo/driver/connstring"
)

func (store *MongoDBStore) UploadFileToGridFS(file multipart.File, handler *multipart.FileHeader) error {
	bucket, err := gridfs.NewBucket(store.database)
	if err != nil {
		return fmt.Errorf("error creating GridFS bucket: %w", err)
	}

	uploadStream, err := bucket.OpenUploadStream(handler.Filename)
	if err != nil {
		return fmt.Errorf("error opening upload stream: %w", err)
	}
	defer uploadStream.Close()

	_, err = io.Copy(uploadStream, file)
	if err != nil {
		return fmt.Errorf("error uploading file to GridFS: %w", err)
	}

	return nil
}

func (store *MongoDBStore) GetImageURL(filename string) (string, error) {
	var fileInfo struct {
		ID primitive.ObjectID `bson:"_id"`
	}

	ctx, cancel := context.WithTimeout(context.Background(), 5*time.Second)
	defer cancel()

	err := store.database.Collection("fs.files").FindOne(ctx, bson.M{"filename": filename}).Decode(&fileInfo)
	if err != nil {
		if err == mongo.ErrNoDocuments {
			return "", fmt.Errorf("file not found")
		}
		return "", err
	}

	connString, err := connstring.Parse(store.GetConnectionString())
	if err != nil {
		return "", err
	}

	url := fmt.Sprintf("%s/%s/%s/%s", connString.Scheme, connString.Hosts[0], connString.Database, fileInfo.ID.Hex())
	return url, nil
}

func (store *MongoDBStore) GetFileByID(fileID primitive.ObjectID) (io.ReadCloser, string, error) {
	// Retrieve the GridFS bucket
	bucket, err := gridfs.NewBucket(store.database)
	if err != nil {
		return nil, "", err
	}

	// Open a GridFS download stream for the given file ID
	downloadStream, err := bucket.OpenDownloadStream(fileID)
	if err != nil {
		return nil, "", err
	}

	// Retrieve the file metadata
	fileMetadata := downloadStream.GetFile()
	metadata := fileMetadata.Metadata
	contentTypeValue := metadata.Lookup("contentType")
	contentType, ok := contentTypeValue.StringValueOK()
	if !ok {
		// Handle the case where the content type is not a string
		contentType = "jpg" // Set a default content type or return an error
	}

	// Return the download stream and content type
	return downloadStream, contentType, nil
}
