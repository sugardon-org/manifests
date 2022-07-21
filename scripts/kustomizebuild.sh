#!/usr/bin/env bash

set -eux

BUILD_DIR="build"
mkdir -p $BUILD_DIR
rm -f $BUILD_DIR/*.yaml

kustomize build argocd-apps/overlays/sugardon01 -o=$BUILD_DIR
