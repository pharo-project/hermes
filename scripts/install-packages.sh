#!/bin/bash 

#
# This script installs the baseline and saves the image as the name idicated:
#
# Parameters
# ----------
#
# 1) Baseline Name
# 2) New image name
# 3) MC directory (Optional, if it is not informed '.' is used).

BASELINE_NAME=$1
NEW_IMAGENAME=$2

if [ $# -lt 3 ] ; then
  MC=.
else
  MC=$3
fi

set -ex

./pharo Pharo.image eval "
Metacello new 
	baseline: '$BASELINE_NAME';
	repository: 'tonel://$MC';
	load.

Smalltalk saveAs:'$NEW_IMAGENAME'.
"

