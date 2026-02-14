# syntax=docker/dockerfile:1.7
ARG ALPINE_VERSION=3.23.3
FROM alpine:${ALPINE_VERSION}

LABEL org.opencontainers.image.title="SecureLayer Labs Base Alpine"
LABEL org.opencontainers.image.description="Minimal Alpine base image for SecureLayer Labs secure image series"
LABEL org.opencontainers.image.source="https://github.com/SecureLayer-Labs/base-alpine"
LABEL org.opencontainers.image.licenses="Apache-2.0"

# Minimal runtime essentials
RUN apk add --no-cache \
      ca-certificates \
      tzdata \
      tini \
 && adduser -D -u 10001 -G root app \
 && mkdir -p /work \
 && chown -R 10001:0 /work \
 && chmod -R g=u /work

WORKDIR /work
ENTRYPOINT ["/sbin/tini","--"]
CMD ["sh","-lc","echo 'SecureLayer Labs base-alpine. Override CMD in your derived image.' && sleep 3600"]
