FROM python:3.7-slim

LABEL maintainer="Liran Tal <liran@snyk.io>"
LABEL securitytxt="https://github.com/lirantal/docker-detect-secrets/blob/master/security.txt"
LABEL org.label-schema.schema-version="1.0"
LABEL org.label-schema.name="docker-secrets"
LABEL org.label-schema.description="A docker image for Yelp's docker-secrets python application"
LABEL org.label-schema.vcs-url="https://github.com/lirantal/docker-detect-secrets"
LABEL org.label-schema.version=$BUILD_VERSION
LABEL org.label-schema.docker.cmd="docker run -v ~/ballerina/packages:/ballerina/files -p 9090:9090 -d ballerinalang/ballerina"

RUN pip install detect-secrets

WORKDIR /usr/src/app
ENTRYPOINT ["detect-secrets-hook", "--verbose"]