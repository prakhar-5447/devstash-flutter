package router

import (
	"net/http"
	"time"

	"github.com/gin-gonic/gin"
	"github.com/prakhar-5447/db"
	"github.com/prakhar-5447/models"
	"go.mongodb.org/mongo-driver/bson/primitive"
)

func (server *Server) create_project(c *gin.Context) {
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
		Image:           req.Image,
		Title:           req.Title,
		Url:             req.Url,
		Description:     req.Description,
		Technologies:    req.Technologies,
		CreatedDate:     primitive.NewDateTimeFromTime(time.Now().UTC()),
		ProjectType:     convert_to_projectType(req.ProjectType),
		CollaboratorsID: collaboratorsID,
		Hashtags:        req.Hashtags,
		UserID:          ID,
	}

	createdProject, err := server.store.Create_Project(c.Request.Context(), project)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, createdProject)
}

func convert_to_projectType(projectType string) db.ProjectType {
	switch projectType {
	case "Web":
		return db.Web
	case "Android":
		return db.Android
	default:
		return db.Other
	}
}

func (server *Server) update_project(c *gin.Context) {
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

	projectID := c.Param("id")

	pID, err := primitive.ObjectIDFromHex(projectID)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	userID, err := primitive.ObjectIDFromHex(payload.UserID)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	var req models.ProjectRequest
	if err := c.ShouldBindJSON(&req); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	updatedProject, err := server.store.Update_Project(c.Request.Context(), pID, userID, req)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, updatedProject)
}

func (server *Server) delete_project(c *gin.Context) {
	token := c.GetHeader("Authorization")
	if token == "" {
		c.JSON(http.StatusUnauthorized, gin.H{"deleted": false, "error": "Authorization token required"})
		return
	}

	payload, err := server.tokenMaker.VerifyToken(token)
	if err != nil {
		c.JSON(http.StatusUnauthorized, gin.H{"deleted": false, "error": "Invalid token"})
		return
	}

	projectID := c.Param("id")
	pID, err := primitive.ObjectIDFromHex(projectID)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"deleted": false, "error": err.Error()})
		return
	}
	userID, err := primitive.ObjectIDFromHex(payload.UserID)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"deleted": false, "error": err.Error()})
		return
	}

	deleted, err := server.store.Delete_Project(c.Request.Context(), pID, userID)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"deleted": deleted, "error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, gin.H{"deleted": deleted, "message": "Project deleted successfully"})
}

func (server *Server) get_projects_by_userId(c *gin.Context) {
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

	userID, err := primitive.ObjectIDFromHex(payload.UserID)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	projects, err := server.store.Get_Projects_By_UserId(c.Request.Context(), userID)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, projects)
}

func (server *Server) get_project_by_id(c *gin.Context) {
	projectID := c.Param("id")

	project, err := server.store.Get_Project_By_Id(c.Request.Context(), projectID)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"deleted": false, "error": "Failed to retrieve project"})
		return
	}

	c.JSON(http.StatusOK, project)
}
