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
FROM phusion/baseimage:0.11
LABEL maintainer "support@polkasource.com"
LABEL description="Small image with the binaries."
ARG PROFILE=release
COPY --from=builder /cbuilder/wabt/bin /usr/local/bin
COPY --from=builder /cbuilder/wabt /usr/local/wabt

# REMOVE & CLEANUP
RUN mv /usr/share/ca* /tmp && \
	rm -rf /usr/share/*  && \
	mv /tmp/ca-certificates /usr/share/ && \
	rm -rf /usr/lib/python*
RUN	rm -rf /usr/bin /usr/sbin

# FINAL PREPARATIONS
#EXPOSE 30333 9933 9944
#VOLUME ["/data"]
#CMD ["/usr/local/bin/cennznet"]
WORKDIR /usr/local/bin
#ENTRYPOINT [""]
#CMD [""]
# ===== END SECOND STAGE ======