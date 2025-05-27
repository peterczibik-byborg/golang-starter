# Makefile for running templ generate with watch, proxy, and go run
run-server:
	templ generate --watch --proxy="http://localhost:3030" --cmd="go run src/main.go"
run-static:
	npx vite build . --watch
build:
	templ generate && go build -o ./tmp/main ./src/main.go
build-static:
	npx vite build
