#!/bin/bash

# This script performs maintenance on this repository. It ensures git submodules are
# installed and then copies over base files from the modules. It also generates the
# documentation.

set -e

curl -sL https://git.io/_has | bash -s docker git jq node npm wget
export REPO_TYPE=dockerfile
git submodule update --init --recursive
if [ ! -f "./.modules/${REPO_TYPE}/update.sh" ]; then
  mkdir -p ./.modules || exit
  git submodule add -b master https://gitlab.com/megabyte-space/common/$REPO_TYPE.git ./.modules/$REPO_TYPE
else
  cd ./.modules/$REPO_TYPE || exit
  git checkout master && git pull origin master
  cd ../.. || exit
fi
bash ./.modules/$REPO_TYPE/update.sh
