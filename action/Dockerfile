FROM mcr.microsoft.com/azure-cli
#alpine:3 

RUN ["/bin/sh", "-c", "apk add --update --no-cache bash ca-certificates curl git jq openssh sudo"]
RUN apk add tree
#RUN apk add py3-pip
#RUN apk add gcc musl-dev python3-dev libffi-dev openssl-dev cargo make
#RUN pip install --upgrade pip
#RUN pip install azure-cli

#RUN echo ${INPUT_AZ_APPSECRET} INPUT_AZ_APPSECRET AZ_APPSECRET ${AZ_APPSECRET}
#RUN ["/bin/sh", "-c", "az login --service-principal --username ${INPUT_AZ_APPID} --password ${INPUT_AZ_APPSECRET} --tenant ${INPUT_AZ_APPTENANT}"]

#RUN 'NEWUSER="docker"; adduser -D "docker" docker; echo "docker ALL=(ALL) ALL" > /etc/sudoers.d/docker && chmod 0440 /etc/sudoers.d/docker;'
#RUN echo '%wheel ALL=(ALL) ALL' > /etc/sudoers.d/wheel
#RUN addgroup -S docker && adduser -S docker -G wheel


COPY ["src", "/src/"]
RUN ["chmod", "+x", "/src/main.sh"]
ENTRYPOINT ["/src/main.sh"]
