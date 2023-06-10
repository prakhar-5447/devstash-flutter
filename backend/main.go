// Go package
package main

/// Go fmt import
import (
	"log"
	"net/http"

	"github.com/prakhar-5447/router"
)

// Go main function
func main() {

	// Init the mux router
	r := router.Router()

	log.Fatal(http.ListenAndServe(":8080", r))
}