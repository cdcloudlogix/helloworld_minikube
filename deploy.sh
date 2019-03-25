#!/usr/bin/env bash
# Deploy HelloMinikube.
#title          :deploy.sh
#description    :This script will install Minikube is installed on Mac / Linux
#author         :Oli
#date           :25/03/2019
#version        :0.1
#usage          :bash <(curl -s https://raw.githubusercontent.com/obutterbach/helloworld_minikube/blob/master/deploy.sh)
#bash_version   :3.2.57(1)-release
#===================================================================================

set -o errexit
set -o pipefail
set -o nounset

# Make sure to run docker with Minikube
eval $(minikube docker-env)

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

function build_container() {
  blue_color
  echo "Building Docker container..."
  green_color
  docker build -t hello-world-python Docker/
  reset_color
  separator
  sleep 1
}

function create_deployment() {
  blue_color
  echo "Create deployment..."
  green_color
  kubectl get deployments hello-node || kubectl run hello-node --replicas=2 --image=hello-world-python:latest --port=8080 --image-pull-policy=Never
  reset_color
  separator
  sleep 1
}

function create_service() {
  blue_color
  echo "Create deployment..."
  green_color
  kubectl get services hello-node || kubectl expose deployment hello-node --type=LoadBalancer --port=8080
  reset_color
  separator
  sleep 1
}

build_container
create_deployment
create_service
