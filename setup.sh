#!/usr/bin/env bash

#########################################################
# beeselmane - Corona-X - setup.sh                      #
# 9:00 PM EST [UTC-5] - 13.5.2015                       #
#########################################################
# Script is meant to be run as source before XBS is     #
# invoked on the system's source code                   #
#########################################################
# Environment Variables involved in the build process:  #
#   XROOT    - The root for the entire Corona-X         #
#              repository                               #
#   SYS_SRC  - The directory containg all of the Source #
#              Code for the System itself               #
#   TOOL_SRC - The directory containing all of the      #
#              Source Code for any tools used to build  #
#              the system                               #
#   PROJDIR  - The directory containing the XBS project #
#              folders specifying how to build a given  #
#              product. [Default only contains CX]      #
#   OBJ_DIR  - The directory that C object files are    #
#              placed into while the System is being    #
#              built. Non existant by default.          #
#   OUT_DIR  - The product output directory. The System #
#              is built into this directory, which is   #
#              located at ${XROOT}/out/root by default  #
#   TOOL_DIR - The directory used to store tools that   #
#              are used to build the system. This is    #
#              the only directory added to ${PATH} when #
#              building Corona-X.                       #
#########################################################
# Functions added by this file:                         #
#   path_add     - Adds the first argument to the       #
#                  beginning of the ${PATH} environment #
#                  variable. This is used internally    #
#                  here only.                           #
#   xroot        - Change Working Directory to the last #
#                  saved value of ${XROOT}. Used in     #
#                  build-x and build-module             #
#   build-module - Builds the current Working Directory #
#                  with the build configuration saved   #
#                  in the environment.                  #
#   buildx       - Builds the entire System.            #
#   x-config     - Configures the Build. Pass in 3      #
#                  arguments: the build type, the build #
#                  architectures, and the build target. #
#########################################################
# Environment Variables Used for Build Configuration:   #
#   BUILDTYPE - The Build Type to use to build          #
#               ${TARGET}. This may be `debug`,         #
#               `development`, or `release`, and is set #
#               to `release` by default. The meaning of #
#               this setting is described in more       #
#               more detail in the XBS documentation    #
#               and the Corona-X project design.        #
#   ARCHS     - A list of Processor Architectures to    #
#               build ${TARGET} on. Currently only      #
#               `x86_64` and `stub` are supported.      #
#   TARGET    - The target to build. This should be the #
#               target's XBS project directory, which   #
#               should be stored in ${PROJDIR} by       #
#               default. This is set to                 #
#               `${PROJDIR}/Corona-X` by default.       #
#########################################################

export XROOT=`pwd`
export SYS_SRC="${XROOT}/source"
export TOOL_SRC="${XROOT}/tools"
export PROJDIR="${XROOT}/projects"
export OBJ_DIR="${XROOT}/out/build"
export OUT_DIR="${XROOT}/out/root"
export TOOL_DIR="${XROOT}/out/tools"

# Add first argument to
# command search paths
function path_add {
    if [[ -n ${1+x} ]]; then
        export PATH=${1}:${PATH}
    fi
}

# Make repo root the
# current directory
function xroot {
	cd ${XROOT}
}

# Build module from current directory
function build-module {
	MODULE=`pwd`
	xroot
	make MODULES=${MODULE}
}

# build everything
function buildx {
	xroot
    make
}

# Configure build type
# architectures and
# target project
function x-config {
    export BUILDTYPE=${1}
    export ARCHS="${2}"
    export TARGET="${3}"
}

# Setup environment and activate defaults
x-config release "x86_64" "${PROJDIR}/Corona-X"
path_add ${TOOLDIR}
