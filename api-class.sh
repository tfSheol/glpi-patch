#!/usr/bin/env bash

set -e

if [[ $1 == "" ]]; then
  echo "usage: "
  echo -e "\t $0 <path_of_glpi>"
  exit 0
fi

file="$1/inc/api.class.php"

if [[ -f "${file}" ]]; then
  if [[ $(egrep "app-token" ${file}) == "" ]]; then
    search=$(egrep "session-token" ${file})
    fix=${search//session-token, /session-token, app-token, }
    cp ${file} ${file}.bak
    sed -i "s/${search}/${fix}/g" ${file}
  if [[ $(egrep "app-token" ${file}) == "" ]]; then
    echo "error ! plz check patch..."
    exit -1
  else
    echo "successful !"
    exit 0
  fi
  else
    echo "patch already apply"
    exit -1
  fi
else
  echo "${file} not found"
  exit -1
fi

exit 0
