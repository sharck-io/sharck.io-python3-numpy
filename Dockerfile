FROM python:3.8-alpine

LABEL maintainer="Domenik Jones <domjones@sharck.io>"

# install project dependencies
COPY requirements/ /requirements

CMD ls /requirements/
CMD env

# separate step because this takes forever
RUN apk --update add --no-cache --virtual .build-deps build-base

# install basic alpine packages
RUN apk add --no-cache bash

# Install dependencies required for building the pip packages below
RUN apk add --update --no-cache gcc libc-dev linux-headers jpeg-dev zlib-dev freetype-dev bash

RUN pip3 install --no-cache-dir -r /requirements/numpy.txt && \
    apk del .build-deps