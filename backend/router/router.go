package router

import (
	"fmt"
	"log"
	"net/http"

	"github.com/gorilla/mux"
	// "myapp/middleware"
)

func Router() *mux.Router {
	// Init the mux router
	router := mux.NewRouter()

	// Route handles & endpoints

	// Get request
	router.HandleFunc("/get", func(w http.ResponseWriter, r *http.Request) {
		fmt.Print("called")
	},
	).Methods("GET", "OPTIONS")

	// serve the app
	log.Println("Server started")
	return router
}

func ErrorHandle(err error) {
	if err != nil {
		log.Fatal("router error", err)
	}
}
