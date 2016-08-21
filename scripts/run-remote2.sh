#!/bin/bash

# this script is for running on remote (test) machine
# use ssh user@host bash -s < run-remote.sh to launch

# run-remote.sh works the following way:
#  copy zipped docker files to remote machine
#  unpack and load to docker
#  run docker files
#
# disatvantage of this is that you alway have to copy zipped files which may take some time,
# regardless of whether files were changed or not
#
# run-remote2.sh will work the other way:
#   it will git clone sources (which will take less time because changes will not be major
#   create docker on remote machine and launch it 

set -e

function SetVariables {
  export local_folder=/home/andrey/docker
  export git_folder=${local_folder}/demodocker
  export docker_folder=${git_folder}/docker
  export git_origin=https://github.com/andrey-pohilko/demodocker.git
  export ci_machine=andrey@localhost
  export ci_dist_folder=/home/andrey/docker/demodocker/dist
  export ci_docker_folder=/home/andrey/docker/demodocker/docker
  export ci_compose_file=${ci_docker_folder}/docker-compose.yml.run
  export local_compose_file=${local_folder}/docker-compose.yml
}

function CopyFiles {
  echo "Copying files to remote machine"
  if [ ! -d "${local_folder}" ]; then
    mkdir ${local_folder}
  fi
  
  if [ ! -d "${git_folder}" ]; then
     git clone ${git_origin}
  fi
  
  cd ${git_folder}
  git pull  
}

function RemoveOldDockers {
  echo "Removing old images"
  docker rmi -f pylibs-srv1 pylibs-srv2
}

function LoadDockers {
  echo "Unzipping and loading docker files"
  pwd
  for f in *.tar.gz; do
    echo ${f}
    gunzip -c ${f} | docker load
  done
}

function BuildDockers {
  cd ${docker_folder}
  echo "we will build dockers on here"
 docker build -t pylibs:1.0.0 .
 docker-compose build

}

function RunDockers {
  echo "Running dockers"
  docker-compose up --no-build
}

SetVariables
CopyFiles
cd ${local_folder}
LoadDockers
RunDockers
