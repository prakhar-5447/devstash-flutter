package router

import (
	"net/http"

	"github.com/gin-gonic/gin"
	"github.com/prakhar-5447/models"
	"go.mongodb.org/mongo-driver/bson/primitive"
)

func (server *Server) fetch_user(c *gin.Context) {
	token := c.GetHeader("Authorization")
	if token == "" {
		c.JSON(http.StatusUnauthorized, gin.H{"success": false, "msg": "Authorization token required"})
		return
	}

	payload, err := server.tokenMaker.VerifyToken(token)
	if err != nil {
		c.JSON(http.StatusUnauthorized, gin.H{"success": false, "msg": "Invalid token"})
		return
	}

	userId := payload.UserID
	uId, err := primitive.ObjectIDFromHex(userId)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"success": false, "msg": "Invalid user ID"})
		return
	}

	user, err := server.store.Find_User_By_UserId(c.Request.Context(), uId)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"success": false, "msg": err.Error()})
		return
	}

	c.JSON(http.StatusOK, gin.H{"success": true, "msg": "User found", "data": user})
}

func (server *Server) fetch_user_by_id(c *gin.Context) {
	userID := c.Param("id")

	objID, err := primitive.ObjectIDFromHex(userID)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"success": false, "msg": "Invalid user ID"})
		return
	}

	user, err := server.store.Get_User_By_Id(c.Request.Context(), objID)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"success": false, "msg": "Failed to get user"})
		return
	}

	c.JSON(http.StatusOK, gin.H{"success": true, "msg": "User found", "data": user})
}

func (server *Server) update_profile(c *gin.Context) {
	token := c.GetHeader("Authorization")
	if token == "" {
		c.JSON(http.StatusUnauthorized, gin.H{"success": false, "msg": "Authorization token required"})
		return
	}

	payload, err := server.tokenMaker.VerifyToken(token)
	if err != nil {
		c.JSON(http.StatusUnauthorized, gin.H{"success": false, "msg": "Invalid token"})
		return
	}

	userId := payload.UserID
	uId, err := primitive.ObjectIDFromHex(userId)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"success": false, "msg": "Invalid user ID"})
		return
	}

	user, err := server.store.Find_User_By_UserId(c.Request.Context(), uId)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"success": false, "msg": err.Error()})
		return
	}

	var req models.CreateUserRequest
	if err := c.ShouldBindJSON(&req); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"success": false, "msg": err.Error()})
		return
	}

	if req.Username != "" && req.Username != user.Username {
		found, err := server.store.Check_User_By_Username(c.Request.Context(), req.Username)
		if err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"success": false, "msg": err.Error()})
			return
		}
		if found {
			c.JSON(http.StatusOK, gin.H{"success": false, "msg": "User with the same username already exists"})
			return
		}
	}

	if req.Email != "" && req.Email != user.Email {
		found, err := server.store.Check_User_By_Email(c.Request.Context(), req.Email)
		if err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"success": false, "msg": err.Error()})
			return
		}
		if found {
			c.JSON(http.StatusOK, gin.H{"success": false, "msg": "User with the same email already exists"})
			return
		}
	}

	if req.Name != "" {
		user.Name = req.Name
	}
	if req.Username != "" {
		user.Username = req.Username
	}
	if req.Email != "" {
		user.Email = req.Email
	}
	if req.Description != "" {
		user.Description = req.Description
	}

	success := server.store.Update_User_Profile(c.Request.Context(), user)
	if success {
		c.JSON(http.StatusOK, gin.H{"success": true, "msg": "Profile updated successfully"})
	} else {
		c.JSON(http.StatusInternalServerError, gin.H{"success": false, "msg": "Failed to update profile"})
	}
}

// func (server *Server) SaveProfile(c *gin.Context) {
// 	// Get the user's profile from the request body
// 	var req models.SaveUser
// 	if err := c.ShouldBindJSON(&req); err != nil {
// 		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
// 		return
// 	}

// 	// Check the validity of the authorization token and get the user's information
// 	token := c.GetHeader("Authorization")
// 	if token == "" {
// 		c.JSON(http.StatusUnauthorized, gin.H{"error": "Authorization token required"})
// 		return
// 	}

// 	payload, err := server.tokenMaker.VerifyToken(token)
// 	if err != nil {
// 		c.JSON(http.StatusUnauthorized, gin.H{"error": "Invalid token"})
// 		return
// 	}

// 	username := payload.Username
// 	user, err := server.store.FindUserByUsername(c.Request.Context(), username)
// 	if err != nil {
// 		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
// 		return
// 	}

// 	// // Check if the updated username already exists
// 	// if req.Username != "" && req.Username != user.Username {
// 	// 	found, err := server.store.CheckUserByUsername(c.Request.Context(), req.Username)
// 	// 	if err != nil {
// 	// 		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
// 	// 		return
// 	// 	}
// 	// 	if found {
// 	// 		c.JSON(http.StatusOK, gin.H{"message": "User with the same username already exists"})
// 	// 		return
// 	// 	}
// 	// }

// 	// Check if the updated email already exists
// 	if req.Email != "" && req.Email != user.Email {
// 		found, err := server.store.CheckUserByEmail(c.Request.Context(), req.Email)
// 		if err != nil {
// 			c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
// 			return
// 		}
// 		if found {
// 			c.JSON(http.StatusOK, gin.H{"message": "User with the same email already exists"})
// 			return
// 		}
// 	}

// 	// Update the user's profile information
// 	if req.Name != "" {
// 		user.Name = req.Name
// 	}
// 	// if req.Avatar != "" {
// 	// 	user.Avatar = req.Avatar
// 	// }
// 	// if req.Username != "" {
// 	// 	user.Username = req.Username
// 	// }
// 	if req.Email != "" {
// 		user.Email = req.Email
// 	}

// 	if req.Description != "" {
// 		user.Description = req.Description
// 	}

// 	// Save the updated user profile
// 	success := server.store.UpdateUserProfile(c.Request.Context(), user)
// 	if !success {
// 		c.JSON(http.StatusInternalServerError, gin.H{"success": false, "error": "Failed to update profile"})
// 		return
// 	}

// 	ID, err := primitive.ObjectIDFromHex(payload.UserID)
// 	if err != nil {
// 		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
// 		return
// 	}

// 	// Update the user's socials information
// 	// Assuming the `UpdateSocials` method exists in your store to update the socials list
// 	if len(req.Socials) > 0 {
// 		socials := db.Socials{
// 			UserId: user.ID,
// 			// Assuming the user can have multiple social entries
// 			Twitter:   extractSocialURL(req.Socials, "twitter"),
// 			Github:    extractSocialURL(req.Socials, "github"),
// 			Linkedin:  extractSocialURL(req.Socials, "linkedin"),
// 			Instagram: extractSocialURL(req.Socials, "instagram"),
// 		}
// 		err := server.store.UpdateSocialsByUserID(c.Request.Context(), ID, socials)
// 		if err != nil {
// 			c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
// 			return
// 		}
// 	}

// 	// Convert models.EducationRequest to db.Education
// 	var educationList []db.Education
// 	for _, edu := range req.Education {
// 		education := db.Education{
// 			Level:      edu.Level,
// 			SchoolName: edu.SchoolName,
// 			Subject:    edu.Subject,
// 			FromYear:   edu.FromYear,
// 			ToYear:     edu.ToYear,
// 		}
// 		educationList = append(educationList, education)
// 	}

// 	// Create the EducationList object with the converted education list
// 	educationListObj := db.EducationList{
// 		UserId:        ID,            // Assuming you have the userID stored in the variable ID
// 		EducationList: educationList, // The slice of Education objects you want to update
// 	}

// 	// Update the user's education list
// 	if req.Education != nil {
// 		if err := server.store.UpdateEducationByUserID(
// 			c.Request.Context(),
// 			ID,
// 			educationListObj); err != nil {
// 			c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
// 			return
// 		}
// 	}

// 	c.JSON(http.StatusOK, gin.H{"success": true, "message": "Profile updated successfully"})
// }

// func extractSocialURL(socials []models.SocialEntry, socialType string) string {
// 	for _, entry := range socials {
// 		if entry.Type == socialType {
// 			return entry.URL
// 		}
// 	}
// 	return ""
// }
