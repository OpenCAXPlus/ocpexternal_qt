#!/bin/bash
# This is a template script to install the external project
# You should create a configuration folder and copy this script
# to the folder for actual installation.

config=$(basename "${BASH_SOURCE[0]}" .sh)
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
root="$script_dir/.."
source_dir="$script_dir/../source"
build_dir="$script_dir/../build/$config"
install_dir="$script_dir/../install/$config"

mkdir -p $build_dir
cd $build_dir
${source_dir}/configure -prefix ${install_dir} -release -opensource -confirm-license -nomake tools -nomake examples -nomake tests
cd -

cmake --build $build_dir
cmake --build $build_dir --target install