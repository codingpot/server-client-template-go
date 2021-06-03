[![CI](https://github.com/codingpot/server-client-template-go/actions/workflows/ci.yml/badge.svg)](https://github.com/codingpot/server-client-template-go/actions/workflows/ci.yml) [![Go Report Card](https://goreportcard.com/badge/github.com/codingpot/server-client-template-go)](https://goreportcard.com/report/github.com/codingpot/server-client-template-go)

# Server & Client Template in Golang (gRPC/protobuf)

This repository provides server & client boilerplate codes written in golang. The server & client communicated via gRPC/protobuf interface. It's boring to fork the repo and replace all the placeholders to fit your own environment. Instead, this repository give an easy way to **"copy"**.

# Initial Setup

1. Click **"Use this template"** button.
2. Fill up the name of repository that you want to create.
3. When the repository is copied over to your place, a `setup` GitHub Action gets triggered. It essentially leaves a `PR` when it is done.
4. Merge the `PR` named `Initial Setup`.
5. When the `PR` is done merged, it triggers another `ci` GitHub Action. Wait until it ends.
6. Run `make install`. You can also specify PROTOC_VERSION if needed like this:
   ```shell
   PROTOC_VERSION=3.17.0 make install
   ```

# What can you do with initial setup?

You can simply ping from a client to server with a dummy message via `DummyService`.

# What should you do after initial setup?

1. Simply define your own protocol buffer services and messages in `/pkg/pbs/`.
2. Generate `*.pb.go` files via `make clean install all`.
3. Implement your message receiving logic in `/pkg/serv/`.
4. Write your own business logic to leverage your own gRPC/protobuf services and messages.

# Directory Structure

```
|-- .github    -- (D)(0)
|
|-- cmd
|   |-- client -- (D)(1)
|   |
|   |-- server -- (D)(2)
|   |
|   `-- tools  -- (D)(3)
|
|
|-- internal   -- (D)(4)
|
|-- model      -- (D)(5)
|
|-- pkg
|   |-- pbs    -- (D)(6)
|   |
|   `-- serv   -- (D)(7)
|
`-- Makefile   -- (F)(8)
```

_(D) indicates `Directory`, and (F) indicated `File`_

0. Any GitHub Action should go into `.github`. Basic CI workflow is provided. It simply builds `cmd/client/main.go` and `cmd/server/main.go` to check if there is any errors.

1. `cmd/client` is for launching Client application. Boilerplate codes for sending out `DummyService`'s `GetHello` rpc is provided.

2. `cmd/server` is for launching Server application. Boilerplate codes for set Server and listening on a specific port is provided.

3. `cmd/tools` is for listing up any go packages to be included. Boilerplate codes list up `protoc-gen-go-grpc` and `protoc-gen-go`.

4. `internal` is an empty as in the initial setup. You can store any business logics for any internal use here.

5. `model` is an empty as in the initial setup. You can store any models to work with internal business logics here.

6. `pkg/pbs` contains protocol buffer related stuff. Usually files with the extensions of `*.proto`, `*.pb.go` should be stored in here.

7. `pkg/serv` is there to handle incoming messages from client to server.

8. `Makefile` mainly provides two rules, installing gRPC/protobuf environment via `make install` and generating protobuf into the appropriate folder `pkg/pbs` via `make all`.
