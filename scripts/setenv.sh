#!/bin/bash
# Check that you have set your path to DR and PAPI tools correctly

#Set this to your DynamoRio top-level install directory - something like DR_BUILD_DIR=/netscratch/jeff/DynamoRIO-Linux-8.0.18831
TOPDIR=$PWD
DR_BUILD_DIR="$TOPDIR/DynamoRIO-Linux-8.0.18831"

#Check that you've put in your DR path
if [ -z "$DR_BUILD_DIR" ]
then
	echo "Please set path to your DynamoRIO install"
else
	export DYNAMORIO_BUILD_DIR=${DR_BUILD_DIR}
	echo "DYNAMORIO_BUILD_DIR set to $DYNAMORIO_BUILD_DIR"
fi

#Check for PAPI as this is used by BP
papi_avail -t &> /dev/null
if [ $? -eq 0 ]; then
	echo "PAPI command found"
else
	echo "PAPI not found - please add PAPI to PATH and LD_LIBRARY_PATH"
fi
