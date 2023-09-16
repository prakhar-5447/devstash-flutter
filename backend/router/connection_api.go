package router

import (
	"net/http"

	"go.mongodb.org/mongo-driver/bson/primitive"

	"github.com/gin-gonic/gin"
	"github.com/prakhar-5447/models"
)

func (server *Server) connection(c *gin.Context) {
	var req models.OtherUserProfiles
	if err := c.ShouldBindJSON(&req); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"success": false, "msg": err.Error()})
		return
	}

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

	id, err := primitive.ObjectIDFromHex(userID)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"success": false, "msg": err.Error()})
		return
	}

	targetId, err := primitive.ObjectIDFromHex(req.OtherUserId)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"success": false, "msg": err.Error()})
		return
	}

	if req.Action == "add" {
		err := server.store.AddFollowing(c.Request.Context(), id, targetId)
		if err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"success": false, "msg": "Failed to follow user"})
			return
		}
	} else if req.Action == "remove" {
		err := server.store.RemoveFollowing(c.Request.Context(), id, targetId)
		if err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"success": false, "msg": "Failed to unfollow user"})
			return
		}
	} else {
		c.JSON(http.StatusInternalServerError, gin.H{"success": false, "msg": "Invalid action performed"})
		return
	}
	c.JSON(http.StatusOK, gin.H{"success": true, "msg": "Action successfully performed"})
	return
}

func (server *Server) get_following(c *gin.Context) {
	userID := c.Param("id")
	id, err := primitive.ObjectIDFromHex(userID)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid user ID"})
		return
	}

	following, err := server.store.GetFollowing(c.Request.Context(), id)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, gin.H{"following": following})
}

func (server *Server) get_followers(c *gin.Context) {
	userID := c.Param("id")
	id, err := primitive.ObjectIDFromHex(userID)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid user ID"})
		return
	}

	followers, err := server.store.GetFollowers(c.Request.Context(), id)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, gin.H{"followers": followers})
}
