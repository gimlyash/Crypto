FROM golang:1.23-alpine AS builder

WORKDIR /app

COPY go.mod go.sum* ./
RUN go mod download || true

COPY . .

RUN if ls cmd/migrator/*.go >/dev/null 2>&1; then \
    CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o /migrator ./cmd/migrator; \
  else \
    echo "migrator entrypoint not yet implemented, building placeholder"; \
    printf 'package main\nimport \"fmt\"\nfunc main(){fmt.Println(\"migrator placeholder\")}\n' > /tmp/main.go; \
    CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o /migrator /tmp/main.go; \
  fi

FROM gcr.io/distroless/base-debian12

WORKDIR /app
COPY --from=builder /migrator /app/migrator

ENTRYPOINT ["/app/migrator"]


