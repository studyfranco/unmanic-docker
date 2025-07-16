FROM ghcr.io/studyfranco/docker-baseimages-debian:testing

LABEL maintainer="studyfranco@gmail.com"

RUN set -x \
    && apt update \
    && apt dist-upgrade -y \
    && echo "deb https://deb.debian.org/debian/ bullseye main contrib non-free" >> /etc/apt/sources.list.d/bullseye.list \
    && apt autopurge -yy \
    && apt clean autoclean -y \
    && rm -rf /var/cache/* /var/lib/apt/lists/* /var/log/* /var/tmp/* /tmp/*

RUN set -x \
    && apt update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y ffmpegthumbs mkvtoolnix ffmpeg mediainfo handbrake-cli rsync zip hwinfo openssl sqlite3 jq nodejs libimage-exiftool-perl adduser --no-install-recommends --fix-missing \
    && apt autopurge -yy \
    && apt clean autoclean -y \
    && rm -rf /var/cache/* /var/lib/apt/lists/* /var/log/* /var/tmp/* /tmp/*

RUN set -x \
    && apt update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y va-driver-all mesa-utils mesa-va-drivers mesa-vulkan-drivers mesa-opencl-icd libgl1-mesa-dri libglx-mesa0 vulkan-tools vainfo intel-media-va-driver-non-free firmware-intel-graphics firmware-intel-misc intel-opencl-icd --no-install-recommends --fix-missing \
    && apt autopurge -yy \
    && apt clean autoclean -y \
    && rm -rf /var/cache/* /var/lib/apt/lists/* /var/log/* /var/tmp/* /tmp/*

RUN set -x \
    && apt update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y grc gcc python3 python3-dev python3-pip python3-setuptools python3-full python3-pymediainfo python3-sqlalchemy python3-sqlalchemy-ext python3-psycopg python3-numpy python3-scipy python3-matplotlib python3-onnxruntime python3-resampy libchromaprint-tools=1.5.0-2 --no-install-recommends --fix-missing \
    && apt autopurge -yy \
    && apt clean autoclean -y \
    && rm -rf /var/cache/* /var/lib/apt/lists/* /var/log/* /var/tmp/* /tmp/*

RUN python3 -m pip install --break-system-packages unmanic pymediainfo SQLAlchemy psycopg matplotlib onnxruntime resampy \
    && rm -rf /var/cache/* /var/log/* /var/tmp/* /tmp/* /root/.cache

RUN mkdir -p /config \
    && mkdir -p /library \
    && addgroup --system unmanic \
    && adduser --system --no-create-home --gecos "" --home /config --ingroup unmanic unmanic
    && rm -rf /var/cache/* /var/log/* /var/tmp/* /tmp/*

# Unmanic runs on port 8888
EXPOSE 8888/tcp

COPY --chmod=0755 run.sh /run.sh
COPY --chmod=0755 entrypoint.sh /entrypoint.sh
CMD ["/entrypoint.sh"]