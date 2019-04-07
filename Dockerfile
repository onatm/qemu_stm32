FROM fedora:latest

RUN dnf install -y \
          arm-none-eabi-gcc\
          arm-none-eabi-newlib\
          findutils\
          gcc\
          git\
          glib2-devel\
          libfdt-devel\
          pixman-devel\
          pkgconf-pkg-config\
          python\
          zlib-devel

RUN git clone https://github.com/beckus/qemu_stm32.git

WORKDIR qemu_stm32

RUN ./configure --disable-werror --enable-debug \
    --target-list="arm-softmmu" \
    --extra-cflags=-DSTM32_UART_NO_BAUD_DELAY \
    --extra-cflags=-DSTM32_UART_ENABLE_OVERRUN \
    --disable-gtk

RUN  make && make install

WORKDIR /var/kernel
VOLUME ["/var/kernel"]
ENTRYPOINT ["qemu-system-arm", "-nographic"]

# FROM ubuntu:18.04

# RUN apt-get update \
#     && apt-get upgrade -y \
#     && apt-get install -y --no-install-recommends \
#     binutils-arm-none-eabi \
#     libnewlib-arm-none-eabi \
#     findutils \
#     gcc \
#     git \
#     libglib2.0-dev \
#     libfdt-dev \
#     libpixman-1-dev \
#     make \
#     pkgconf \
#     python \
#     unzip \
#     zlib1g-dev

# ADD https://github.com/beckus/qemu_stm32/archive/stm32_v0.1.3.zip qemu_stm32/

# WORKDIR qemu_stm32

# RUN unzip stm32_v0.1.3.zip

# WORKDIR qemu_stm32-stm32_v0.1.3

# RUN ./configure --disable-werror --enable-debug \
#     --target-list="arm-softmmu" \
#     --extra-cflags=-DSTM32_UART_NO_BAUD_DELAY \
#     --extra-cflags=-DSTM32_UART_ENABLE_OVERRUN \
#     --disable-gtk

# RUN  make && make install

# WORKDIR /var/kernel
# VOLUME ["/var/kernel"]
# ENTRYPOINT ["qemu-system-arm", "-nographic"]
