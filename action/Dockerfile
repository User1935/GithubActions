FROM alpine:3 

RUN ["/bin/sh", "-c", "apk add --update --no-cache bash ca-certificates curl git jq openssh sudo"]

#RUN 'NEWUSER="docker"; adduser -D "docker" docker; echo "docker ALL=(ALL) ALL" > /etc/sudoers.d/docker && chmod 0440 /etc/sudoers.d/docker;'
#RUN echo '%wheel ALL=(ALL) ALL' > /etc/sudoers.d/wheel
#RUN addgroup -S docker && adduser -S docker -G wheel


COPY ["src", "/src/"]
RUN ["chmod", "+x", "/src/main.sh"]
ENTRYPOINT ["/src/main.sh"]
