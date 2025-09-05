GIT_ROOT=$(shell git rev-parse --show-toplevel)
BASE_IMAGE_NAME=sn_base
SYSBOX_BASE_IMAGE_NAME=sn_sysbox_base
GOLANG_IMAGE_NAME=sn_golang
GOLANG_1.17_IMAGE_NAME=sn_golang_1.17
PYTHON_SPARK_IMAGE_NAME=sn_python_spark
PYTHON_DATASCIENCE_IMAGE_NAME=sn_python_datascience
PYTHON_ANACONDA_IMAGE_NAME=sn_python_anaconda
NODEJS_IMAGE_NAME=sn_nodejs
GENERIC_IMAGE_NAME=sn_generic
GENERIC_JFROG_IMAGE_NAME=sn_generic_jfrog
SYSBOX_GENERIC_IMAGE_NAME=sn_sysbox_generic
FLUTTER_IMAGE_NAME=sn_flutter
GUI_DEBIAN=sn_gui_debian
GUI_UBUNTU_BASE=sn_gui_ubuntu
GUI_UBUNTU_ECLIPSE=sn_gui_ubuntu_eclipse
GUI_DEBIAN_POSTMAN=sn_gui_debian_postman
MINIMAL_ALPINE=sn_minimal_alpine
MINIMAL_RHEL9=sn_minimal_rhel9

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

generic_image: base_image
	@docker build -t ${GENERIC_IMAGE_NAME}:${VERSION} generic
	@docker tag ${GENERIC_IMAGE_NAME}:${VERSION} ${GENERIC_IMAGE_NAME}

.PHONY: gui_debian
gui_debian:
	@docker build -t ${GUI_DEBIAN}:${VERSION} ${GIT_ROOT}/GUI/gui_debian

.PHONY: gui_debian_postman
gui_debian_postman:
	@docker build -t ${GUI_DEBIAN_POSTMAN}:${VERSION} ${GIT_ROOT}/GUI/gui_debian_postman

.PHONY: gui_ubuntu_base_image
gui_ubuntu_base_image:
	@echo ${VERSION}
	@docker build -t ${GUI_UBUNTU_BASE}:${VERSION} ${GIT_ROOT}/GUI/gui_ubuntu_base
	@docker tag ${GUI_UBUNTU_BASE}:${VERSION} ${GUI_UBUNTU_BASE}

.PHONY: gui_ubuntu_eclipse_image
gui_ubuntu_eclipse_image: gui_ubuntu_base_image
	@docker build -t ${GUI_UBUNTU_ECLIPSE}:${VERSION} ${GIT_ROOT}/GUI/gui_ubuntu_eclipse

.PHONY: generic_jfrog_image
generic_jfrog_image: generic_image
	@docker build -t ${GENERIC_JFROG_IMAGE_NAME}:${VERSION} generic_jfrog

.PHONY: sysbox_base_image
sysbox_base_image: base_image
	@docker build -t ${SYSBOX_BASE_IMAGE_NAME}:${VERSION} sysbox_base
	@docker tag ${SYSBOX_BASE_IMAGE_NAME}:${VERSION} ${SYSBOX_BASE_IMAGE_NAME}

.PHONY: generic_sysbox_image
generic_sysbox_image: sysbox_base_image
	@docker build --build-arg BASE_IMAGE=${SYSBOX_BASE_IMAGE_NAME} -t ${SYSBOX_GENERIC_IMAGE_NAME}:${VERSION} generic;

.PHONY: minimal_alpine_image
minimal_alpine_image: minimal_alpine_image
	@docker build -t ${MINIMAL_ALPINE}:${VERSION} ${GIT_ROOT}/minimal/alpine_320

.PHONY: minimal_rhel9_image
minimal_rhel9_image: minimal_rhel9_image
	@docker build -t ${MINIMAL_RHEL9}:${VERSION} ${GIT_ROOT}/minimal/rhel_9

.PHONY: all
all: base_image generic_image gui_debian gui_ubuntu_base_image gui_ubuntu_eclipse_image gui_debian_postman minimal_alpine_image minimal_rhel9_image

.PHONY: get_version
get_version:
	@echo ${VERSION}

.PHONY: get_base_image
get_base_image:
	@echo ${BASE_IMAGE_NAME}:${VERSION}

.PHONY: get_generic_image
get_generic_image:
	@echo ${GENERIC_IMAGE_NAME}:${VERSION}

.PHONY: get_gui_debian_image
get_gui_debian_image:
	@echo ${GUI_DEBIAN}:${VERSION}

.PHONY: get_gui_ubuntu_base_image
get_gui_ubuntu_base_image:
	@echo ${GUI_UBUNTU_BASE}:${VERSION}

.PHONY: get_gui_ubuntu_eclipse_image
get_gui_ubuntu_eclipse_image:
	@echo ${GUI_UBUNTU_ECLIPSE}:${VERSION}

.PHONY: get_generic_jfrog_image
get_generic_jfrog_image:
	@echo ${GENERIC_JFROG_IMAGE_NAME}:${VERSION}

.PHONY: get_sysbox_base_image
get_sysbox_base_image:
	@echo ${SYSBOX_BASE_IMAGE_NAME}:${VERSION}

.PHONY: get_sysbox_generic_image
get_sysbox_generic_image:
	@echo ${SYSBOX_GENERIC_IMAGE_NAME}:${VERSION}

.PHONY: get_minimal_alpine_image
get_minimal_alpine_image:
	@echo ${MINIMAL_ALPINE}:${VERSION}

.PHONY: get_minimal_rhel9_image
get_minimal_rhel9_image:
	@echo ${MINIMAL_RHEL9}:${VERSION}