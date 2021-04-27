#!/bin/bash -e

# Script arguments
FIRST_DIR_PATH=${1}
SECOND_DIR_PATH=${2}
set -u

# Errors codes
DIRS_DONT_EXIST=10
NO_PARAMETERS_GIVEN=15

# If parameters weren't given
if [[ $# -lt 2 ]]; then
    echo "Not enough parameters given"
    exit ${NO_PARAMETERS_GIVEN}
fi

# If directories don't exist 
if [[ ! -d ${FIRST_DIR_PATH} || ! -d ${SECOND_DIR_PATH} ]]; then
    echo "One or more of given paths is not dir path"
    exit ${DIRS_DONT_EXIST}
fi

# First directory files
FIRST_DIR_FILES=$(ls ${FIRST_DIR_PATH})

for FILE in ${FIRST_DIR_FILES}; do

    if [[ -d $FIRST_DIR_PATH/${FILE} && -L $FIRST_DIR_PATH/${FILE} ]]; then
        echo "${FILE} is a directory"
        FILE_UPPER_CASE=${FILE^^}
        ln -s $(pwd ${FIRST_DIR_PATH})/${FIRST_DIR_PATH}/${FILE} "${SECOND_DIR_PATH}/${FILE_UPPER_CASE}_ln"
    fi

    if [[ -f $FIRST_DIR_PATH/${FILE} && ! -L $FIRST_DIR_PATH/${FILE} ]]; then
        echo "${FILE} is a regular file"
        FILE_UPPER_CASE=${FILE^^}
        FILE_EXT=${FILE_UPPER_CASE#*.}
        if [[ FILE_EXT == "" ]]; then
            ln -s $(pwd ${FIRST_DIR_PATH})/${FIRST_DIR_PATH}/${FILE} "${SECOND_DIR_PATH}/${FILE_UPPER_CASE}_ln"
        else
            ln -s $(pwd ${FIRST_DIR_PATH})/${FIRST_DIR_PATH}/${FILE} "${SECOND_DIR_PATH}/${FILE_UPPER_CASE%%.*}_ln.${FILE#*.}"
        fi
    fi

    if [[ -L $FIRST_DIR_PATH/${FILE} ]]; then
        echo "${FILE} is a symbolic link"
    fi

done
exit 0