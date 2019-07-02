# ===== START FIRST STAGE ======
FROM phusion/baseimage:0.11 as builder
LABEL maintainer "support@polkasource.com"
LABEL description="Large image for building the binaries."

ARG PROFILE=release
WORKDIR /cbuilder
COPY . /cbuilder

# PREPARE OPERATING SYSTEM & BUILDING ENVIRONMENT
RUN apt-get update && \
	apt-get upgrade -y && \
	apt-get install -y cmake pkg-config libssl-dev git clang libclang-dev 
	
# CHECKOUT GIT SUBMODULES
RUN git submodule update --init --recursive
	
# BUILD BINARY
RUN cd /cbuilder/wabt && mkdir build
RUN cd /cbuilder/wabt/build && cmake ..
RUN cd /cbuilder/wabt/build && cmake --build .
# ===== END FIRST STAGE ======

# ===== START SECOND STAGE ======
# ===== END SECOND STAGE ======