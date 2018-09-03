FROM ubuntu:16.04

RUN dpkg --add-architecture arm64 \
	&& apt-get update \
	&& DEBIAN_FRONTEND=noninteractive apt-get install -y \
	wget file \
	autoconf \
	make \
	less \
	autoconf \
	less \
	libtinyxml2-dev:arm64 \
	libopencv-dev:arm64 \
	libgstreamer1.0-dev:arm64 \
        libgstreamer-plugins-base1.0-dev:arm64 \
	&& apt-get clean \
  && rm -rf /var/lib/apt/lists/*
  
RUN wget https://developer.nvidia.com/embedded/dlc/l4t-gcc-toolchain-64-bit-28-2-ga -O gcc-toolchain.tar.gz \
    && cd /usr \
    && tar --strip-components 1 -zxvf /gcc-toolchain.tar.gz \
    && rm /gcc-toolchain.tar.gz

RUN echo "int main(){ int a=42;return a;}" > /tmp/a.c \
    && aarch64-unknown-linux-gnu-gcc /tmp/a.c -o /tmp/a \
    && file /tmp/a \
    && rm /tmp/a.c /tmp/a
