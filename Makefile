GIT_ROOT=$(shell git rev-parse --show-toplevel)
BASE_IMAGE_NAME=strong_network_base
VERSION = $(shell awk NF ${GIT_ROOT}/VERSION)
GOLANG_IMAGE = strong_network_golang

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
	@docker build -t strong_network_golang:${VERSION} golang

python_spark_image: base_image
	@docker build -t strong_network_python_spark:${VERSION} python_spark

python_datascience_image: base_image
	@docker build -t strong_network_python_datascience:${VERSION} python_datascience

python_anaconda_image: base_image
	@docker build -t strong_network_python_anaconda:${VERSION} python_anaconda

nodejs_image: base_image
	@docker build -t strong_network_nodejs:${VERSION} nodejs