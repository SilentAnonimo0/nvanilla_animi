FROM		nvcr.io/nvidia/k8s/container-toolkit:v1.17.9-ubuntu20.04
LABEL 		org.opencontainers.image.source=https://github.com/SilentAnonimo0/nvanilla_animi/blob/main/images/Dockerfile

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        python3 python3-pip python3-dev python3-venv \
        git build-essential cmake && \
    rm -rf /var/lib/apt/lists/*

ENV         USER=container
ENV         HOME=/home/container
WORKDIR     /home/container

STOPSIGNAL	SIGINT

COPY        --chown=root:root --chmod=755 ./../entrypoint.sh /entrypoint.sh
ENTRYPOINT	["/usr/bin/ti@ni", "-g", "--"]
CMD         ["/entrypoint.sh"]
