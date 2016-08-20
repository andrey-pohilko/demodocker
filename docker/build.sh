#!/bin/bash
export DEBIAN_FRONTEND=noninteractive
set -e

function SetVariables {
  export dist_dir=../dist
  export HOME=/var/lib/jenkins
  export remote_host=andrey@localhost
  export docker_dir=../docker
  export scripts_dir=../scripts
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
 cd ${docker_dir}
 python %{scripts_dir}/putcompose.py
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
  # first run ssh ${remote_host}, ssh-keygen and ssh-copy-id manually 
  ssh ${remote_host} bash -s < run-remote.sh
}

SetVariables
CopySharedLib
BuildDockers
SaveDockers
CopyToRemote
