#!/bin/bash
# This is a template script to install the external project
# You should create a configuration folder and copy this script
# to the folder for actual installation.

version=${1:-v6.3.0}
config=$(basename "${BASH_SOURCE[0]}" .sh)
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
root="$script_dir/.."
source_dir="$script_dir/../source"
build_dir="$script_dir/../build/$config"
install_dir="$script_dir/../install/$config"

cmake -S $source_dir -B $build_dir -DCMAKE_INSTALL_PREFIX=$install_dir -G Ninja
cmake --build $build_dir --target install

cd $root
git clone https://code.qt.io/qt/qt5.git source
cd $source_dir
git checkout $version
./init-repository --module-subset="qtbase"
mkdir -p $build_dir
cd $build_dir
${source_dir}/configure -prefix ${install_dir} -release -opensource -confirm-license -nomake tools -nomake examples -nomake tests
cmake --build . --parallel 4
cmake --install .