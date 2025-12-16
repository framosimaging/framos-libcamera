# FRAMOS libcamera for Raspberry Pi

Getting started with [Framos General Optics modules FSM:GO](https://www.framos.com/en/fsmgo?utm_source=google&utm_medium=cpc&utm_campaign=FSM-GO_Product_Launch_2024) and libcamera on Raspberry Pi.

This repository contains installation instructions for libcamera and rpicam-apps for FRAMOS General Optic modules FSM:GO

For more details about libcamera, refer to the official [libcamera website](https://libcamera.org/)

#
> [!TIP]
> Read the official [Raspberry Pi documentation](https://www.raspberrypi.com/documentation/) for a better understanding. Important chapters to highlight from the Raspberry Pi documentation include:
> - [Camera software](https://www.raspberrypi.com/documentation/computers/camera_software.html)
> - [Advanced rpicam-apps](https://www.raspberrypi.com/documentation/computers/camera_software.html#advanced-rpicam-apps)
#

## Supported Raspberry Pi models

- Raspberry Pi 5

## Supported Raspberry Pi OS versions and Framos libcamera branch compatibility

This list describes which "framos-libcamera branch" to use for the desired Raspberry Pi OS release.


Click "Download" to automatically start downloading Raspberry Pi OS Image.

|Raspberry Pi OS|Linux kernel|framos-libcamera branch|
|-|-|-|
|[Raspberry Pi OS (64-bit) 2025-11-24](https://downloads.raspberrypi.com/raspios_arm64/images/raspios_arm64-2025-11-24/) [[Download]](https://downloads.raspberrypi.com/raspios_arm64/images/raspios_arm64-2025-11-24/2025-11-24-raspios-trixie-arm64.img.xz)|6.12.47|framos_v0.5.2+rpt20250903|
|[Raspberry Pi OS (64-bit) 2024-11-19](https://downloads.raspberrypi.com/raspios_arm64/images/raspios_arm64-2024-11-19/) [[Download]](https://downloads.raspberrypi.com/raspios_arm64/images/raspios_arm64-2024-11-19/2024-11-19-raspios-bookworm-arm64.img.xz)|6.6.51|framos_v0.3.2+rpt20240927|

# Short procedure

## 1. Get & Install Framos libcamera

- [Compile Framos libcamera code on target system(Raspberry Pi)](https://github.com/framosimaging/framos-libcamera/wiki/FRAMOS-libcamera-%E2%80%90-Target-build)

## 2. Read more about features and options

- [Short libcamera and rpicam-apps guide](https://github.com/framosimaging/framos-libcamera/wiki/FRAMOS-libcamera-and-rpicam%E2%80%90apps-short-guide)
    -   Mode selection, exposure and gain settings, frame rate control, etc.

