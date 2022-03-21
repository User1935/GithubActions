FROM ghcr.io/antonbabenko/pre-commit-terraform:latest
#alpine:3 

#RUN apt update && \
#    apt install -y unzip software-properties-common python3 python3-pip && \
#    python3 -m pip install --upgrade pip && \
#    pip3 install --no-cache-dir pre-commit && \
#    pip3 install --no-cache-dir checkov && \
#    apt install curl && \
#    curl -L "$(curl -s https://api.github.com/repos/terraform-docs/terraform-docs/releases/latest | grep -o -E -m 1 "https://.+?-linux-amd64.tar.gz")" > terraform-docs.tgz && tar -xzf terraform-docs.tgz terraform-docs && rm terraform-docs.tgz && chmod +x terraform-docs && mv terraform-docs /usr/bin/ && \
#    curl -L "$(curl -s https://api.github.com/repos/accurics/terrascan/releases/latest | grep -o -E -m 1 "https://.+?_Linux_x86_64.tar.gz")" > terrascan.tar.gz && tar -xzf terrascan.tar.gz terrascan && rm terrascan.tar.gz && mv terrascan /usr/bin/ && terrascan init && \
#    curl -L "$(curl -s https://api.github.com/repos/terraform-linters/tflint/releases/latest | grep -o -E -m 1 "https://.+?_linux_amd64.zip")" > tflint.zip && unzip tflint.zip && rm tflint.zip && mv tflint /usr/bin/ && \
#    curl -L "$(curl -s https://api.github.com/repos/aquasecurity/tfsec/releases/latest | grep -o -E -m 1 "https://.+?tfsec-linux-amd64")" > tfsec && chmod +x tfsec && mv tfsec /usr/bin/ && \
#    apt install -y jq && \
#    curl -L "$(curl -s https://api.github.com/repos/infracost/infracost/releases/latest | grep -o -E -m 1 "https://.+?-linux-amd64.tar.gz")" > infracost.tgz && tar -xzf infracost.tgz && rm infracost.tgz && mv infracost-linux-amd64 /usr/bin/infracost && infracost register && \
#RUN export INFRACOST_API_KEY=$INPUT_INFRACOST_API_KEY

COPY ["src", "/src/"]
RUN ["chmod", "+x", "/src/main.sh"]
#RUN apk update && apk add pacman && pacman -S python-ansi2html

# Checkov happy
HEALTHCHECK NONE

# Reduce Privileges
#RUN groupadd -r user && useradd --no-log-init -r -g user user
#USER user
USER root
ENTRYPOINT ["/src/main.sh"]
