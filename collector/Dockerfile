FROM golang:1.23-alpine AS builder

WORKDIR /app

COPY go.mod go.sum* ./
RUN go mod download

COPY . .

RUN if ls cmd/collector/*.go >/dev/null 2>&1; then \
    CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o /collector ./cmd/collector; \
  else \
    echo "collector entrypoint not yet implemented, building placeholder"; \
    printf 'package main\nimport \"fmt\"\nfunc main(){fmt.Println(\"collector placeholder\")}\n' > /tmp/main.go; \
    CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o /collector /tmp/main.go; \
  fi

FROM gcr.io/distroless/base-debian12

WORKDIR /app
COPY --from=builder /collector /app/collector

ENTRYPOINT ["/app/collector"]




