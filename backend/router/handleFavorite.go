package router

import (
	"net/http"

	"github.com/gin-gonic/gin"
	"github.com/prakhar-5447/models"
	"go.mongodb.org/mongo-driver/bson/primitive"
)

func (server *Server) AddOrRemoveUserFromFavorite(c *gin.Context) {
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
	userID := payload.UserID

	// Bind the request JSON to a struct containing the user ID to be added or removed
	var req models.OtherUserProjects
	if err := c.ShouldBindJSON(&req); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	otherUserID, err := primitive.ObjectIDFromHex(req.ProjectId)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	userObjectID, err := primitive.ObjectIDFromHex(userID)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	var success bool
	if req.Action == "add" {
		success, err = server.store.AddFavorite(c.Request.Context(), userObjectID, otherUserID)
	} else if req.Action == "remove" {
		success, err = server.store.RemoveFavorite(c.Request.Context(), userObjectID, otherUserID)
	} else {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid action"})
		return
	}

	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	if success {
		c.JSON(http.StatusOK, gin.H{"message": "Other user favorite updated successfully"})
	} else {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to update other user favorite"})
	}
}
