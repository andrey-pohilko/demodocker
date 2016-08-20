#!/bin/bash
set -e

echo "Copying dependencies "
for mod in ../srv*; do
  if [ -d "${mod}" ]; then
    rm -rf ${mod}/modules
  fi
  cp -R ../modules ${mod}
done

docker build -t pylibs:1.0.0 .

docker-compose up

export dist_dir=../dist

function save_docker {
  docker save $1 | gzip - -f > ${dist_dir}/$1.tar.gz
}

echo "Saving and gzipping docker files"
for mod in ../srv*; do
  save_docker pylibs-${mod##*/}
done
