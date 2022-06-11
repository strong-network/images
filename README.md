![strong.network logo](assets/images/strong_logo.png)
Need help? Email support@strong.network

## What's in This Repository?
This repository is a collection of docker files and scripts that are used to build and deploy workspace images to use with the Virtual Workspace Infastructure (VWI) by Strong Network. The files fulfill several requirements that allow a project owner to import them as resources.

![Container images](assets/images/container_images.png)
##  Provided Environments
These container images cover typical environment needs to develop in languages such as nodejs, python, golang or java, both for back-end and front-end development. You can customize them to fullfil your personal needs. Note that these containers can be updated as well in the VWI by using startup scripts.

## IDE Compatibility
Images built with the provided docker files can be used with Visual Studio Code and the terminal (vim, emacs, etcl) without the need to embed the IDE as part of the image. For JetBrains IDEs, the IDE has to be embedded in the image. You can find image files here that embed Intellij and that can be used as examples to embed other IDEs from JetBrain.

## How to build the images
The base image for all of the provided images can be found in the base folder and can be built by running the command:
```bash
make base_image
```
Commands for all of the images can be found in the provided make file and includes commands such as:
```bash
make golang_image
make nodejs_image
make java_intellij
```

To build all of the provided images:
```bash
make all
```

