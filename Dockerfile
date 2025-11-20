# STAGE 1: Build
FROM golang:1.25-alpine AS build

# Install Node and NPM.
RUN apk update && apk upgrade && apk add --no-cache git nodejs bash npm

WORKDIR /go/src/github.com/kubernetes-up-and-running/kuard
# Copy all sources in
COPY . .


# Get dependencies for Go part of build
RUN go get


# This is a set of variables that the build script expects
ENV VERBOSE=0
ENV PKG=github.com/kubernetes-up-and-running/kuard
ENV ARCH=amd64
ENV VERSION=test

# When running on Windows 10, you need to clean up the ^Ms in the script
RUN dos2unix build/build.sh

# Do the build. Script is part of incoming sources.
RUN build/build.sh

# STAGE 2: Runtime
FROM alpine

USER nobody:nobody
COPY --from=build /go/bin/kuard /kuard

CMD [ "/kuard" ]
