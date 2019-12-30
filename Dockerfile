FROM golang:1.13-alpine3.10 as build

WORKDIR /go/app

COPY . .

RUN set -x && \
  apk update && \
  apk add --no-cache git && \
  go build -o golang-sandbox && \
  go get gopkg.in/urfave/cli.v2@master && \
  go get github.com/oxequa/realize && \
  go get -u github.com/go-delve/delve/cmd/dlv && \
  go build -o /go/bin/dlv github.com/go-delve/delve/cmd/dlv

FROM alpine:3.10

WORKDIR /app

COPY --from=build /go/app/golang-sandbox .

RUN set -x && \
  addgroup go && \
  adduser -D -G go go && \
  chown -R go:go /app/golang-sandbox

CMD ["./golang-sandbox"]
