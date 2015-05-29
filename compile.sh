#!/bin/bash

## Save Current Dir

old_dir=$(pwd)

## Find Pi Type

set -- $(cat /proc/cmdline) && for x in "$@"; do case "$x" in osmcdev=*) mypi=${x#osmcdev=}; ;; esac; done

## Update Repositories

sudo apt-get update

## Install Needed Tools

sudo apt-get install build-essential
sudo apt-get install git

## Install OSMC Headers

sudo apt-get install -y "${mypi}-headers-$(uname -r)"

## Install Linux Source

sudo apt-get install -y "${mypi}-source-$(uname -r)"

if [ ! -d "/usr/src/${mypi}-source-$(uname -r)" ]; then

    cd /usr/src
    sudo tar -jxvf ${mypi}-source-$(uname -r).tar.bz2

## Setup Build Enviroment

    sudo cp ./${mypi}-headers-$(uname -r)/Module.symvers ./${mypi}-source-$(uname -r)/Module.symvers
    sudo rm /lib/modules/$(uname -r)/build
    sudo ln -s ./${mypi}-source-$(uname -r) /lib/modules/$(uname -r)/build
    cd /lib/modules/$(uname -r)/build
    sudo make oldconfig
    sudo make modules_prepare

fi

## Download & Compile Driver

cd ${old_dir}
git clone https://github.com/porjo/mt7601
cd ./mt7601/src
sudo make
cd ./../..
mkdir ./kernel/
mkdir ./kernel/${mypi}-$(uname -r)
cp ./mt7601/src/os/linux/mt7601Usta.ko ./kernel/${mypi}-$(uname -r)/
