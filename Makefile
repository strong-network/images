GIT_ROOT=$(shell git rev-parse --show-toplevel)
BASE_IMAGE_NAME=sn_base
BASE_JEBRAINS_IMAGE_NAME=sn_base_jetbrains
GOLANG_IMAGE_NAME=sn_golang
PYTHON_SPARK_IMAGE_NAME=sn_python_spark
PYTHON_DATASCIENCE_IMAGE_NAME=sn_python_datascience
PYTHON_ANACONDA_IMAGE_NAME=sn_python_anaconda
NODEJS_IMAGE_NAME=sn_nodejs
GENERIC_IMAGE_NAME=sn_generic
FLUTTER_IMAGE_NAME=sn_flutter
JAVA_INTELLIJ_IMAGE_NAME=sn_java_intellij
GOLAND_IMAGE_NAME=sn_goland
PYCHARM_IMAGE_NAME=sn_pycharm
PHPSTORM_IMAGE_NAME=sn_phpstorm
ANDROID_STUDIO_IMAGE_NAME=sn_android_studio
VERSION = $(shell awk NF ${GIT_ROOT}/VERSION)

.PHONY: base_image
base_image:
	@echo ${VERSION}
	@docker build -t ${BASE_IMAGE_NAME}:${VERSION} ${GIT_ROOT}/base
	@docker tag ${BASE_IMAGE_NAME}:${VERSION} ${BASE_IMAGE_NAME}

.PHONY: base_jetbrains_image
base_jetbrains_image: base_image
	@docker build -t ${BASE_JEBRAINS_IMAGE_NAME}:${VERSION} base_jetbrains
	@docker tag ${BASE_JEBRAINS_IMAGE_NAME}:${VERSION} ${BASE_JEBRAINS_IMAGE_NAME}

.PHONY: base_image_rm
remove_base_image:
	@docker image rm ${BASE_IMAGE_NAME}:${VERSION}
	@docker image rm ${BASE_IMAGE_NAME}:latest

.PHONY: golang_image
golang_image: base_image
	@docker build -t ${GOLANG_IMAGE_NAME}:${VERSION} golang

python_spark_image: base_image
	@docker build -t ${PYTHON_SPARK_IMAGE_NAME}:${VERSION} python_spark

python_datascience_image: base_image
	@docker build -t ${PYTHON_DATASCIENCE_IMAGE_NAME}:${VERSION} python_datascience

python_anaconda_image: base_image
	@docker build -t ${PYTHON_ANACONDA_IMAGE_NAME}:${VERSION} python_anaconda

nodejs_image: base_image
	@docker build -t ${NODEJS_IMAGE_NAME}:${VERSION} nodejs

generic_image: base_image
	@docker build -t ${GENERIC_IMAGE_NAME}:${VERSION} generic

flutter_image: base_image
	@docker build -t ${FLUTTER_IMAGE_NAME}:${VERSION} flutter

.PHONY: java_intellij
java_intellij: base_jetbrains_image
	@docker build -t ${JAVA_INTELLIJ_IMAGE_NAME}:${VERSION} java_intellij

.PHONY: goland
goland: base_jetbrains_image
	@docker build -t ${GOLAND_IMAGE_NAME}:${VERSION} goland

.PHONY: pycharm
pycharm: base_jetbrains_image
	@docker build -t ${PYCHARM_IMAGE_NAME}:${VERSION} pycharm

.PHONY: phpstorm
phpstorm:
	@docker build -t  ${PHPSTORM_IMAGE_NAME}:${VERSION} phpstorm

.PHONY: android_studio 
android_studio:
	@docker build -t ${ANDROID_STUDIO_IMAGE_NAME}:${VERSION} android_studio

.PHONY: get_version
get_version:
	@echo ${VERSION}

.PHONY: get_base_image
get_base_image:
	@echo ${BASE_IMAGE_NAME}:${VERSION}

.PHONY: get_base_jetbrains_image
get_base_jetbrains_image:
	@echo ${BASE_JEBRAINS_IMAGE_NAME}:${VERSION}

.PHONY: get_golang_image
get_golang_image:
	@echo ${GOLANG_IMAGE_NAME}:${VERSION}

.PHONY: get_spark_image
get_spark_image:
	@echo ${PYTHON_SPARK_IMAGE_NAME}:${VERSION}

.PHONY: get_python_datascience_image
get_python_datascience_image:
	@echo ${PYTHON_DATASCIENCE_IMAGE_NAME}:${VERSION}

.PHONY: get_python_anaconda_image
get_python_anaconda_image:
	@echo ${PYTHON_ANACONDA_IMAGE_NAME}:${VERSION}

.PHONY: get_nodejs_image
get_nodejs_image:
	@echo ${NODEJS_IMAGE_NAME}:${VERSION}

.PHONY: get_flutter_image
get_flutter_image:
	@echo ${FLUTTER_IMAGE_NAME}:${VERSION}

.PHONY: get_generic_image
get_generic_image:
	@echo ${GENERIC_IMAGE_NAME}:${VERSION}

.PHONY: get_java_intellij
get_java_intellij:
	@echo ${JAVA_INTELLIJ_IMAGE_NAME}:${VERSION}

.PHONY: get_goland
get_goland:
	@echo ${GOLAND_IMAGE_NAME}:${VERSION}

.PHONY: get_pycharm
get_pycharm:
	@echo ${PYCHARM_IMAGE_NAME}:${VERSION}

.PHONY: get_phpstorm
get_phpstorm:
	@echo ${PHPSTORM_IMAGE_NAME}:${VERSION}

.PHONY: get_android_studio
get_android_studio:
	@echo ${ANDROID_STUDIO_IMAGE_NAME}:${VERSION}