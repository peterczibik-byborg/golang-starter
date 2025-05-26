package main

import (
	_ "context"
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

	http.Handle("GET /css/", http.StripPrefix("/", http.FileServer(http.Dir("./dist"))))

	http.ListenAndServe(":3030", nil)
}
