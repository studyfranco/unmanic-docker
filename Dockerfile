FROM ghcr.io/studyfranco/docker-baseimages-debian:testing

LABEL maintainer="studyfranco@gmail.com"

RUN set -x \
    && apt update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y ffmpegthumbs jq mkvtoolnix ffmpeg handbrake-cli va-driver-all mesa-utils mesa-va-drivers mesa-vulkan-drivers mesa-opencl-icd libgl1-mesa-dri libglx-mesa0 vulkan-tools rsync zip vainfo intel-media-va-driver-non-free firmware-intel-graphics firmware-intel-misc intel-opencl-icd hwinfo openssl sqlite3 jq nodejs libimage-exiftool-perl grc gcc python3 python3-dev python3-pip python3-setuptools python3-full adduser --no-install-recommends --fix-missing \
    && apt dist-upgrade -y \
    && apt autopurge -yy \
    && apt clean autoclean -y \
    && rm -rf /var/cache/* /var/lib/apt/lists/* /var/log/* /var/tmp/* /tmp/*

RUN python3 -m pip install --break-system-packages unmanic \
    && mkdir -p /config \
    && mkdir -p /library \
    && addgroup --system unmanic \
    && adduser --system --no-create-home --gecos "" --home /config --ingroup unmanic unmanic

# Unmanic runs on port 8888
EXPOSE 8888/tcp

COPY --chmod=0755 run.sh /run.sh
COPY --chmod=0755 entrypoint.sh /entrypoint.sh
CMD ["/entrypoint.sh"]