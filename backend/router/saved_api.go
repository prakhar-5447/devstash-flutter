package router

import (
	"net/http"

	"github.com/gin-gonic/gin"
	"github.com/prakhar-5447/models"
	"go.mongodb.org/mongo-driver/bson/primitive"
)

func (server *Server) update_favorite(c *gin.Context) {
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

	userID := payload.UserID

	var req models.OtherUserProjects
	if err := c.ShouldBindJSON(&req); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"success": false, "msg": err.Error()})
		return
	}

	otherUserID, err := primitive.ObjectIDFromHex(req.ProjectId)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"success": false, "msg": err.Error()})
		return
	}

	userObjectID, err := primitive.ObjectIDFromHex(userID)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"success": false, "msg": err.Error()})
		return
	}

	var success bool
	if req.Action == "add" {
		success, err = server.store.Add_Favorite(c.Request.Context(), userObjectID, otherUserID)
	} else if req.Action == "remove" {
		success, err = server.store.Remove_Favorite(c.Request.Context(), userObjectID, otherUserID)
	} else {
		c.JSON(http.StatusBadRequest, gin.H{"success": false, "msg": "Invalid action"})
		return
	}

	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"success": false, "msg": err.Error()})
		return
	}

	if success {
		c.JSON(http.StatusOK, gin.H{"success": true, "msg": "Other user favorite updated successfully"})
	} else {
		c.JSON(http.StatusInternalServerError, gin.H{"success": false, "msg": "Failed to update other user favorite"})
	}
}

func (server *Server) get_user_favorite_by_id(c *gin.Context) {
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

	userID := payload.UserID

	objectID, err := primitive.ObjectIDFromHex(userID)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"success": false, "msg": err.Error()})
		return
	}

	favorites, err := server.store.Get_Favorite_By_Id(c.Request.Context(), objectID)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"success": false, "msg": err.Error()})
		return
	}

	c.JSON(http.StatusOK, gin.H{"success": true, "msg": "Retrieved successfully", "data": favorites})
}

func (server *Server) check_favorite(c *gin.Context) {
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

	userID := payload.UserID
	var req = c.Param("id")

	objectID, err := primitive.ObjectIDFromHex(userID)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"success": false, "msg": err.Error()})
		return
	}

	projectId, err := primitive.ObjectIDFromHex(req)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"success": false, "msg": err.Error()})
		return
	}

	favorite := server.store.Check_Value_In_Array(c.Request.Context(), objectID, "favorite", projectId)
	c.JSON(http.StatusOK, gin.H{"success": true, "msg": "favorite fetched", "data": favorite})
}

func (server *Server) update_bookmark(c *gin.Context) {
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

	userID := payload.UserID

	var req models.OtherUserProfiles
	if err := c.ShouldBindJSON(&req); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"success": false, "msg": err.Error()})
		return
	}

	otherUserID, err := primitive.ObjectIDFromHex(req.OtherUserId)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"success": false, "msg": err.Error()})
		return
	}

	userObjectID, err := primitive.ObjectIDFromHex(userID)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"success": false, "msg": err.Error()})
		return
	}

	var success bool
	if req.Action == "add" {
		success, err = server.store.Add_Bookmark(c.Request.Context(), userObjectID, otherUserID)
	} else if req.Action == "remove" {
		success, err = server.store.Remove_Bookmark(c.Request.Context(), userObjectID, otherUserID)
	} else {
		c.JSON(http.StatusBadRequest, gin.H{"success": false, "msg": "Invalid action"})
		return
	}

	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"success": false, "msg": err.Error()})
		return
	}

	if success {
		c.JSON(http.StatusOK, gin.H{"success": true, "msg": "Other user bookmark updated successfully"})
	} else {
		c.JSON(http.StatusInternalServerError, gin.H{"success": false, "msg": "Failed to update other user bookmark"})
	}
}

func (server *Server) get_user_bookmark_by_id(c *gin.Context) {
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

	userID := payload.UserID

	objectID, err := primitive.ObjectIDFromHex(userID)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"success": false, "msg": err.Error()})
		return
	}

	bookmarks, err := server.store.Get_Bookmark_By_Id(c.Request.Context(), objectID)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"success": false, "msg": err.Error()})
		return
	}

	c.JSON(http.StatusOK, gin.H{"success": true, "msg": "Retrieved successfully", "data": bookmarks})
}

func (server *Server) check_boookmark(c *gin.Context) {
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

	userID := payload.UserID
	var req = c.Param("id")

	objectID, err := primitive.ObjectIDFromHex(userID)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"success": false, "msg": err.Error()})
		return
	}

	projectId, err := primitive.ObjectIDFromHex(req)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"success": false, "msg": err.Error()})
		return
	}

	bookmark := server.store.Check_Value_In_Array(c.Request.Context(), objectID, "bookmark", projectId)
	c.JSON(http.StatusOK, gin.H{"success": true, "msg": "Retrieved successfully", "data": bookmark})
}

func (server *Server) fetch_users_by_collaboratorId(c *gin.Context) {
	var req []string
	if err := c.ShouldBindJSON(&req); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"success": false, "msg": err.Error()})
		return
	}

	var userResponses []models.FetchCollaborator

	for _, userIDStr := range req {
		userID, err := primitive.ObjectIDFromHex(userIDStr)
		if err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"success": false, "msg": "Invalid user ID"})
			return
		}

		user, err := server.store.Get_User_By_Id(c.Request.Context(), userID)
		if err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"success": false, "msg": "Failed to fetch user"})
			return
		}

		userResponse := models.FetchCollaborator{
			UserId: user.ID.Hex(),
			Name:   user.Name,
		}

		userResponses = append(userResponses, userResponse)
	}

	c.JSON(http.StatusOK, gin.H{"success": true, "msg": "user fetch", "data": userResponses})
}
