package main

import (
	_ "context"
	"fmt"
	"log"
	"net"
	"net/http"

	"github.com/peteyycz/arthur/templates"
)

func root(w http.ResponseWriter, req *http.Request) {
	err := templates.Root().Render(req.Context(), w)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
	}
}

func main() {
	http.HandleFunc("GET /", root)

	http.Handle("GET /static/", http.StripPrefix("/static/", http.FileServer(http.Dir("./static"))))

	port := "3030"

	// Create a listener first so we can confirm it's listening before starting to serve
	listener, err := net.Listen("tcp", fmt.Sprintf(":%s", port))
	if err != nil {
		log.Fatalf("Failed to listen on port %s: %v", port, err)
	}

	// Now we know the port is successfully bound
	log.Printf("Server is running http://localhost:%s", port)

	// Serve using our listener
	err = http.Serve(listener, nil)
	if err != nil {
		log.Fatalf("Server failed: %v", err)
	}
}
