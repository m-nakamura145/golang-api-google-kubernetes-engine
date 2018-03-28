FROM golang:1.10-stretch
WORKDIR /go/src/github.com/m-nakamura145/golang-api-google-kubernetes-engine
ADD . /go/src/github.com/m-nakamura145/golang-api-google-kubernetes-engine

RUN apt-get update && \
  apt-get install -y apt-transport-https dirmngr ca-certificates curl lsb-release

# google cloud sdk, kubectl
RUN echo "deb https://packages.cloud.google.com/apt cloud-sdk-$(lsb_release -c -s) main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
RUN curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    google-cloud-sdk \
    kubectl

# docker
RUN curl -L -o /tmp/docker.tgz https://get.docker.com/builds/Linux/x86_64/docker-17.05.0-ce.tgz && \
    tar -xz -C /tmp -f /tmp/docker.tgz && \
    mv /tmp/docker/* /usr/bin && \
    rm -rf /tmp/docker /tmp/docker.tgz

RUN apt-get clean && \
  rm -rf /var/lib/apt/lists/*
