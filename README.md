

# Strong Network container workspace images
## What is this repository
This repository is a collection of docker files and associated scripts that are used to build and deploy the default workspace images provided by Strong Network. Strong Network provides virtual coding environment that enable embedding Zero-trust policies in the code development process while not jeopardizing the developer experience.

##  Provided environments
The provided images provide a large set of varying environments that can fit the needs of most developers. This can include images for nodejs, python, golang or java development or full-stack like environment that perfectly serves both back-end and front-end development. 

## Code editors
Strong Network supports both terminal and VS Code based development for both provided and custom images that are compatible with the base image provided in this repository. JetBrains based editors is not supported out of box but images are provided that are compatible with multiple JetBrains based editors such as Intellij, pycharm, goland and Android studio.

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

