.PHONY: all
.DEFAULT_GOAL := all

PROTOC := $(shell which protoc)
PROTOC_GEN_GO := $(shell which protoc-gen-go)
PROTOC_VERSION := 3.17.0
PROTOC_RELEASE := https://github.com/protocolbuffers/protobuf/releases
PROTO_FILES := $(shell find . -name "*.proto" -type f)
UNAME := $(shell uname)
GOPATH := ${GOPATH}

install:
ifeq ($(PROTOC),)
ifeq ($(UNAME),Darwin)
	brew install protobuf
endif
ifeq ($(UNAME), Linux)
	curl -LO "$(PROTOC_RELEASE)/download/v$(PROTOC_VERSION)/protoc-$(PROTOC_VERSION)-linux-x86_64.zip" && \
	unzip protoc-$(PROTOC_VERSION)-linux-x86_64.zip -d $${HOME}/.local && \
	export PATH="$${PATH}:$${HOME}/.local/bin"
endif
endif
ifeq ($(PROTOC_GEN_GO),)
	go mod download && grep _ ./cmd/tools/tools.go | cut -d' ' -f2 | sed 's/\r//' | xargs go install -v
endif

all:
	mkdir -p ./pkg/pbs/
	protoc \
    --proto_path=. \
    --go_out=. \
    --go_opt=paths=source_relative \
    --go-grpc_out=. \
    --go-grpc_opt=paths=source_relative \
    $(PROTO_FILES)

clean:
	rm -rf ./pkg/pbs/*.pb.go
