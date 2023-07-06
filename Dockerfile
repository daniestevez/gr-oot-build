# syntax=docker/dockerfile:1
FROM ubuntu:latest

ARG VOLK_TAG=v3.0.0
ARG GNURADIO_TAG=v3.10.6.0

RUN apt-get update \
    && DEBIAN_FRONTEND="noninteractive" apt-get -y upgrade \
    && DEBIAN_FRONTEND="noninteractive" apt-get install -y \
           git cmake g++ libboost-all-dev libgmp-dev python3-numpy \
           python3-mako python3-sphinx python3-lxml doxygen libfftw3-dev \
           libsdl1.2-dev libgsl-dev libqwt-qt5-dev libqt5opengl5-dev python3-pyqt5 \
           liblog4cpp5-dev libzmq3-dev python3-yaml python3-click python3-click-plugins \
           python3-zmq python3-scipy python3-gi python3-gi-cairo gir1.2-gtk-3.0 \
           libcodec2-dev libgsm1-dev libusb-1.0-0 libusb-1.0-0-dev libudev-dev \
           pybind11-dev python3-matplotlib libsndfile1-dev \
           python3-pip libsoapysdr-dev soapysdr-tools \
           libiio-dev libad9361-dev libspdlog-dev python3-packaging python3-jsonschema \
    && pip3 install pygccxml pyqtgraph \
    && git clone --recursive https://github.com/gnuradio/volk.git \
    && cd volk \
    && git checkout ${VOLK_TAG} \
    && mkdir build \
    && cd build \
    && cmake .. \
    && make -j$(nproc) \
    && make install \
    && cd ../.. \
    && git clone https://github.com/gnuradio/gnuradio.git \
    && cd gnuradio \
    && git checkout ${GNURADIO_TAG} \
    && mkdir build \
    && cd build \
    && cmake .. \
    && make -j$(nproc) \
    && make install \
    && cd ../.. \
    && ldconfig \
    && rm -rf volk gnuradio
