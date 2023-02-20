GIT_ROOT=$(shell git rev-parse --show-toplevel)
BASE_IMAGE_NAME=sn_base
GOLANG_IMAGE_NAME=sn_golang
GOLANG_1.17_IMAGE_NAME=sn_golang_1.17
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
INTELLIJ_ULTIMATE_IMAGE_NAME=sn_intellij_ultimate
WEBSTORM_IMAGE_NAME=sn_webstorm
VERSION = $(shell awk NF ${GIT_ROOT}/VERSION)

.PHONY: base_image
base_image:
	@echo ${VERSION}
	@docker build -t ${BASE_IMAGE_NAME}:${VERSION} ${GIT_ROOT}/base
	@docker tag ${BASE_IMAGE_NAME}:${VERSION} ${BASE_IMAGE_NAME}

.PHONY: base_image_rm
remove_base_image:
	@docker image rm ${BASE_IMAGE_NAME}:${VERSION}
	@docker image rm ${BASE_IMAGE_NAME}:latest

.PHONY: golang_image
golang_image: base_image
	@docker build -t ${GOLANG_IMAGE_NAME}:${VERSION} golang

generic_image: base_image
	@docker build -t ${GENERIC_IMAGE_NAME}:${VERSION} generic

.PHONY: java_intellij
java_intellij: base_image
	@docker build -t ${JAVA_INTELLIJ_IMAGE_NAME}:${VERSION} java_intellij

.PHONY: goland
goland: base_image
	@docker build -t ${GOLAND_IMAGE_NAME}:${VERSION} goland

.PHONY: pycharm
pycharm: base_image
	@docker build -t ${PYCHARM_IMAGE_NAME}:${VERSION} pycharm

.PHONY: phpstorm
phpstorm: base_image
	@docker build -t  ${PHPSTORM_IMAGE_NAME}:${VERSION} phpstorm

.PHONY: android_studio 
android_studio: base_image
	@docker build -t ${ANDROID_STUDIO_IMAGE_NAME}:${VERSION} android_studio

.PHONY: intellij_ultimate
intellij_ultimate: base_image
	@docker build -t ${INTELLIJ_ULTIMATE_IMAGE_NAME}:${VERSION} intellij_ultimate

.PHONY: webstorm_image
webstorm_image: base_image
	@docker build -t ${WEBSTORM_IMAGE_NAME}:${VERSION} webstorm

.PHONY: all
all: base_image generic_image java_intellij intellij_ultimate goland pycharm phpstorm android_studio webstorm_image

.PHONY: get_version
get_version:
	@echo ${VERSION}

.PHONY: get_base_image
get_base_image:
	@echo ${BASE_IMAGE_NAME}:${VERSION}

.PHONY: get_generic_image
get_generic_image:
	@echo ${GENERIC_IMAGE_NAME}:${VERSION}

.PHONY: get_java_intellij_image
get_java_intellij_image:
	@echo ${JAVA_INTELLIJ_IMAGE_NAME}:${VERSION}

.PHONY: get_goland_image
get_goland_image:
	@echo ${GOLAND_IMAGE_NAME}:${VERSION}

.PHONY: get_pycharm_image
get_pycharm_image:
	@echo ${PYCHARM_IMAGE_NAME}:${VERSION}

.PHONY: get_phpstorm_image
get_phpstorm_image:
	@echo ${PHPSTORM_IMAGE_NAME}:${VERSION}

.PHONY: get_android_studio_image
get_android_studio_image:
	@echo ${ANDROID_STUDIO_IMAGE_NAME}:${VERSION} 

.PHONY: get_intellij_ultimate_image
get_intellij_ultimate_image:
	@echo ${INTELLIJ_ULTIMATE_IMAGE_NAME}:${VERSION}

.PHONY: get_webstorm_image
get_webstorm_image:
	@echo ${WEBSTORM_IMAGE_NAME}:${VERSION}
