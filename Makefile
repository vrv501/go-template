#!/usr/bin/make

export GOPRIVATE := ''
coverage_dir := coverage

vendor: go.mod go.sum
	@go mod download
	@go mod vendor
.PHONY: vendor

build: vendor
	CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o bin/app -a -v cmd/main.go
.PHONY: build

lint: vendor .golangci.yml
	@golangci-lint --version
	golangci-lint run --config .golangci.yml
.PHONY: lint

tidy:
	@go mod tidy
.PHONY: tidy

degenerate:
	@find . -type f -name '*_mock.go' -delete
.PHONY: degenerate

generate: degenerate vendor
	@go generate ./...
.PHONY: generate

test: vendor generate
	CGO_ENABLED=1 go test -race -v ./...
.PHONY: test

coverage: vendor generate
	@mkdir -p "$(coverage_dir)"
	CGO_ENABLED=1 go test -race -covermode=atomic -coverpkg=./... -coverprofile=$(coverage_dir)/coverage.out -v ./...
.PHONY: coverage

clean:
	@rm -rf coverage bin vendor
.PHONY: clean

run:
	@go run ./cmd/main.go
.PHONY: run

clean-build: degenerate clean build
.PHONY: clean-build
