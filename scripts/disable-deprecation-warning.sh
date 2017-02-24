#!/bin/bash 

set -ex

./pharo Pharo.image eval --save "
Deprecation showWarning: false.
Deprecation raiseWarning: false.
"

