#!/usr/bin/env bash


goreleaser release --snapshot --rm-dist -f .goreleaser-macos.yml
