package router

import (
	"net/http"

	"github.com/gin-gonic/gin"
	"github.com/prakhar-5447/db"
	"github.com/prakhar-5447/models"
	"go.mongodb.org/mongo-driver/bson/primitive"
)

func (server *Server) CreateEducations(c *gin.Context) {
	var req models.EducationRequest
	if err := c.ShouldBindJSON(&req); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
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
	ID, err := primitive.ObjectIDFromHex(userID)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	// Create the EducationList object with the converted education list
	educationListObj := db.Education{
		UserId:     ID, // Assuming you have the userID stored in the variable ID
		SchoolName: req.SchoolName,
		FromYear:   req.FromYear,
		ToYear:     req.ToYear,
		Subject:    req.Subject,
		Level:      req.Level,
	}

	// Update the user's education list
	if err := server.store.CreateEducation(
		c.Request.Context(),
		educationListObj); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, gin.H{"message": "Educations updated successfully"})
}

func (server *Server) UpdateEducations(c *gin.Context) {
	var req models.EditEducation
	if err := c.ShouldBindJSON(&req); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
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
	ID, err := primitive.ObjectIDFromHex(userID)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	eduID, err := primitive.ObjectIDFromHex(req.ID)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	// Create the EducationList object with the converted education list
	educationListObj := db.Education{
		UserId:     ID, // Assuming you have the userID stored in the variable ID
		SchoolName: req.SchoolName,
		FromYear:   req.FromYear,
		ToYear:     req.ToYear,
		Subject:    req.Subject,
		Level:      req.Level,
	}

	// Update the user's education list
	if err := server.store.UpdateEducationByUserID(
		c.Request.Context(),
		eduID,
		educationListObj); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, gin.H{"message": "Educations updated successfully"})
}

func (server *Server) FindEducationsByUserID(c *gin.Context) {
	// Get the userID from the token
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
	ID, err := primitive.ObjectIDFromHex(userID)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	// Find educations by userID in the database
	educations, err := server.store.FindEducationByUserID(c.Request.Context(), ID)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	// Return the educations data in the response
	c.JSON(http.StatusOK, educations)
}

func (server *Server) DeleteEducation(c *gin.Context) {

	eduId := c.Param("id")
	// token := c.GetHeader("Authorization")
	// if token == "" {
	// 	c.JSON(http.StatusUnauthorized, gin.H{"error": "Authorization token required"})
	// 	return
	// }

	// payload, err := server.tokenMaker.VerifyToken(token)
	// if err != nil {
	// 	c.JSON(http.StatusUnauthorized, gin.H{"error": "Invalid token"})
	// 	return
	// }

	// userID := payload.UserID
	// ID, err := primitive.ObjectIDFromHex(userID)
	// if err != nil {
	// 	c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
	// 	return
	// }

	educationID, err := primitive.ObjectIDFromHex(eduId)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid educationID"})
		return
	}

	if err := server.store.DeleteEducationByID(c.Request.Context(), educationID); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to delete education"})
		return
	}

	c.JSON(http.StatusOK, gin.H{"message": "Education deleted successfully"})
}
