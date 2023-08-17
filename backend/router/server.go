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

	router.POST("/signup", server.sign_up)
	router.POST("/login", server.sign_in)
	router.GET("/getuser", server.fetch_user)
	router.GET("/getuser/:id", server.fetch_user_by_id)
	router.PUT("/profile", server.update_profile)

	router.GET("/favorite", server.get_user_favorite_by_id)
	router.PUT("/favorite", server.update_favorite)
	router.GET("/checkfavorite/:id", server.check_favorite)

	router.GET("/bookmark", server.get_user_bookmark_by_id)
	router.PUT("/bookmark", server.update_bookmark)
	router.GET("/checkbookmark/:id", server.check_boookmark)
	router.POST("/getcollaboratoruser", server.fetch_users_by_collaboratorId)

	router.POST("/createProject", server.create_project)
	router.PUT("/updateProject/:id", server.update_project)
	router.DELETE("/deleteproject/:id", server.delete_project)
	router.GET("/getprojects", server.get_projects_by_userId)
	router.GET("/getprojectbyid/:id", server.get_project_by_id)

	router.GET("/contact", server.get_contact)
	router.PUT("/contact", server.update_contact)

	router.POST("/educations", server.create_education)
	router.PUT("/educations", server.update_education)
	router.GET("/educations", server.get_education)
	router.DELETE("/educations/:id", server.delete_education)

	router.PUT("/skills", server.add_skill)
	router.DELETE("/skills", server.delete_skill)
	router.GET("/skills", server.get_skills)

	router.PUT("/socials", server.update_social)
	router.GET("/socials", server.get_social)

	router.POST("/upload", server.handleFileUpload)
	router.POST("/avatar", server.uploadAvatar)
	router.GET("/images/:filename", server.handleImage)
	router.DELETE("/images/:filename", server.deleteImage)
	server.router = router
}

func (server *Server) Start(address string) error {
	return server.router.Run(address)
}

// func errorResponse(err error) gin.H {
// 	return gin.H{"error": err.Error()}
// }
