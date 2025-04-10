# Unmanic Docker Container with Enhanced Capabilities

[![GitHub Repository](https://img.shields.io/badge/GitHub-Repository-blue?logo=github)](https://github.com/studyfranco/unmanic-docker)

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
    image: ghcr.io/studyfranco/unmanic-docker:latest
    ports:
      - 8888:8888
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Europe/Paris
    volumes:
      - /path/to/config:/config
      - /path/to/library:/library
      - /path/to/cache:/tmp/unmanic
    devices:
      - /dev/dri:/dev/dri # VAAPI hardware acceleration
    restart: unless-stopped
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