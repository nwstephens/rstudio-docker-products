#!/usr/bin/env bash

set -e

if [ $# -eq 0 ] ; then
    echo "usage: $0 <target> ..."
    echo
    echo "Common uses:"
    echo "    $0 tag"
    echo "    $0 build"
    echo "    $0 push"
    exit 1
fi

TARGETS="$@"

build() {
    # Make sure we have at least one image containing the older versions.
    make ${1} R_VERSION=3.1.3 PYTHON_VERSION=2.7.18
    make ${1} R_VERSION=3.2.5 PYTHON_VERSION=2.7.18
    make ${1} R_VERSION=3.3.3 PYTHON_VERSION=3.6.13
    make ${1} R_VERSION=3.4.4 PYTHON_VERSION=3.6.13
    make ${1} R_VERSION=3.5.3 PYTHON_VERSION=3.7.10
    make ${1} R_VERSION=3.6.3 PYTHON_VERSION=3.8.8

    # The latest two R/Python versions are built with both sets of combinations.
    make ${1} R_VERSION=4.0.5 PYTHON_VERSION=3.8.8
    make ${1} R_VERSION=4.0.5 PYTHON_VERSION=3.9.2
    make ${1} R_VERSION=4.1.0 PYTHON_VERSION=3.8.8
    make ${1} R_VERSION=4.1.0 PYTHON_VERSION=3.9.2
}

# build content-base
pushd base/
build "${TARGETS[@]}"
popd

# build content-pro
pushd pro/
build "${TARGETS[@]}"
popd
