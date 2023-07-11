package db

import (
	"context"
	"fmt"

	"github.com/prakhar-5447/models"
	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/bson/primitive"
)

func (store *MongoDBStore) CreateProject(ctx context.Context, project *Project) (*Project, error) {
	// Get the projects collection from the database
	collection := store.GetCollection("projects")

	// Insert the project document into the collection
	result, err := collection.InsertOne(ctx, project)
	if err != nil {
		return nil, err
	}

	// Set the ID of the project based on the inserted document
	project.ID = result.InsertedID.(primitive.ObjectID)

	return project, nil
}

// GetProjectByID retrieves a project by its ID.
func (store *MongoDBStore) GetProjectByID(ctx context.Context, projectID string) (*Project, error) {
	project := &Project{}
	objID, err := primitive.ObjectIDFromHex(projectID)
	if err != nil {
		// Handle error if the conversion fails
		return nil, err
	}

	err = store.projectsCollection.FindOne(ctx, bson.M{"_id": objID}).Decode(project)
	if err != nil {
		return nil, err
	}
	return project, nil
}

func (store *MongoDBStore) UpdateProject(ctx context.Context, projectID primitive.ObjectID, update models.ProjectRequest) (*Project, error) {
	// Create the update query

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
			"description":     update.Description,
			"technologies":    update.Technologies,
			"projectType":     update.ProjectType,
			"hashtags":        update.Hashtags,
			"collaboratorsID": collaboratorsID,
		}}

	// Perform the update operation
	result, err := store.projectsCollection.UpdateOne(ctx, bson.M{"_id": projectID}, updateQuery)
	if err != nil {
		return nil, err
	}

	if result.ModifiedCount == 0 {
		return nil, fmt.Errorf("project not found")
	}

	// Retrieve and return the updated project
	updatedProject := &Project{}
	err = store.projectsCollection.FindOne(ctx, bson.M{"_id": projectID}).Decode(updatedProject)
	if err != nil {
		return nil, err
	}

	return updatedProject, nil
}
