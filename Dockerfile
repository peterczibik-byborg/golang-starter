# Start from the official Golang image for building
FROM golang:1.24-bullseye AS builder

WORKDIR /app
COPY go.mod go.sum ./

# Download dependencies
RUN go mod download

# Copy the source code
COPY src/ ./src/
COPY templates/ ./templates/

# Build the Go app
RUN go build -o main ./src/main.go

# Start a new minimal image for running
FROM gcr.io/distroless/base-debian12
WORKDIR /app

# Copy the built binary from the builder
COPY --from=builder /app/main .

COPY static/ ./static/

# Expose the application port
EXPOSE 3030

# Run the binary
ENTRYPOINT ["/app/main"]
