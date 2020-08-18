# Container image that runs your code
FROM archlinux:latest

ENV LANG=en_US.UTF-8

RUN pacman -Sy --noconfirm base-devel git && \
    rm -rf /var/cache/pacman/pkg/*

RUN useradd -m devel && echo "devel ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/01_devel

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh

# Code file to execute when the docker container starts up (`entrypoint.sh`).
ENTRYPOINT ["/entrypoint.sh"]
