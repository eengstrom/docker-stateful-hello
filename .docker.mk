# -*- Makefile -*- for Docker images
# include in your Makefile via:
# - include .docker.mk

# Image naming
NS        	:= $(addsuffix /,$(NS))
IMAGE     	?= SETME
VERSION   	?= latest
FULLIMAGE 	:= $(NS)$(IMAGE):$(VERSION)

# Container naming
CONTAINER 	?= $(IMAGE)
INSTANCE  	?= default
NAME      	:= $(and $(CONTAINER),$(INSTANCE),$(CONTAINER)-$(INSTANCE))
RUNNAME   	:= $(addprefix --name ,$(NAME))

# Container ports/volumes
PORTS     	:= $(if $(PORTS),$(addprefix -p ,$(PORTS)),)
VOLUMES   	:= $(if $(VOLUMES),$(addprefix -v ,$(VOLUMES)),)

# Uncmment to debug this makefile
#DEBUG       := echo

#.PHONY: *-docker  # can't do this since I'm using implicit rules to find them

build-docker:
	$(DEBUG) docker build -t $(FULLIMAGE) .

push-docker:
	$(DEBUG) docker push $(FULLIMAGE)

shell-docker:
	$(DEBUG) docker run --rm $(RUNNAME) -it $(PORTS) $(VOLUMES) $(ENV) $(FULLIMAGE) /bin/bash

run-docker:
	$(DEBUG) docker run --rm $(RUNNAME) $(PORTS) $(VOLUMES) $(ENV) $(FULLIMAGE)

start-docker:
	$(DEBUG) docker run -d --rm $(RUNNAME) $(PORTS) $(VOLUMES) $(ENV) $(FULLIMAGE)

stop-docker:
	-$(DEBUG) docker stop $(NAME)

rm-docker:
	-$(DEBUG) docker rm $(NAME)

rmi-docker:
	-$(DEBUG) docker rmi $(NS)$(IMAGE)

release-docker: build
	make push -e VERSION=$(VERSION)

clean-docker:

distclean-docker: stop rm rmi clean

prune-docker:

# implicit rule to turn all bare targets into calls to -docker targets
# idea from: https://stackoverflow.com/questions/11958626/make-file-warning-overriding-commands-for-target
%:  %-docker
	@ true
