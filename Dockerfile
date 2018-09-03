FROM ubuntu:16.04

RUN apt-get update \
	&& DEBIAN_FRONTEND=noninteractive apt-get install -y \
	wget file \
	autoconf \
	make \
	less \
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
