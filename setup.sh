#!/bin/bash

# Script is meant to be run as source
# before XBS is invoked on sourcedir

export X_SRCROOT=`pwd`

export X_OBJROOT=${X_SRCROOT}/out/build
export X_INSTDIR=${X_SRCROOT}/out/root
export X_TOOLDIR=${X_SRCROOT}/out/tools

function xroot {
	cd ${X_SRCROOT}
}

function xbuild {
	MODULE=`pwd`
	x-root
	make BUILDMODS=${MODULE}
}

function xbuildall {
	x-root
	make all
}

function x-config {
	export X_BUILDTYPE=$1
    export ARCHS="${2}"
}

# Set defaults
x-config release x86_64
