package router

import (
	"net/http"
	"time"

	"github.com/gin-gonic/gin"
	"github.com/prakhar-5447/db"
	"github.com/prakhar-5447/models"
	"go.mongodb.org/mongo-driver/bson/primitive"
)

func (server *Server) createMessage(c *gin.Context) {
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

	var message models.MessageRequest
	if err := c.ShouldBindJSON(&message); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"success": false, "msg": "Invalid request body"})
		return
	}

	dateTime := primitive.NewDateTimeFromTime(time.Now())

	var dbMessage = &db.Message{
		UserId:      id,
		Subject:     message.Subject,
		Description: message.Description,
		SenderEmail: message.SenderEmail,
		CreatedAt:   dateTime,
	}

	msgId, err := server.store.Create_Message(c.Request.Context(), dbMessage)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"success": false, "msg": err.Error()})
		return
	}
	dbMessage.ID = msgId

	fcmtoken, err := server.store.GetFCMToken(c.Request.Context(), id)
	if err != nil {
		c.JSON(http.StatusOK, gin.H{"success": true, "msg": "Message created but notification not send", "messageID": msgId, "message": dbMessage})
		return
	}
	
	err = server.sendNotification("alpha", "this is my description", fcmtoken.FCMToken)
	if err != nil {
		c.JSON(http.StatusOK, gin.H{"success": true, "msg": "Message created but notification not send", "messageID": msgId, "message": dbMessage})
		return
	}

	c.JSON(http.StatusOK, gin.H{"success": true, "msg": "Message created", "messageID": id, "message": dbMessage})
}
