package router

import (
	"net/http"
	"time"

	"github.com/gin-gonic/gin"
	"github.com/prakhar-5447/db"
	"github.com/prakhar-5447/models"
)

func (server *Server) CreateUser(c *gin.Context) {
	var req models.CreateUserRequest
	if err := c.ShouldBindJSON(&req); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	found, err := server.store.CheckUserByEmail(c, req.Email)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}
	if found {
		c.JSON(http.StatusOK, gin.H{"message": "User with same email already exist"})
		return
	}

	found, err = server.store.CheckUserByUsername(c, req.Username)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}
	if found {
		c.JSON(http.StatusOK, gin.H{"message": "User with same username already exist"})
		return
	}

	user := &db.User{}
	user.Name = req.Name
	user.Avatar = req.Avatar
	user.Username = req.Username
	user.Password = req.Password
	user.Email = req.Email
	user.Phone = req.Phone
	user.Description = req.Description
	if err := server.store.CreateUser(c.Request.Context(), user); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	token, err := server.tokenMaker.CreateToken(user.Username, time.Hour*24)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to generate token"})
		return
	}

	c.JSON(http.StatusOK, gin.H{"message": "User created successfully", "token": token})

}

func (server *Server) GetUser(c *gin.Context) {
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

	username := payload.Username
	user, err := server.store.FindUserByUsername(c.Request.Context(), username)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, user)
}

func (server *Server) Login(c *gin.Context) {
	var req models.LoginRequest
	if err := c.ShouldBindJSON(&req); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	user, err := server.store.FindByUsernameOrEmail(c.Request.Context(), req.UsernameOrEmail, req.Password)
	if err != nil {
		if httpErr, ok := err.(*models.HTTPError); ok {
			c.JSON(httpErr.StatusCode, gin.H{"error": httpErr.Message})
			return
		}
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	token, err := server.tokenMaker.CreateToken(user.Username, time.Hour*24) // Adjust the token duration as needed
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to generate token"})
		return
	}

	c.JSON(http.StatusOK, gin.H{"token": token})
}

func (server *Server) UpdateProfile(c *gin.Context) {
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

	username := payload.Username
	user, err := server.store.FindUserByUsername(c.Request.Context(), username)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	var req models.CreateUserRequest
	if err := c.ShouldBindJSON(&req); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	if req.Name != "" {
		user.Name = req.Name
	}
	if req.Avatar != "" {
		user.Avatar = req.Avatar
	}
	if req.Username != "" {
		user.Username = req.Username
	}
	if req.Email != "" {
		user.Email = req.Email
	}
	if req.Phone != "" {
		user.Phone = req.Phone
	}
	if req.Description != "" {
		user.Description = req.Description
	}

	success := server.store.UpdateUserProile(c.Request.Context(), user)
	if success {
		c.JSON(http.StatusOK, gin.H{"success": true, "message": "Profile updated successfully"})
	} else {
		c.JSON(http.StatusInternalServerError, gin.H{"success": false, "error": "Failed to update profile"})
	}
}
