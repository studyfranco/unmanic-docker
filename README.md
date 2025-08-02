# Unmanic Docker Container with Enhanced Capabilities

<div align="center">
  
![Github stars](https://badgen.net/github/stars/studyfranco/unmanic-docker?icon=github&label=stars)
![Github forks](https://badgen.net/github/forks/studyfranco/unmanic-docker?icon=github&label=forks)
![Github issues](https://img.shields.io/github/issues/studyfranco/unmanic-docker)
![Github last-commit](https://img.shields.io/github/last-commit/studyfranco/unmanic-docker)
  
</div>

## Overview

This repository provides a Docker container for [Unmanic - Library Optimiser](https://github.com/Unmanic/unmanic), built upon the [Debian Slim with Essential Tools](https://github.com/studyfranco/docker-baseimages-debian/tree/master) base image. This setup allows for the installation of additional Python modules and ensures an up-to-date version of FFmpeg, enhancing Unmanic's functionality.

## Features

- **Debian Slim Base**: Utilizes the lightweight Debian Slim variant from [studyfranco/docker-baseimages-debian](https://github.com/studyfranco/docker-baseimages-debian).
- **Pre-installed Editors**: Includes `nano` and `vi` by default, to facilitate in-container editing and debugging.
- **Enhanced Python Environment**: Designed to allow installing extra Python modules at runtime or via build steps.
- **Updated FFmpeg**: Includes a recent version of FFmpeg for improved codec support and performance.

## Usage

To run this container using Docker Compose with VAAPI hardware acceleration, use the following example:

```yaml
services:
  unmanic:
    container_name: unmanic
    hostname: unmanic
    image: ghcr.io/studyfranco/unmanic-docker:master
    ports:
      - 8888:8888
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Europe/Berlin
    volumes:
      - /etc/localtime:/etc/localtime:ro
      - /path/to/config:/config
      - /path/to/library:/library
    tmpfs:
      - "/run:exec,mode=777"
      - "/tmp:exec,mode=777"
      - "/tmp/dumps:exec,mode=777"
      - "/var/tmp:exec,mode=777"
      - "/tmp/unmanic:exec,mode=777"
    restart: "unless-stopped"
    devices:
      - /dev/dri:/dev/dri # VAAPI hardware acceleration
    group_add:
      - video
      - '44'
      - '100' # Render group
    cpu_shares: 180
```

**Notes:**
- Replace `/path/to/...` with your actual paths.
- Make sure your system supports [VAAPI hardware acceleration](https://docs.unmanic.app/docs/advanced/hardware_accelerated_encoding_vaapi/).

## Acknowledgements

Big thanks to:

- [Unmanic](https://github.com/Unmanic/unmanic) and its contributors for the amazing media optimization platform.
- [LinuxServer.io](https://github.com/linuxserver/docker-baseimage-debian) for the inspiration behind the base image structure.
- The [Debian](https://www.debian.org/) project for providing the rock-solid base system.

## License

This project is licensed under the **GNU Affero General Public License v3.0**.  
See the [LICENSE](LICENSE) file for more details.

## Last update

2025/08/01

