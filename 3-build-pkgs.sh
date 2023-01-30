#!/bin/bash -xeu

set -o pipefail

PLATFORM="$(cat values.yaml | yq .platform)"
REGISTRY="$(cat values.yaml | yq .registry)"
REPOSITORY="$(cat values.yaml | yq .repository)"

#[[ -d cache/kernel-build ]] || mkdir -p cache/kernel-build

cd pkgs

make TARGETS="kernel zfs-pkg" PLATFORM="${PLATFORM}" REGISTRY="${REGISTRY}" USERNAME="${REPOSITORY}" PUSH="true"

cd ..
