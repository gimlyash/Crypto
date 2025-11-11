SHELL := /bin/sh

.PHONY: help collector-build aggregator-build migrator-build docker-build up down ps lint fmt tidy

help:
\t@echo "Available targets:"
\t@echo "  collector-build    Build collector binary"
\t@echo "  aggregator-build   Build aggregator binary"
\t@echo "  migrator-build     Build migrator binary"
\t@echo "  docker-build       Build all project Docker images"
\t@echo "  up                 Start docker compose environment"
\t@echo "  down               Stop docker compose environment"
\t@echo "  ps                 List running containers"

collector-build:
\tcd collector && go build ./cmd/collector

aggregator-build:
\tcd aggregator && go build ./cmd/aggregator

migrator-build:
\tcd migrator && go build ./cmd/migrator

docker-build:
\tdocker compose -f deploy/docker-compose.yml build

up:
\tdocker compose -f deploy/docker-compose.yml up -d

down:
\tdocker compose -f deploy/docker-compose.yml down

ps:
\tdocker compose -f deploy/docker-compose.yml ps

lint:
\tgolangci-lint run ./...

fmt:
\tgo fmt ./...

tidy:
\tgo mod tidy


