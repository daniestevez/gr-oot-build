# syntax=docker/dockerfile:1
FROM ubuntu:latest
RUN apt-get update \
    && DEBIAN_FRONTEND="noninteractive" apt-get -y upgrade \
    && DEBIAN_FRONTEND="noninteractive" apt-get install -y \
           gnuradio build-essential cmake git liborc-0.4-dev \
	   libspdlog-dev 
