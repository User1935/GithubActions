FROM mcr.microsoft.com/azure-cli
#alpine:3 

RUN ["/bin/sh", "-c", "apk add --update --no-cache bash ca-certificates curl git jq openssh sudo"]
#RUN apk add py3-pip
#RUN apk add gcc musl-dev python3-dev libffi-dev openssl-dev cargo make
#RUN pip install --upgrade pip
#RUN pip install azure-cli

#RUN echo ${INPUT_AZ_APPSECRET} INPUT_AZ_APPSECRET AZ_APPSECRET ${AZ_APPSECRET}
#RUN ["/bin/sh", "-c", "az login --service-principal --username ${INPUT_AZ_APPID} --password ${INPUT_AZ_APPSECRET} --tenant ${INPUT_AZ_APPTENANT}"]

#RUN 'NEWUSER="docker"; adduser -D "docker" docker; echo "docker ALL=(ALL) ALL" > /etc/sudoers.d/docker && chmod 0440 /etc/sudoers.d/docker;'
#RUN echo '%wheel ALL=(ALL) ALL' > /etc/sudoers.d/wheel
#RUN addgroup -S docker && adduser -S docker -G wheel

RUN --mount=type=secret,id=ARM_CLIENT_ID \
   --mount=type=secret,id=ARM_TENANT_ID \
   --mount=type=secret,id=ARM_CLIENT_SECRET \
   --mount=type=secret,id=ARM_SUBSCRIPTION_ID \
   --mount=type=secret,id=STORAGE_KEY \
   --mount=type=secret,id=TF_VAR_PATHSOPS \
   export ARM_CLIENT_ID=$(cat /run/secrets/ARM_CLIENT_ID) && \
   export ARM_TENANT_ID=$(cat /run/secrets/ARM_TENANT_ID) && \
   export ARM_CLIENT_SECRET=$(cat /run/secrets/ARM_CLIENT_SECRET) && \
   export ARM_SUBSCRIPTION_ID=$(cat /run/secrets/ARM_SUBSCRIPTION_ID) && \
   export STORAGE_KEY=$(cat /run/secrets/STORAGE_KEY)  && \
   export TF_VAR_PATHSOPS=$(cat /run/secrets/TF_VAR_PATHSOPS)

COPY ["src", "/src/"]
RUN ["chmod", "+x", "/src/main.sh"]
ENTRYPOINT ["/src/main.sh"]
