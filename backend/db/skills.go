package db

import (
	"context"
	"errors"

	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/bson/primitive"
	"go.mongodb.org/mongo-driver/mongo"
)

func (q *Queries) AddSkillToList(ctx context.Context, userID primitive.ObjectID, skill string) error {
	filter := bson.M{"userid": userID}

	// Check if a document with the given UserID exists in the collection
	existingSkills, err := q.FindSkillsByUserID(ctx, userID)
	if err != nil {
		return err
	}

	if existingSkills == nil {
		// If no skill list exists, create a new one with the provided skill
		newSkills := Skills{
			UserID: userID,
			Skills:   []string{skill},
		}
		_, err = q.skillsCollection.InsertOne(ctx, newSkills)
		if err != nil {
			return err
		}
	} else {
		// If a skill list exists, update it with the new skill if not already present
		if !containsSkill(existingSkills.Skills, skill) {
			update := bson.M{
				"$addToSet": bson.M{
					"skills": skill,
				},
			}
			_, err = q.skillsCollection.UpdateOne(ctx, filter, update)
			if err != nil {
				return err
			}
		}
	}

	return nil
}

func containsSkill(skills []string, skill string) bool {
	for _, s := range skills {
		if s == skill {
			return true
		}
	}
	return false
}

func (q *Queries) DeleteSkillFromList(ctx context.Context, userID primitive.ObjectID, skill string) error {
	filter := bson.M{"userid": userID}
	update := bson.M{
		"$pull": bson.M{
			"skills": skill,
		},
	}

	_, err := q.skillsCollection.UpdateOne(ctx, filter, update)
	return err
}

func (q *Queries) FindSkillsByUserID(ctx context.Context, userID primitive.ObjectID) (*Skills, error) {
	var skills Skills
	filter := bson.M{"userid": userID}

	err := q.skillsCollection.FindOne(ctx, filter).Decode(&skills)
	if err != nil {
		if errors.Is(err, mongo.ErrNoDocuments) {
			// If no skills document found, return nil without error
			return nil, nil
		}
		return nil, err
	}

	return &skills, nil
}
