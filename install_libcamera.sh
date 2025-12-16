#!/bin/bash

# color output
red=$'\e[31m'
grn=$'\e[32m'
normal=$'\e[0m'

THISUSER=`whoami`
if [ "$THISUSER" != "root" ]; then
    echo "This script requires root privilege"
    exit 1
fi

FRAMOS_DIR='/opt/framos'
CURRENT_DIR=$(dirname $(readlink -f $0))
SW_PACK_DIR=$CURRENT_DIR/..
RPICAM_VERSION='v1.10.0'

libcam_packages=(libboost-dev \
		libgnutls28-dev openssl libtiff5-dev pybind11-dev \
		qtbase5-dev libqt5core5a libqt5gui5 libqt5widgets5 \
		meson cmake \
		python3-yaml python3-ply \
		libglib2.0-dev libgstreamer-plugins-base1.0-dev)
		
rpicam_packages=(libepoxy-dev libjpeg-dev libtiff5-dev libpng-dev libopencv-dev \
		qtbase5-dev libqt5core5a libqt5gui5 libqt5widgets5 \
		libavcodec-dev libavdevice-dev libavformat-dev libswresample-dev \
		cmake libboost-program-options-dev libdrm-dev libexif-dev \
		meson ninja-build)

apt update

# Remove existing rpicam-apps package from Raspberry Pi
apt -y remove --purge rpicam-apps
apt -y install "${libcam_packages[@]}"
apt -y install "${rpicam_packages[@]}"

# Create framos directory
if [ ! -d $FRAMOS_DIR ]; then
	mkdir $FRAMOS_DIR
else
	rm -fr $FRAMOS_DIR/framos-libcamera
	rm -fr $FRAMOS_DIR/rpicam-apps
fi

# Clone rpicam-apps and copy to FRAMOS_DIR
pushd ${SW_PACK_DIR} &> /dev/null
git clone -b $RPICAM_VERSION https://github.com/raspberrypi/rpicam-apps.git
cp -r framos-libcamera $FRAMOS_DIR
cp -r rpicam-apps $FRAMOS_DIR

# Install custom framos libcamrea
pushd ${FRAMOS_DIR}/framos-libcamera &> /dev/null
meson setup build \
	--buildtype=release \
	-Dpipelines=rpi/vc4,rpi/pisp \
	-Dipas=rpi/vc4,rpi/pisp \
	-Dv4l2=true \
	-Dgstreamer=enabled \
	-Dtest=false \
	-Dlc-compliance=disabled \
	-Dcam=disabled \
	-Dqcam=disabled \
	-Ddocumentation=disabled \
	-Dpycamera=enabled

ninja -C build
ninja -C build install

# Install rpicam-apps
pushd ${FRAMOS_DIR}/rpicam-apps &> /dev/null
meson setup build \
	-Denable_libav=enabled \
	-Denable_drm=enabled \
	-Denable_egl=enabled \
	-Denable_qt=enabled \
	-Denable_opencv=disabled \
	-Denable_tflite=disabled \
	-Denable_hailo=disabled

meson compile -C build
meson install -C build

ldconfig

echo -e "${grn}"Installation finish!"${normal}"
