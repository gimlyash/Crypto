FROM golang:1.23-alpine AS builder

WORKDIR /app

COPY go.mod go.sum* ./
RUN go mod download

COPY . .

RUN if ls cmd/aggregator/*.go >/dev/null 2>&1; then \
    CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o /aggregator ./cmd/aggregator; \
  else \
    echo "aggregator entrypoint not yet implemented, building placeholder"; \
    printf 'package main\nimport \"fmt\"\nfunc main(){fmt.Println(\"aggregator placeholder\")}\n' > /tmp/main.go; \
    CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o /aggregator /tmp/main.go; \
  fi

FROM gcr.io/distroless/base-debian12

WORKDIR /app
COPY --from=builder /aggregator /app/aggregator

ENTRYPOINT ["/app/aggregator"]



