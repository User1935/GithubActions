FROM alpine:3 

RUN ["/bin/sh", "-c", "apk add --update --no-cache bash ca-certificates curl git jq openssh", "apk add sudo"]

RUN NEWUSER='docker'
RUN adduser -d "${NEWUSER}" $NEWUSER
RUN echo "$NEWUSER ALL=(ALL) ALL" > /etc/sudoers.d/$NEWUSER && chmod 0440 /etc/sudoers.d/$NEWUSER

USER docker

COPY ["src", "/src/"]

ENTRYPOINT ["/src/main.sh"]
