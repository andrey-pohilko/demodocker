#!/bin/bash
set -e

export dist_dir=../dist

function load_docker {
  gunzip -c $1 | docker load
}

echo "Unzipping and loading docker files"
for mod in ../dist/*; do
  load_docker ${mod}
done
docker run pylibs-srv1 python mod1.py
docker run pylibs-srv2 python mod2.py
