# Go parameters
GOCMD=go
GOBUILD=$(GOCMD) build
GOCLEAN=$(GOCMD) clean
GOTEST=$(GOCMD) test
GOGET=$(GOCMD) get


GOARCH=$(shell $(GOCMD) env GOARCH)
GOOS=$(shell $(GOCMD) env GOOS)

# Output directory
BIN_DIR=./bin

# Main binary name
BINARY_NAME=balance-monitor

# Build flags
LDFLAGS=-ldflags "-w -s"

# Source files/directories
SRC=$(shell find . -type f -name '*.go');

# Test files/directories
TEST=./...

all: test build

test:
	$(GOTEST) -v ./...

release: set_linux build

set_linux:
	$(eval GOARCH=amd64)
	$(eval GOOS=linux)

build:
	echo "building..."
	GOARCH=$(GOARCH) GOOS=$(GOOS) $(GOBUILD) -v $(LDFLAGS) -o $(BIN_DIR)/$(BINARY_NAME) .

run: build
	echo "running..." 
	$(BIN_DIR)/$(BINARY_NAME) -c config.yaml

.PHONY: all build test clean run release