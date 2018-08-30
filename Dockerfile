FROM debian:stretch-slim
COPY assets/entrypoint.sh /
RUN apt-get update && \
    apt-get install  -y curl && \
    curl -o /tmp/helm.tar.gz https://storage.googleapis.com/kubernetes-helm/helm-v2.10.0-linux-amd64.tar.gz && \
    cd /tmp && \
    tar zxvf /tmp/helm.tar.gz && \
    rm /tmp/helm.tar.gz && \
    mv /tmp/helm*/helm /bin && \
    rm -rf /tmp/helm* && \
    mkdir /charts && \
    apt-get purge curl && \
    apt-get autoremove && \
    apt-get clean
ENTRYPOINT /entrypoint.sh
EXPOSE 8879
VOLUME /charts
