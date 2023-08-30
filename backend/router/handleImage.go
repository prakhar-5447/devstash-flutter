package router

import (
	"context"
	"io"
	"net/http"
	"strings"

	"github.com/gin-gonic/gin"
	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/bson/primitive"
	"go.mongodb.org/mongo-driver/mongo"
	"go.mongodb.org/mongo-driver/mongo/gridfs"
)

func (server *Server) handleFileUpload(c *gin.Context) {
	err := c.Request.ParseMultipartForm(32 << 20)
	if err != nil {
		c.AbortWithStatusJSON(http.StatusBadRequest, gin.H{"success": false, "msg": "Error parsing form data"})
		return
	}

	file, handler, err := c.Request.FormFile("image")
	if err != nil {
		c.AbortWithStatusJSON(http.StatusBadRequest, gin.H{"success": false, "msg": "Error retrieving file"})
		return
	}
	defer file.Close()

	err = server.store.UploadFileToGridFS(file, handler)
	if err != nil {
		c.AbortWithStatusJSON(http.StatusInternalServerError, gin.H{"success": false, "msg": "Error uploading file"})
		return
	}

	// imageURL, err := server.store.GetImageURL(handler.Filename)
	// if err != nil {
	// 	// Handle error
	// 	c.AbortWithStatusJSON(http.StatusInternalServerError, gin.H{"error": "Error retrieving image URL"})
	// 	return
	// }

	imageURL := handler.Filename
	// Success response
	c.JSON(http.StatusOK, gin.H{"success": true, "msg": "File uploaded successfully", "data": imageURL})

}

func (server *Server) uploadAvatar(c *gin.Context) {
	err := c.Request.ParseMultipartForm(32 << 20)
	if err != nil {
		c.AbortWithStatusJSON(http.StatusBadRequest, gin.H{"success": false, "msg": "Error parsing form data"})
		return
	}

	file, handler, err := c.Request.FormFile("image")
	if err != nil {
		c.AbortWithStatusJSON(http.StatusBadRequest, gin.H{"success": false, "msg": "Error retrieving file"})
		return
	}
	defer file.Close()

	err = server.store.UploadFileToGridFS(file, handler)
	if err != nil {
		c.AbortWithStatusJSON(http.StatusInternalServerError, gin.H{"success": false, "msg": "Error uploading file"})
		return
	}

	// imageURL, err := server.store.GetImageURL(handler.Filename)
	// if err != nil {
	// 	// Handle error
	// 	c.AbortWithStatusJSON(http.StatusInternalServerError, gin.H{"error": "Error retrieving image URL"})
	// 	return
	// }

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
	ID, err := primitive.ObjectIDFromHex(userID)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"success": false, "msg": err.Error()})
		return
	}

	imageURL := handler.Filename
	err = server.store.Update_Avatar(c.Request.Context(), imageURL, ID)
	if err != nil {
		c.JSON(http.StatusUnauthorized, gin.H{"success": false, "msg": "Failed to upload"})
		return
	}
	c.JSON(http.StatusOK, gin.H{"success": true, "msg": "File uploaded successfully", "data": imageURL})

}

func (server *Server) handleImage(c *gin.Context) {
	filename := c.Param("filename")

	var fileInfo struct {
		ID primitive.ObjectID `bson:"_id"`
	}

	ctx := context.TODO()

	filter := bson.M{"filename": filename}
	err := server.store.GetCollection("fs.files").FindOne(ctx, filter).Decode(&fileInfo)
	if err != nil {
		if err == mongo.ErrNoDocuments {
			c.String(http.StatusNotFound, "Image not found")
			return
		}
		c.String(http.StatusInternalServerError, "Failed to find image")
		return
	}

	file, contentType, err := server.store.GetFileByID(fileInfo.ID)
	if err != nil {
		c.String(http.StatusInternalServerError, "Failed to get file from GridFS")
		return
	}
	defer file.Close()

	c.Header("Content-Type", contentType)

	_, err = io.Copy(c.Writer, file)
	if err != nil {
		c.String(http.StatusInternalServerError, "Failed to read image data")
		return
	}
}

func (server *Server) downloadImage(c *gin.Context) {
	filename := c.Param("filename")

	var fileInfo struct {
		ID primitive.ObjectID `bson:"_id"`
	}

	ctx := context.TODO()

	database := server.store.GetDatabase()

	bucket, err := gridfs.NewBucket(database)
	if err != nil {
		c.String(http.StatusInternalServerError, "Failed to create GridFS bucket")
		return
	}

	filter := bson.M{"filename": filename}
	err = server.store.GetCollection("fs.files").FindOne(ctx, filter).Decode(&fileInfo)
	if err != nil {
		if err == mongo.ErrNoDocuments {
			c.String(http.StatusNotFound, "Image not found")
			return
		}
		c.String(http.StatusInternalServerError, "Failed to find image")
		return
	}

	downloadStream, err := bucket.OpenDownloadStream(fileInfo.ID)
	if err != nil {
		c.String(http.StatusInternalServerError, "Failed to open GridFS download stream")
		return
	}
	defer downloadStream.Close()

	contentType := getContentType(filename)

	c.Header("Content-Type", contentType)

	_, err = io.Copy(c.Writer, downloadStream)
	if err != nil {
		c.String(http.StatusInternalServerError, "Failed to read image data")
		return
	}
}

func (server *Server) deleteImage(c *gin.Context) {
	filename := c.Param("filename")

	var fileInfo struct {
		ID primitive.ObjectID `bson:"_id"`
	}

	ctx := context.TODO()

	database := server.store.GetDatabase()

	bucket, err := gridfs.NewBucket(database)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"success": false, "msg": "Failed to create GridFS bucket"})
		return
	}

	filter := bson.M{"filename": filename}
	err = server.store.GetCollection("fs.files").FindOne(ctx, filter).Decode(&fileInfo)
	if err != nil {
		if err == mongo.ErrNoDocuments {
			c.JSON(http.StatusNotFound, gin.H{"success": false, "msg": "Image not found"})
			return
		}
		c.JSON(http.StatusInternalServerError, gin.H{"success": false, "msg": "Failed to find image"})

		return
	}

	err = bucket.Delete(fileInfo.ID)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"success": false, "msg": "Failed to delete image"})
		return
	}

	c.JSON(http.StatusOK, gin.H{"success": true, "msg": "Image deleted successfully"})
}

func getContentType(filename string) string {
	extension := strings.ToLower(strings.TrimPrefix(strings.TrimPrefix(filename, "."), "."))

	switch extension {
	case "jpg", "jpeg":
		return "image/jpeg"
	case "png":
		return "image/png"
	case "gif":
		return "image/gif"
	default:
		return "application/octet-stream"
	}
}
