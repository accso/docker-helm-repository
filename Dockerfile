FROM debian:stretch-slim
COPY assets/entrypoint.sh /
RUN apt-get update && \
    apt-get install  -y curl && \
    curl -o /tmp/helm.tar.gz https://storage.googleapis.com/kubernetes-helm/helm-v2.10.0-linux-amd64.tar.gz && \
    cd /tmp && \
    tar zxvf /tmp/helm.tar.gz && \
    rm /tmp/helm.tar.gz && \
    mv /tmp/linux-amd64/helm /bin && \
    rm -rf /tmp/linux-amd64 && \
    mkdir /charts && \
    apt-get purge -y curl && \
    apt-get autoremove -y && \
    apt-get clean
ENTRYPOINT [ "/entrypoint.sh" ]
EXPOSE 8879
VOLUME /charts
