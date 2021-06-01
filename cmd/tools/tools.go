// +build tools

// tools is a special package to capture the following packages into `go.mod`.
//
// These tools are used to generate Go files from Protocol Buffers.
// But, these tools are not used directly in the code.
// That's why we're capturing the packages in this file.
//
// Then, the following command will always install the same versions defined in `go.mod`.
//
//   go install google.golang.org/grpc/cmd/protoc-gen-go-grpc google.golang.org/protobuf/cmd/protoc-gen-go
package tools

import (
	_ "google.golang.org/grpc/cmd/protoc-gen-go-grpc"
	_ "google.golang.org/protobuf/cmd/protoc-gen-go"
)