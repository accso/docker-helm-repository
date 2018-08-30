FROM debian:stretch-slim
COPY assets/entrypoint.sh /
RUN apt-get update && \
    apt-get install  -y curl && \
    curl -o /tmp/helm.tar.gz https://storage.googleapis.com/kubernetes-helm/helm-v2.10.0-linux-amd64.tar.gz && \
    cd /run && \
    tar zxvf /tmp/helm.tar.gz && \
    cp /tmp/helm*/helm /bin && \
    mkdir /charts && \
    apt-get remove curl && \
    apt-get clean
ENTRYPOINT /entrypoint.sh
EXPOSE 8879
VOLUME /charts
