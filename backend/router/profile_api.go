package router

import (
	"net/http"

	"github.com/gin-gonic/gin"
	"github.com/prakhar-5447/db"
	"github.com/prakhar-5447/models"
	"go.mongodb.org/mongo-driver/bson/primitive"
)

func (server *Server) update_contact(c *gin.Context) {
	var req models.ContactRequest
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
	id, err := primitive.ObjectIDFromHex(userID)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	Contact := db.Contact{
		UserId:      id,
		City:        req.City,
		State:       req.State,
		Country:     req.Country,
		CountryCode: req.CountryCode,
		PhoneNo:     req.PhoneNo,
	}

	if err := server.store.Update_Contact(
		c.Request.Context(),
		id,
		Contact); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, gin.H{"message": "contact updated successfully"})
}

func (server *Server) get_contact(c *gin.Context) {
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

	contact, err := server.store.Find_Contact(c.Request.Context(), ID)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}
	c.JSON(http.StatusOK, contact)

}

func (server *Server) create_education(c *gin.Context) {
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

	educationListObj := db.Education{
		UserId:     ID,
		SchoolName: req.SchoolName,
		FromYear:   req.FromYear,
		ToYear:     req.ToYear,
		Subject:    req.Subject,
		Level:      req.Level,
	}

	if err := server.store.Create_Education(
		c.Request.Context(),
		educationListObj); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, gin.H{"message": "Educations updated successfully"})
}

func (server *Server) update_education(c *gin.Context) {
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

	educationListObj := db.Education{
		UserId:     ID,
		SchoolName: req.SchoolName,
		FromYear:   req.FromYear,
		ToYear:     req.ToYear,
		Subject:    req.Subject,
		Level:      req.Level,
	}

	if err := server.store.Update_Education_By_UserId(
		c.Request.Context(),
		eduID,
		educationListObj); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, gin.H{"message": "Educations updated successfully"})
}

func (server *Server) get_education(c *gin.Context) {
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

	educations, err := server.store.Find_Education_By_UserId(c.Request.Context(), ID)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, educations)
}

func (server *Server) delete_education(c *gin.Context) {

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

	if err := server.store.Delete_Education_By_Id(c.Request.Context(), educationID); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to delete education"})
		return
	}

	c.JSON(http.StatusOK, gin.H{"message": "Education deleted successfully"})
}

func (server *Server) add_skill(c *gin.Context) {
	var req models.SkillsRequest

	if err := c.BindJSON(&req); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid request body"})
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

	if err := server.store.Add_Skill_To_List(c.Request.Context(), ID, req.Skill); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to add skills"})
		return
	}

	c.JSON(http.StatusOK, gin.H{"message": "Skills added successfully"})
}

func (server *Server) delete_skill(c *gin.Context) {
	var req models.SkillsRequest

	if err := c.BindJSON(&req); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid request body"})
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

	if err := server.store.Delete_Skill_From_List(c.Request.Context(), ID, req.Skill); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to delete skill"})
		return
	}

	c.JSON(http.StatusOK, gin.H{"message": "Skill deleted successfully"})
}

func (server *Server) get_skills(c *gin.Context) {
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

	skills, err := server.store.Find_Skills_By_UserId(c.Request.Context(), ID)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to get skills"})
		return
	}

	c.JSON(http.StatusOK, gin.H{"skills": skills})
}

func (server *Server) update_social(c *gin.Context) {
	var req models.SocialsRequest
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

	socials := db.Socials{
		UserId:    ID,
		Twitter:   req.Twitter,
		Github:    req.Github,
		Linkedin:  req.Linkedin,
		Instagram: req.Instagram,
		Other:     req.Other,
	}

	if err := server.store.Update_Socials_By_UserId(
		c.Request.Context(),
		ID,
		socials); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, gin.H{"message": "Socials updated successfully"})
}

func (server *Server) get_social(c *gin.Context) {
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

	socials, err := server.store.Find_Socials_By_UserId(c.Request.Context(), ID)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, socials)
}
