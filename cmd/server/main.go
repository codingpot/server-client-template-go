package main

import (
	"fmt"
	"log"
	"net"

	"github.com/codingpot/server-client-template-go/pkg/pbs"
	"github.com/codingpot/server-client-template-go/pkg/serv"

	"google.golang.org/grpc"
	"google.golang.org/grpc/health"
	"google.golang.org/grpc/health/grpc_health_v1"
	"google.golang.org/grpc/reflection"
)

func main() {
	fmt.Printf("gRPC server is listening at 0.0.0.0:%s\n", "9000")

	listener, err := net.Listen("tcp", fmt.Sprintf(":%s", "9000"))
	if err != nil {
		log.Fatalf("failed to listen: %v", err)
	}

	s := serv.Server{}

	grpcServer := grpc.NewServer()

	pbs.RegisterDummyServiceServer(grpcServer, &s)

	healthServer := health.NewServer()
	healthServer.SetServingStatus("grpc.health.v1.Health", grpc_health_v1.HealthCheckResponse_SERVING)
	grpc_health_v1.RegisterHealthServer(grpcServer, healthServer)

	reflection.Register(grpcServer)

	if err := grpcServer.Serve(listener); err != nil {
		log.Fatalf("failed to serve: %s", err)
	}
}
