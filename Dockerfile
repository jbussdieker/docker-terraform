FROM ubuntu

RUN apt-get -y update && \
  apt-get -y install curl unzip

ARG terraform_version

RUN : "${terraform_version:?Must specify version}"

RUN curl -OL https://releases.hashicorp.com/terraform/${terraform_version}/terraform_${terraform_version}_linux_amd64.zip && \
  unzip terraform_${terraform_version}_linux_amd64.zip && \
  mv terraform /usr/local/bin/terraform
