#!/bin/bash -xeu

set -o pipefail

# clone upstream repos

# pkgs

[[ -d pkgs ]] || git clone https://github.com/siderolabs/pkgs.git
cd pkgs
git checkout -f
git clean -xdf
git checkout $(cat ../values.yaml | yq .siderolabs_pkgs_git_branch)
git pull
cd ..

# extensions

[[ -d extensions ]] || git clone https://github.com/siderolabs/extensions.git
cd extensions
git checkout -f
git clean -xdf
git checkout $(cat ../values.yaml | yq .siderolabs_extensions_git_branch)
git pull
