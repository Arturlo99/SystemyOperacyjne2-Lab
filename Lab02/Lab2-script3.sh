#!/bin/bash -eu

DIR=${1}
set -u

# Errors codes
DIR_DOESNT_EXIST=10

# If parameters weren't given
if [[ $# -lt 1 ]]; then
    echo "Not enough parameters given"
    exit ${NO_PARAMETERS_GIVEN}
fi

# If directory doesn't exist 
if [[ ! -d ${DIR} ]]; then
    echo "Given dir path is incorrect"
    exit ${DIRS_DONT_EXIST}
fi

DIR_FILES=$(ls ${DIR})

for FILE in ${DIR_FILES}; do

    if [[ -f ${DIR}/${FILE} && ${FILE#*.} == "bak" ]]; then
        chmod uo-w ${DIR}/${FILE}
    fi

    if [[ -d ${DIR}/${FILE} && ${FILE#*.} == "bak" ]]; then
        chmod ug-w,o+x ${DIR}/${FILE}
    fi

    if [[ -d ${DIR}/${FILE} && ${FILE#*.} == "tmp" ]]; then
        chmod a+wx ${DIR}/${FILE}
    fi

    if [[ -e ${DIR}/${FILE} && ${FILE#*.} == "txt" ]]; then
        chmod u+r-wx,g+w-rx,o+x-rw ${DIR}/${FILE}
    fi

    if [[ -f ${DIR}/${FILE} && ${FILE#*.} == "exe" ]]; then
        sudo chmod a+x ${DIR}/${FILE}
    fi

done
exit 0