#!/usr/bin/env bash
# Preinstall HelloMinikube.
#title          :preinstall.sh
#description    :This script will install Minikube is installed on Mac / Linux
#author         :Oli
#date           :24/03/2019
#version        :0.1
#usage          :bash <(curl -s https://raw.githubusercontent.com/obutterbach/helloworld_minikube/blob/master/preinstall.sh)
#bash_version   :3.2.57(1)-release
#===================================================================================

set -o errexit
set -o pipefail
set -o nounset

RESET_COLOR="\033[0m"
RED_COLOR="\033[0;31m"
GREEN_COLOR="\033[0;32m"
BLUE_COLOR="\033[0;34m"

function reset_color() {
  echo -e "${RESET_COLOR}\c"
}

function red_color() {
  echo -e "${RED_COLOR}\c"
}

function green_color() {
  echo -e "${GREEN_COLOR}\c"
}

function blue_color() {
  echo -e "${BLUE_COLOR}\c"
}

function separator() {
  green_color
  echo "#=============================STEP FINISHED=============================#"
  reset_color
}

function hello() {
  blue_color
  echo "This script will guide you through installing all required dependencies"
  echo "for installing Minikube"
  echo "This script requires elevated privileges"
  green_color
  read -p "Do you want to proceed with installation? (y/N) " -n 1 answer
  echo
  if [ ${answer} != "y" ]; then
      exit 1
  fi
}

function install_docker() {
  blue_color
  echo "Trying to detect installed Docker..."
  if ! [ $(command -v docker 2>&1) ]; then
    blue_color
    echo "You don't have Docker installed"
    echo "This is required to proceed with installation"
    echo "Please follow the instruction at the following location"
    echo "https://docs.docker.com/docker-for-mac/install/"
  else
    blue_color
    echo "Seems like you have installed Docker, so skipping..."
  fi
  reset_color
  separator
  sleep 1
}

function install_hyperkit_driver() {
  blue_color
  echo "Trying to detect installed Hyperkit driver..."
  if ! [ $(command -v hyperkit 2>&1) ]; then
    blue_color
    echo "You don't have Hyperkit driver installed"
    echo "This is required to proceed with installation"
    green_color
    read -p "Do you agree to install Hyperkit driver? (y/N) " -n 1 answer
    echo
    if [ ${answer} != "y" ]; then
        exit 1
    fi
    blue_color
    echo "Installing Hyperkit driver..."
    echo "Please, wait until Hyperkit driver will be installed, before continue"
    curl -LO https://storage.googleapis.com/minikube/releases/latest/docker-machine-driver-hyperkit \
    && sudo install -o root -g wheel -m 4755 docker-machine-driver-hyperkit /usr/local/bin/hyperkit \
    && rm docker-machine-driver-hyperkit
  else
    blue_color
    echo "Seems like you have installed Hyperkit driver, so skipping..."
  fi
  reset_color
  separator
  sleep 1
}

function install_minikube() {
  blue_color
  echo "Trying to detect installed Minikube..."
  if ! [ $(command -v minikube 2>&1) ]; then
    blue_color
    echo "You don't have Minikube installed"
    echo "This is required to proceed with installation"
    green_color
    read -p "Do you agree to install Minikube? (y/N) " -n 1 answer
    echo
    if [ ${answer} != "y" ]; then
        exit 1
    fi
    blue_color
    echo "Installing Minikube..."
    echo "Please, wait until Minikube will be installed, before continue"
    curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-darwin-amd64 \
    && sudo install minikube-darwin-amd64 /usr/local/bin/minikube \
    && rm minikube-darwin-amd64
  else
    blue_color
    echo "Seems like you have installed Minikube, so skipping..."
  fi
  reset_color
  separator
  sleep 1
}

function start_minikube() {
  blue_color
  echo "Make sure Minikube is running..."
  minikube start --vm-driver hyperkit
  reset_color
  separator
  sleep 1
}

hello
install_docker
install_hyperkit_driver
install_minikube
start_minikube
