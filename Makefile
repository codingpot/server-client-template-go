.PHONY: all
.DEFAULT_GOAL := all

PROTO_FILES := $(shell find . -name "*.proto" -type f)

all:
	mkdir -p ./pkg/pbs/
	protoc \
    --proto_path=. \
    --go_out=. \
    --go_opt=paths=source_relative \
    --go-grpc_out=. \
    --go-grpc_opt=paths=source_relative \
    $(PROTO_FILES)