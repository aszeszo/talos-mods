#!/bin/bash -xeu

set -o pipefail

REGISTRY="$(cat values.yaml | yq .registry)"
REPOSITORY="$(cat values.yaml | yq .repository)"


# drop "-dirty" suffix from the tags
sed -i "" "s/ --dirty//g" pkgs/Makefile extensions/Makefile

# workaround "ERROR: attestations are not supported by the current buildkitd" on macOS Docker Desktop
sed -i "" "/^COMMON_ARGS += --provenance=.*/d" pkgs/Makefile extensions/Makefile


# add zfs pkg
cp -r pkgs-zfs/ pkgs/zfs/
for i in libtirpc_version libtirpc_sha256 libtirpc_sha512 zfs_version zfs_sha256 zfs_sha512; do
  sed -i "" "s/\(${i} := \"\)/\1$(cat values.yaml | yq .${i})/" pkgs/zfs/pkg.yaml
done


# add zfs extension
cp -r extensions-zfs/ extensions/storage/zfs/
VERSION_ZFS="$(cat values.yaml | yq .zfs_version)"
EXTENSION_VERSION_ZFS="${VERSION_ZFS}-$(cat values.yaml | yq .siderolabs_talos_installer)"
sed -i "" "s,^\(  - image: \).*,\1\"${REGISTRY}\/${REPOSITORY}\/zfs-pkg:{{ .PKGS_VERSION }}\"," extensions/storage/zfs/pkg.yaml
sed -i "" "s/^\(VERSION: \).*/\1\"${EXTENSION_VERSION_ZFS}\"/" extensions/storage/zfs/vars.yaml
