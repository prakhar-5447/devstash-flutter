package db

import (
	"context"
	"errors"

	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/bson/primitive"
	"go.mongodb.org/mongo-driver/mongo"
)

func (q *Queries) Create_Contact(ctx context.Context, contact Contact) error {
	_, err := q.contactCollection.InsertOne(ctx, contact)
	return err
}

func (store *MongoDBStore) Update_Contact(ctx context.Context, ID primitive.ObjectID, contact Contact) error {
	filter := bson.M{"userId": ID}
	update := bson.M{"$set": contact}

	_, err := store.GetCollection("contact").UpdateOne(ctx, filter, update)
	if err != nil {
		return err
	}
	return nil
}

func (store *MongoDBStore) Find_Contact(ctx context.Context, userID primitive.ObjectID) (Contact, error) {
	var result Contact

	filter := bson.M{"userId": userID}

	err := store.GetCollection("contact").FindOne(ctx, filter).Decode(&result)
	if err != nil {
		if errors.Is(err, mongo.ErrNoDocuments) {
			return Contact{}, nil
		}
		return Contact{}, err
	}

	return result, nil
}

func (q *Queries) Create_Education(ctx context.Context, education Education) error {
	_, err := q.educationCollection.InsertOne(ctx, education)
	return err
}

func (store *MongoDBStore) Update_Education_By_UserId(ctx context.Context, ID primitive.ObjectID, educationList Education) error {
	query := bson.M{"$set": educationList}
	_, err := store.GetCollection("educations").UpdateOne(ctx, bson.M{"_id": ID}, query)
	if err != nil {
		return err
	}
	return err
}

func (store *MongoDBStore) Find_Education_By_UserId(ctx context.Context, userID primitive.ObjectID) ([]Education, error) {
	var result []Education

	filter := bson.M{"userid": userID}

	cursor, err := store.GetCollection("educations").Find(ctx, filter)
	if err != nil {
		if errors.Is(err, mongo.ErrNoDocuments) {
			return []Education{}, nil
		}
		return nil, err
	}
	defer cursor.Close(ctx)

	for cursor.Next(ctx) {
		var edu Education
		if err := cursor.Decode(&edu); err != nil {
			return nil, err
		}
		result = append(result, edu)
	}

	if err := cursor.Err(); err != nil {
		return nil, err
	}

	return result, nil
}

func (store *MongoDBStore) Delete_Education_By_Id(ctx context.Context, educationID primitive.ObjectID) error {
	filter := bson.M{"_id": educationID}

	_, err := store.GetCollection("educations").DeleteOne(ctx, filter)
	if err != nil {
		return err
	}
	return nil
}

func (q *Queries) Add_Skill_To_List(ctx context.Context, userID primitive.ObjectID, skill string) error {
	filter := bson.M{"userid": userID}

	existingSkills, err := q.Find_Skills_By_UserId(ctx, userID)
	if err != nil {
		return err
	}

	if existingSkills == nil {
		newSkills := Skills{
			UserID: userID,
			Skills: []string{skill},
		}
		_, err = q.skillsCollection.InsertOne(ctx, newSkills)
		if err != nil {
			return err
		}
	} else {
		if !Contains_Skill(existingSkills.Skills, skill) {
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

func Contains_Skill(skills []string, skill string) bool {
	for _, s := range skills {
		if s == skill {
			return true
		}
	}
	return false
}

func (q *Queries) Delete_Skill_From_List(ctx context.Context, userID primitive.ObjectID, skill string) error {
	filter := bson.M{"userid": userID}
	update := bson.M{
		"$pull": bson.M{
			"skills": skill,
		},
	}

	_, err := q.skillsCollection.UpdateOne(ctx, filter, update)
	return err
}

func (q *Queries) Find_Skills_By_UserId(ctx context.Context, userID primitive.ObjectID) (*Skills, error) {
	var skills Skills
	filter := bson.M{"userid": userID}

	err := q.skillsCollection.FindOne(ctx, filter).Decode(&skills)
	if err != nil {
		if errors.Is(err, mongo.ErrNoDocuments) {
			return nil, nil
		}
		return nil, err
	}

	return &skills, nil
}

func (q *Queries) Create_Socials(ctx context.Context, socials *Socials) error {
	_, err := q.socialsCollection.InsertOne(ctx, socials)
	return err
}

func (q *Queries) Update_Socials_By_UserId(ctx context.Context, userID primitive.ObjectID, socials Socials) error {
	filter := bson.M{"userid": userID}
	update := bson.M{
		"$set": bson.M{
			"twitter":   socials.Twitter,
			"github":    socials.Github,
			"linkedin":  socials.Linkedin,
			"instagram": socials.Instagram,
			"other":     socials.Other,
		},
	}

	_, err := q.socialsCollection.UpdateOne(ctx, filter, update)
	return err
}

func (store *MongoDBStore) Find_Socials_By_UserId(ctx context.Context, userID primitive.ObjectID) (*Socials, error) {
	var socials Socials
	filter := bson.M{"userid": userID}

	err := store.GetCollection("socials").FindOne(ctx, filter).Decode(&socials)
	if err != nil {
		if errors.Is(err, mongo.ErrNoDocuments) {
			return nil, nil
		}
		return nil, err
	}

	return &socials, nil
}
