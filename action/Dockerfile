FROM alpine:3 

RUN ["/bin/sh", "-c", "apk add --update --no-cache bash ca-certificates curl git jq openssh", "apt-get -y install sudo"]

RUN useradd -m docker && echo "docker:docker" | chpasswd && adduser docker sudo
USER docker

COPY ["src", "/src/"]

ENTRYPOINT ["/src/main.sh"]
