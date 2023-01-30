#!/bin/bash -xeu

set -o pipefail

PLATFORM=$(cat values.yaml | yq .platform)
REGISTRY=$(cat values.yaml | yq .registry)
REPOSITORY=$(cat values.yaml | yq .repository)
TAG_PKGS=$(cd pkgs; git describe --tag --always)
TAG_INSTALLER=$(cat values.yaml | yq .siderolabs_talos_installer)

docker buildx build --platform="${PLATFORM}" --tag "${REGISTRY}/${REPOSITORY}/installer:${TAG_INSTALLER}" --push - <<EOD
FROM scratch AS customization
FROM --platform=\${TARGETPLATFORM} ${REGISTRY}/${REPOSITORY}/kernel:${TAG_PKGS} AS kernel
FROM --platform=\${TARGETPLATFORM} ghcr.io/siderolabs/installer:${TAG_INSTALLER}
COPY --from=kernel /boot/vmlinuz /usr/install/\${TARGETARCH}/vmlinuz
EOD
