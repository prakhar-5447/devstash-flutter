package router

import (
	"net/http"

	"github.com/gin-gonic/gin"
	"github.com/prakhar-5447/db"
	"github.com/prakhar-5447/models"
)

func (server *Server) sign_up(c *gin.Context) {
	var req models.CreateUserRequest
	if err := c.ShouldBindJSON(&req); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	found, err := server.store.Check_User_By_Email(c, req.Email)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}
	if found {
		c.JSON(http.StatusOK, gin.H{"message": "User with the same email already exists"})
		return
	}

	found, err = server.store.Check_User_By_Username(c, req.Username)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}
	if found {
		c.JSON(http.StatusOK, gin.H{"message": "User with the same username already exists"})
		return
	}

	user := &db.User{
		Name:        req.Name,
		Username:    req.Username,
		Password:    req.Password,
		Email:       req.Email,
		Description: req.Description,
	}

	userId, err := server.store.Create_User(c.Request.Context(), user)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	socials := &db.Socials{
		UserId: userId,
	}

	if err := server.store.Create_Socials(c.Request.Context(), socials); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	contact := db.Contact{
		UserId: userId,
	}

	if err := server.store.Create_Contact(c.Request.Context(), contact); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	token, err := server.tokenMaker.CreateToken(user.ID.Hex())
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to generate token"})
		return
	}

	c.JSON(http.StatusOK, gin.H{
		"message": "User created successfully",
		"token":   token,
		"user":    user,
	})
}

func (server *Server) sign_in(c *gin.Context) {
	var req models.LoginRequest
	if err := c.ShouldBindJSON(&req); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	user, err := server.store.Find_User_By_Username_Or_Email(c.Request.Context(), req.UsernameOrEmail, req.Password)
	if err != nil {
		if httpErr, ok := err.(*models.HTTPError); ok {
			c.JSON(httpErr.StatusCode, gin.H{"error": httpErr.Message})
			return
		}
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	token, err := server.tokenMaker.CreateToken(user.ID.Hex())
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to generate token"})
		return
	}

	c.JSON(http.StatusOK, gin.H{"token": token, "user": user})
}
