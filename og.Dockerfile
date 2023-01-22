FROM ubuntu:22.04
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

RUN wget http://faculty.cse.tamu.edu/davis/SuiteSparse/SuiteSparse-4.5.3.tar.gz
RUN tar -xf SuiteSparse-4.5.3.tar.gz

ARG SP_DIR=/app/SuiteSparse

# Update C env vars so compiler can find gdal
ENV CPLUS_INCLUDE_PATH=/usr/include/gdal
ENV C_INCLUDE_PATH=/usr/include/gdal
ENV CVXOPT_SUITESPARSE_SRC_DIR=${SP_DIR}
ENV CPPFLAGS=${SP_DIR}
ENV SUITE_SPARSE_DIR=${SP_DIR}}
ENV CVXOPT_SUITESPARSE_SRC_DIR=${SP_DIR}
ENV CVXOPT_SUITESPARSE_LIB_DIR=${SP_DIR}
ENV CVXOPT_SUITESPARSE_INC_DIR=${SP_DIR}
ENV CVXOPT_GSL_LIB_DIR=${SP_DIR}
ENV CVXOPT_GSL_INC_DIR=${SP_DIR}
ENV CVXOPT_FFTW_LIB_DIR=${SP_DIR}
ENV CVXOPT_FFTW_INC_DIR=${SP_DIR}
ENV CVXOPT_GLPK_LIB_DIR=${SP_DIR}
ENV CVXOPT_GLPK_INC_DIR=${SP_DIR}
ENV SUITE_SPARSE_LIB_DIR=${SP_DIR}/lib

RUN python3 -m pip install --upgrade pip setuptools>42 wheel
RUN pip install psutil numpy scikit-image matplotlib
COPY requirements.txt requirements.txt
RUN python3 -m pip install --no-cache-dir --compile -r requirements.txt

ADD main.py /app

RUN python3 main.py