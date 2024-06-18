# syntax=docker/dockerfile:1

# Comments are provided throughout this file to help you get started.
# If you need more help, visit the Dockerfile reference guide at
# https://docs.docker.com/go/dockerfile-reference/

################################################################################
# Pick a base image to serve as the foundation for the other build stages in
# this file.
#
# For illustrative purposes, the following FROM command
# is using the alpine image (see https://hub.docker.com/_/alpine).
# By specifying the "latest" tag, it will also use whatever happens to be the
# most recent version of that image when you build your Dockerfile.
# If reproducability is important, consider using a versioned tag
# (e.g., alpine:3.17.2) or SHA (e.g., alpine@sha256:c41ab5c992deb4fe7e5da09f67a8804a46bd0592bfdf0b1847dde0e0889d2bff).
FROM ubuntu:latest as base

RUN apt-get update -y && apt-get install -y \
	git \
	curl

################################################################################
# Create a stage for building/compiling the application.
#
# The following commands will leverage the "base" stage above to generate
# a "hello world" script and make it executable, but for a real application, you
# would issue a RUN command for your application's build process to generate the
# executable. For language-specific examples, take a look at the Dockerfiles in
# the Awesome Compose repository: https://github.com/docker/awesome-compose
FROM base as build
COPY <<EOF /bin/hello.sh
#!/usr/bin/env bash
i=0
while true; do (($i++)); echo "${i}" &> /dev/null ; done
EOF
RUN chmod +x /bin/hello.sh

################################################################################
# Create a final stage for running your application.
#
# The following commands copy the output from the "build" stage above and tell
# the container runtime to execute it when the image is run. Ideally this stage
# contains the minimal runtime dependencies for the application as to produce
# the smallest image possible. This often means using a different and smaller
# image than the one used for building the application, but for illustrative
# purposes the "base" image is used here.
FROM base AS final

# Required args for pulling dotties repo
ARG KNOWN_HOSTS
ARG SSH_PRIVATE_KEY
ARG SSH_PUBLIC_KEY

# TESTING - REMOVE
RUN echo "$KNOWN_HOSTS \n\n\n $SSH_PRIVATE_KEY \n\n\n\n $SSH_PUBLIC_KEY"

# Create a non-privileged user that the app will run under.
# See https://docs.docker.com/go/dockerfile-user-best-practices/
ARG UID=10001
ARG USER_NAME=testuser
RUN useradd -rm \
	-d "/home/${USER_NAME}" \
	-s /bin/bash \
	-g root \
	-G sudo \
	-u "${UID}" \
	"${USER_NAME}"
USER $USER_NAME 

WORKDIR /home/$USER_NAME

# Authorize SSH Host
RUN mkdir -p "/home/${USER_NAME}/.ssh" && \
    chmod 0700 "/home/${USER_NAME}/.ssh"

# Add the keys and set permissions
RUN echo "${SSH_PRIVATE_KEY}" | base64 -d > "/home/${USER_NAME}/.ssh/id_rsa" && \
    echo "${SSH_PUBLIC_KEY}" | base64 -d > "/home/${USER_NAME}/.ssh/id_rsa.pub" && \
    echo "${KNOWN_HOSTS}" | base64 -d > "/home/${USER_NAME}/.ssh/known_hosts" && \
    chmod 600 "/home/${USER_NAME}/.ssh/id_rsa" && \
    chmod 600 "/home/${USER_NAME}/.ssh/id_rsa.pub" && \
    chmod +w+r "/home/${USER_NAME}/.ssh/known_hosts"


# Copy the executable from the "build" stage.
COPY --from=build /bin/hello.sh /home/$USER_NAME

# Pull bare repo via install command
RUN curl -L https://raw.githubusercontent.com/NickLediet/lil-dotties/main/install.sh | bash

# What the container should run when it is started.
ENTRYPOINT [ "./hello.sh" ]
