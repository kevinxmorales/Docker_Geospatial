FROM ubuntu:20.04
FROM python:3.8

RUN mkdir /app
WORKDIR /app

RUN apt-get update && \
    apt-get clean && \
    apt-get -y install openssl && \
    apt-get install -y libgdal-dev g++ --no-install-recommends && \
    apt-get clean -y && \
    apt-get -y install python3-pip && \
    apt install -y libsuitesparse-dev && \
    apt-get install -y python3-psutil && \
    apt-get update

ENV PATH="/root/miniconda3/bin:${PATH}"
ARG PATH="/root/miniconda3/bin:${PATH}"
RUN apt-get update

RUN apt-get install -y wget && rm -rf /var/lib/apt/lists/*

RUN wget \
    https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && mkdir /root/.conda \
    && bash Miniconda3-latest-Linux-x86_64.sh -b \
    && rm -f Miniconda3-latest-Linux-x86_64.sh 
RUN conda --version

RUN conda install -c conda-forge mintpy

ADD main.py /app/

RUN python3 main.py


