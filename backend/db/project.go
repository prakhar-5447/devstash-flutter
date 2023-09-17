package db

import (
	"context"
	"fmt"

	"github.com/prakhar-5447/models"
	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/bson/primitive"
)

func (store *MongoDBStore) Create_Project(ctx context.Context, project *Project) (*Project, error) {
	result, err := store.GetCollection("projects").InsertOne(ctx, project)
	if err != nil {
		return nil, err
	}

	project.ID = result.InsertedID.(primitive.ObjectID)

	return project, nil
}

func (store *MongoDBStore) Update_Project(ctx context.Context, projectID primitive.ObjectID, userID primitive.ObjectID, update models.ProjectRequest) (*Project, error) {
	collaboratorsID := make([]primitive.ObjectID, len(update.CollaboratorsID))
	for i, collabID := range update.CollaboratorsID {
		objectID, err := primitive.ObjectIDFromHex(collabID)
		if err != nil {
			return nil, err
		}
		collaboratorsID[i] = objectID
	}

	updateQuery := bson.M{
		"$set": bson.M{
			"image":           update.Image,
			"title":           update.Title,
			"url":             update.Url,
			"description":     update.Description,
			"technologies":    update.Technologies,
			"projectType":     update.ProjectType,
			"hashtags":        update.Hashtags,
			"collaboratorsID": collaboratorsID,
		},
	}

	result, err := store.projectsCollection.UpdateOne(ctx, bson.M{"_id": projectID, "userID": userID}, updateQuery)
	if err != nil {
		return nil, err
	}

	if result.ModifiedCount == 0 {
		return nil, fmt.Errorf("project not found or unauthorized access")
	}

	updatedProject := &Project{}
	err = store.projectsCollection.FindOne(ctx, bson.M{"_id": projectID}).Decode(updatedProject)
	if err != nil {
		return nil, err
	}

	return updatedProject, nil
}

func (store *MongoDBStore) Delete_Project(ctx context.Context, projectID primitive.ObjectID, userID primitive.ObjectID) (bool, error) {
	filter := bson.M{
		"userId": userID,
		"_id":    projectID,
	}

	result, err := store.projectsCollection.DeleteOne(ctx, filter)
	if err != nil {
		return false, err
	}

	if result.DeletedCount == 0 {
		return false, fmt.Errorf("project not found or unauthorized access")
	}

	return true, nil
}

func (store *MongoDBStore) Get_Projects_By_UserId(ctx context.Context, userID primitive.ObjectID) ([]*Project, error) {
	filter := bson.M{
		"userId": userID,
	}

	cursor, err := store.projectsCollection.Find(ctx, filter)
	if err != nil {
		return nil, err
	}
	defer cursor.Close(ctx)

	projects := []*Project{}
	for cursor.Next(ctx) {
		project := &Project{}
		err := cursor.Decode(project)
		if err != nil {
			return nil, err
		}
		projects = append(projects, project)
	}

	return projects, nil
}

func (store *MongoDBStore) Get_Project_By_Id(ctx context.Context, projectID string) (*Project, error) {
	project := &Project{}
	objID, err := primitive.ObjectIDFromHex(projectID)
	if err != nil {
		return nil, err
	}

	err = store.projectsCollection.FindOne(ctx, bson.M{"_id": objID}).Decode(project)
	if err != nil {
		return nil, err
	}
	return project, nil
}
