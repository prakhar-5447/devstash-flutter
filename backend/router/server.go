package router

import (
	"fmt"

	"github.com/gin-gonic/gin"
	"github.com/prakhar-5447/db"
	"github.com/prakhar-5447/token"
	"github.com/prakhar-5447/util"
)

type Server struct {
	config     util.Config
	store      db.Store
	tokenMaker token.Maker
	router     *gin.Engine
}

func NewServer(config util.Config, store db.Store) (*Server, error) {
	tokenMaker, err := token.NewPasetoMaker(config.TOKEN_SYMMETRIC_KEY)
	if err != nil {
		return nil, fmt.Errorf("cannot create token maker: %w", err)
	}

	server := &Server{
		config:     config,
		store:      store,
		tokenMaker: tokenMaker,
	}

	server.setupRouter()
	return server, nil
}

func (server *Server) setupRouter() {
	router := gin.Default()

	router.POST("/signup", server.CreateUser)
	router.POST("/login", server.Login)
	router.GET("/getuser", server.GetUser)
	router.PUT("/profile", server.UpdateProfile)
	router.POST("/upload", server.handleFileUpload)
	router.GET("/images/:filename", server.handleImage)
	router.DELETE("/images/:filename", server.deleteImage)
	router.POST("/createProject", server.CreateProject)
	router.GET("/getprojects", server.GetProjectsByUser)
	router.PUT("/updateProject/:id", server.UpdateProjectByID)
	router.DELETE("/deleteproject/:id", server.DeleteProject)
	router.GET("/favorite", server.GetUserFavoritesByID)
	router.PUT("/favorite", server.AddOrRemoveUserFromFavorite)
	router.GET("/bookmark", server.GetUserBookmarksByID)
	router.PUT("/bookmark", server.AddOrRemoveUserFromBookmark)
	server.router = router
}

func (server *Server) Start(address string) error {
	return server.router.Run(address)
}

func errorResponse(err error) gin.H {
	return gin.H{"error": err.Error()}
}
