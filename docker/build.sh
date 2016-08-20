#!/bin/bash
set -e

function SetVariables {
  export dist_dir=../dist
}

function CopySharedLib {
  echo "Copying dependencies "
  for mod in ../srv*; do
    if [ -d "${mod}" ]; then
      rm -rf ${mod}/modules
    fi
    cp -R ../modules ${mod}
  done
}

function BuildDockers {
 python putcompose.py
 docker build -t pylibs:1.0.0 .
 docker-compose build
}

function SaveDocker {
  docker save $1 | gzip - -f > ${dist_dir}/$1.tar.gz
}

function SaveDockers {
  echo "Saving and gzipping docker files"
  for mod in ../srv*; do
    SaveDocker pylibs-${mod##*/}
  done
}

function CopyToRemote {
  ssh andrey@localhost bash -s < run-remote.sh
}

SetVariables
CopySharedLib
BuildDockers
SaveDockers
CopyToRemote
