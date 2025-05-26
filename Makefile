# Makefile for running templ generate with watch, proxy, and go run
run:
	templ generate --watch --proxy="http://localhost:3030" --cmd="go run src/main.go"
build:
	templ generate && go build -o ./tmp/main ./src/main.go
build-css:
	tailwindcss -i ./src/css/index.css -o ./static/css/index.css
build-css-watch:
	tailwindcss -w ./src/css/index.css -o ./static/css/index.css