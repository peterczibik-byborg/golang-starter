FROM node:22-bullseye AS node-builder

WORKDIR /app

COPY package.json package-lock.json ./
COPY vite.config.mjs tailwind.config.js ./

COPY src/*.css ./src/

RUN npm ci

RUN npm run build

# Start from the official Golang image for building
FROM golang:1.24-bullseye AS golang-builder

WORKDIR /app
COPY go.mod go.sum ./

# Download dependencies
RUN go mod download

# Copy the source code
COPY src/ ./src/
COPY templates/ ./templates/

# Build the Go app
RUN go build -o main ./src/main.go

FROM golang:1.24-bullseye
WORKDIR /app

# Copy the built binary from the golang-builder
COPY --from=golang-builder /app/main .
COPY --from=node-builder /app/static ./static

# Expose the application port
EXPOSE 3030

# Run the binary
ENTRYPOINT ["/app/main"]
