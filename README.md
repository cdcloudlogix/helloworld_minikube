# HelloMinikube

## What is HelloMinikube?
HelloMinikube implements a simple Python application running inside a container
and then deploy in Minikube, which is a local Kubernetes cluster.
This is running **exclusively** on MacOS (Linux supports coming soon!)

## News
* 2019-03-25 - v0.0.1 released! [[download](https://github.com/obutterbach/helloworld_minikube/releases/tag/v0.0.1)]

## Quick Start

### Check if all requirements are installed on your machine:

`./preinstall`

This would check and/or install the following requirements:
* Docker for Mac Desktop (require to have a login on Docker Hub)
* Hyperkit
* Minikube


### Build and deploy your app:

`./deploy`

This would implement the following:
* Build helloworld Docker image
* Create a deployment with 2 containers
* Create a service to load balance requests

### How to verify that's running

Start Minikube tunnel (require higher privileges, start in separate terminal):

`minikube tunnel`

This would then allow you to connect to the service, do the following to collect
your cluster information:

`kubectl get services hello-node`

Finally, you should have something as follow display (Cluster IP may differ):

```
20:58 $ kubectl get services hello-node
NAME         TYPE           CLUSTER-IP      EXTERNAL-IP     PORT(S)          AGE
hello-node   LoadBalancer   10.107.43.210   10.107.43.210   8080:31492/TCP   10h
```

To display *Hello World !* message, please curl CLUSTER-IP on port 8080, i.e.:

```
20:59 $ curl 10.107.43.210:8080
Hello World !
```

## Installation
You do have the following options, `preinstall` script or you can follow the official
documentation from Kubernetes website:
* Run `./preinstall.sh` that would guide you through the Minikube installation
* [**Installation**](https://kubernetes.io/docs/tasks/tools/install-minikube/).
Follow the official guideline for installing Minikube
