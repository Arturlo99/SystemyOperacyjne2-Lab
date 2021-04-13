#!/bin/bash -eu

SOURCE_DIR=${1:-"lab_uno"}
RM_LIST=${2:-"lab_uno/2remove"}
TARGET_DIR=${3:-"lab_uno/bakap"}

# If directory TARGET_DIR doesn't exist creates TARGET_DIR
if [[ ! -d ${TARGET_DIR} ]]; then
mkdir ${TARGET_DIR}
fi

# Content of RM_LIST file
FILES_TO_REMOVE=$(cat ${RM_LIST})

# Loop which deletes files/directories from SOURCE_DIR if their names were on RM_LIST
for ITEM in ${FILES_TO_REMOVE}; do
    if [[ -f "${SOURCE_DIR}/$ITEM" || -d "${SOURCE_DIR}/$ITEM" ]]; then
        rm -r "${SOURCE_DIR}/$ITEM"
    fi
done

FILES_IN_SOURCE_DIR=$(ls ${SOURCE_DIR})

for ITEM in ${FILES_IN_SOURCE_DIR}; do
    if [[ -f "${SOURCE_DIR}/$ITEM" ]]; then
        mv "${SOURCE_DIR}/$ITEM" "${TARGET_DIR}"
    elif [[ -d "${SOURCE_DIR}/$ITEM"  &&  "${SOURCE_DIR}/$ITEM" != "${TARGET_DIR}" ]]; then 
        cp -r "${SOURCE_DIR}/$ITEM" "${TARGET_DIR}"
    fi
done

NUMBER_OF_FILES=$(ls ${SOURCE_DIR} | wc -l )

if [[ NUMBER_OF_FILES -gt 0 ]]; then
    echo "There is something more"
    if [[ ${NUMBER_OF_FILES} -ge 2 ]]; then 
        echo "There are at least 2 files"
    fi
    if [[ ${NUMBER_OF_FILES} -gt 4 ]]; then
        echo "There are more then 4 files"
    fi
    if [[ ${NUMBER_OF_FILES} -ge 2 &&  ${NUMBER_OF_FILES} -le 4 ]];then
        echo "There at least 2 files but less or equal 4"
    fi

    else echo "Kononowicz was here"

fi

# Remove TARGET_DIR files edit rights 
FILES_NOT_TO_EDIT=$(ls ${TARGET_DIR})
for FILE in ${FILES_NOT_TO_EDIT}; do
    chmod -w ${TARGET_DIR}/${FILE}
done

DATE=$(date +'%Y-%m-%d')
zip -r bakap_${DATE}.zip ${TARGET_DIR}