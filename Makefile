default: build

NS=eengstrom
IMAGE=stateful-hello
PORTS=3000:3000
VOLUMES=$(shell pwd)/data:/app/data

include .docker.mk

.PHONY: setup start distclean

setup:
	mkdir -p data

start: setup start-docker

distclean: distclean-docker
	-rm -rf data
