FROM alpine:latest

# https://mirrors.alpinelinux.org/
RUN sed -i 's@dl-cdn.alpinelinux.org@ftp.halifax.rwth-aachen.de@g' /etc/apk/repositories

RUN apk update
RUN apk upgrade

# required liboqs 
RUN apk add --no-cache \
  gcc make linux-headers musl-dev \
  zlib-dev zlib-static python3-dev \
  curl git libpng-dev libpng-static \
  libwebp-dev libwebp-static libjpeg-turbo-dev libjpeg-turbo-static \
  cmake ninja nasm g++ xz

ENV XZ_OPT=-e9
COPY build-static-tmux.sh build-static-mozjpeg.sh
RUN chmod +x ./build-static-mozjpeg.sh
RUN bash ./build-static-mozjpeg.sh
