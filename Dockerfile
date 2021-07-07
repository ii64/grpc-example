# build up service
FROM golang:alpine AS builder
WORKDIR $GOPATH/src/github.com/gogo/grpc-example
RUN apk update && apk add --no-cache git
COPY . .
RUN go get -d -v
RUN GOOS=linux GOARCHamd64 go build -v -o /go/bin/grpc-example

# use alpine
FROM alpine:latest
WORKDIR /app
ENV PATH $PATH:/app

COPY --from=builder /go/bin/grpc-example /app/

RUN chmod +x /app/grpc-example

CMD ["grpc-example"]