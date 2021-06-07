ARG ROOT_CONTAINER=ubuntu:focal-20210416@sha256:86ac87f73641c920fb42cc9612d4fb57b5626b56ea2a19b894d0673fd5b4f2e9

FROM $ROOT_CONTAINER

USER root
ENV JUPYTER_TOKEN=
ENV JUPYTER_PASS=
ENV JUPYTER_IP=0.0.0.0
ENV JUPYTER_PORT=8888
ENV JUPYTER_ENABLE_LAB=yes


ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update --yes && \
    apt-get install --yes --no-install-recommends \
    tini \
    wget \
    ca-certificates \
    sudo \
    locales \
    fonts-liberation \
    run-one && \
    apt-get clean && rm -rf /var/lib/apt/lists/* && \
    echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen

RUN apt-get update -y && apt install -y python3 python3-pip python3-dev
RUN pip3 install --upgrade pip && pip install jupyter jupyterlab

WORKDIR /work

CMD jupyter notebook \
    --ip=${JUPYTER_IP} \
    --port=${JUPYTER_PORT} \
    --NotebookApp.token=${JUPYTER_TOKEN} \
    --NotebookApp.password=${JUPYTER_PASS} \
    --allow-root --no-browser

