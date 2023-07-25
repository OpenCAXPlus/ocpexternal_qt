#!/bin/bash
# This is the script to compress and publish the external project source code to 
# ocp-external bucket. You should not use it, because normal user only has read
# permission to the bucket. To publish this external project, please submit an 
# issue in the OCP sdk repository.

version=${1:-6.3.0}
external_id=${2:-qt}

xzfile="$external_id-$version.tar.xz"
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"

# move to the root of the external repository
cd $script_dir/..

# start the script
echo "Remove previous tar.xz files"
rm -rf ${external_id}-*.tar.xz
echo "Create external compressed file from ocp folder"
tar -cJf $xzfile ocp/
rclone copy -P $xzfile ali:ocp-external/$external_id
echo "Upload compressed file to ocp-external/$external_id"

# move back to the folder where you started
cd -
