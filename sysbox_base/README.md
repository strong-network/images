To set up _minikube_ in our workspace infrastructure, you'll need to choose one of two potential solutions, both of which require sysbox as the container runtime.

_minikube_ supports these container runtimes https://minikube.sigs.k8s.io/docs/runtimes/.  
Running minikube __version 1.30.1 or below__, you run your cluster with the following command:
```bash
minikube start
``` 
This image provides _minikube_  v1.30.1.

If you're working with _minikube_ release __version 1.31.0 or higher__ https://github.com/kubernetes/minikube/releases, we need to set the container runtime for our cluster, by using the following command: 
```bash
minikube start --container-runtime=containerd
``` 
This configuration ensures that _minikube_ utilizes containerd as its container runtime. 
Please note that these versions do not support the default Docker runtime due to compatibility issues  between Sysbox and Docker versions 24.0.6 or higher, which _minikube_ uses and is not in the correlation with the host version of Docker.

For earlier versions of _minikube_ (<= 1.30.1), which provide Docker versions up to 20.30.23, we currently support both containerd and Docker as _minikube_ container runtimes.

|Version of minikube   |Docker as runtime   |Containerd as runtime   |CRI-O as runtime  |
|---|---|---|---|
| >= 1.31.0  | No  |Yes   |Needs inspection   |
| < 1.31.0  | Yes  |Yes   |Needs inspection   |