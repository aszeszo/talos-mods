#!/bin/bash -xeu

set -o pipefail

PLATFORM="$(cat values.yaml | yq .platform)"
REGISTRY="$(cat values.yaml | yq .registry)"
REPOSITORY="$(cat values.yaml | yq .repository)"

cd extensions

make TARGETS="zfs" PLATFORM="${PLATFORM}" REGISTRY="${REGISTRY}" USERNAME="${REPOSITORY}" PUSH="true"

cd ..
