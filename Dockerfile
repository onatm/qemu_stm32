FROM ubuntu:18.04 as build

WORKDIR /usr/src

RUN apt-get update \
  && apt-get upgrade -y \
  && apt-get install -y --no-install-recommends \
  binutils-arm-none-eabi \
  ca-certificates \
  libnewlib-arm-none-eabi \
  findutils \
  gcc \
  git \
  libglib2.0-dev \
  libfdt-dev \
  libpixman-1-dev \
  make \
  openssh-client \
  pkgconf \
  python \
  zlib1g-dev

RUN git clone https://github.com/beckus/qemu_stm32.git

WORKDIR qemu_stm32

RUN ./configure --disable-werror --enable-debug \
  --target-list="arm-softmmu" \
  --extra-cflags=-DSTM32_UART_NO_BAUD_DELAY \
  --extra-cflags=-DSTM32_UART_ENABLE_OVERRUN \
  --disable-gtk 

RUN make

FROM ubuntu:18.04
WORKDIR /usr/local/bin/qemu_stm32
COPY --from=build /usr/src/qemu_stm32/arm-softmmu .

RUN apt-get update \
  && apt-get upgrade -y \
  && apt-get install -y --no-install-recommends \
  libglib2.0-dev \
  libfdt-dev \
  libpixman-1-dev

WORKDIR /var/kernel
VOLUME ["/var/kernel"]
ENTRYPOINT ["/usr/local/bin/qemu_stm32/qemu-system-arm", "-nographic"]
