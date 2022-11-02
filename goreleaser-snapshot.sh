#!/usr/bin/env bash

#docker run --rm --privileged \
#-v $(pwd):/go/src/github.com/neilotoole/sqlitr2 \
#-v /var/run/docker.sock:/var/run/docker.sock \
#-w /go/src/github.com/neilotoole/sqlitr2 \
#neilotoole/xcgo:latest goreleaser --snapshot --rm-dist

goreleaser --snapshot --rm-dist -f .goreleaser-darwin.yml
