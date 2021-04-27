#!/bin/bash -e

# Errors codes

DIRS_DONT_EXIST=10
NO_PARAMETERS_GIVEN=15

# Script arguments
DIR=${1}
FILE=${2}
DATE=$(date --iso-8601)
set -u

# If parameters weren't given
if [[ $# -lt 2 ]]; then
    echo "Not enough parameters given"
    exit ${NO_PARAMETERS_GIVEN}
fi

# If directories don't exist 
if [[ ! -d ${DIR} ]]; then
    echo "Given dir path is incorrect"
    exit ${DIRS_DONT_EXIST}
fi

FILE_LIST=$(ls ${DIR})

for ITEM in ${FILE_LIST}; do
    if [[ -L ${DIR}/${ITEM} && ! -e ${DIR}/${ITEM} ]]; then
        echo "${ITEM} - ${DATE}" >> ${FILE}
        rm ${DIR}/${ITEM}
    fi
done
exit 0