package router

import (
	"net/http"
	"time"

	"github.com/gin-gonic/gin"
	"github.com/prakhar-5447/db"
	"github.com/prakhar-5447/models"
	"go.mongodb.org/mongo-driver/bson/primitive"
)

func (server *Server) CreateProject(c *gin.Context) {
	token := c.GetHeader("Authorization")
	if token == "" {
		c.JSON(http.StatusUnauthorized, gin.H{"error": "Authorization token required"})
		return
	}

	payload, err := server.tokenMaker.VerifyToken(token)
	if err != nil {
		c.JSON(http.StatusUnauthorized, gin.H{"error": "Invalid token"})
		return
	}

	userID := payload.UserID

	var req models.ProjectRequest
	if err := c.ShouldBindJSON(&req); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	collaboratorsID := make([]primitive.ObjectID, len(req.CollaboratorsID))
	for i, collabID := range req.CollaboratorsID {
		objectID, err := primitive.ObjectIDFromHex(collabID)
		if err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
			return
		}
		collaboratorsID[i] = objectID
	}

	ID, err := primitive.ObjectIDFromHex(userID)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	project := &db.Project{
		Title:           req.Title,
		Description:     req.Description,
		Technologies:    req.Technologies,
		CreatedDate:     primitive.NewDateTimeFromTime(time.Now().UTC()),
		ProjectType:     convertToProjectType(req.ProjectType),
		CollaboratorsID: collaboratorsID,
		Hashtags:        req.Hashtags,
		UserID:          ID,
	}

	createdProject, err := server.store.CreateProject(c.Request.Context(), project)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, gin.H{
		"message": "Project created successfully",
		"project": createdProject,
	})
}

func convertToProjectType(projectType string) db.ProjectType {
	switch projectType {
	case "Web":
		return db.Web
	case "Android":
		return db.Android
	default:
		return db.Other
	}
}

func (server *Server) UpdateProjectByID(c *gin.Context) {
	// Extract the token from the Authorization header
	token := c.GetHeader("Authorization")
	if token == "" {
		c.JSON(http.StatusUnauthorized, gin.H{"error": "Authorization token required"})
		return
	}

	payload, err := server.tokenMaker.VerifyToken(token)
	if err != nil {
		c.JSON(http.StatusUnauthorized, gin.H{"error": "Invalid token"})
		return
	}

	// Retrieve the user ID from the payload
	ID, err := primitive.ObjectIDFromHex(payload.UserID)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	// Get the project ID from the request URL parameters
	projectId := c.Param("id")

	// Convert the projectID to primitive.ObjectID
	if err != nil {
		// Handle error if the conversion fails
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid project ID"})
		return
	}

	// Bind the request JSON to a ProjectRequest struct
	var req models.ProjectRequest
	if err := c.ShouldBindJSON(&req); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	// Retrieve the existing project from the database
	existingProject, err := server.store.GetProjectByID(c.Request.Context(), projectId)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	// Check if the userID in the project matches the user ID in the token
	if existingProject.UserID != ID {
		c.JSON(http.StatusForbidden, gin.H{"error": "Unauthorized access"})
		return
	}

	pID, err := primitive.ObjectIDFromHex(projectId)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	// Update the project in the database
	result, err := server.store.UpdateProject(c.Request.Context(), pID, req)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, gin.H{
		"message":     "Project updated successfully",
		"new project": result,
	})
}