#!/bin/bash -x


# Make a function to run go get for us, and have it output letting us know.
function goget (){
    echo "Getting $1"
    go get $2
}

project_files=$(echo ~/project-files)
runners_dir=$(echo ~/workspace/.c9/runners)
home_url='https://raw.github.com/gdey/c9-golangsetup/master'

echo "We are going to setup some tools"
goget goimports golang.org/x/tools/cmd/goimports
goget goat github.com/yosssi/goat/...

# We are now going to set the CDPATH
grep CDPATH  ~/.bashrc 2>&1 1>/dev/null
if [ "$?" != "0" ]; then
echo "Setting up CDPATH"
echo 'CDPATH=.:~/workspace/:~/workspace/src/' >> ~/.bashrc
fi


mkdir -p ${project_files}
mkdir -p ${runners_dir}
curl $home_url/project-files/goat.yml -o ${project_files}/goat.yml 2>/dev/null
echo "copy ${project_files}/goat.yml to the home of your project."

# copy over the runners.
curl $home_url/c9-runners/goat.run -o ${runners_dir}/goat.run 2>/dev/null

exec bash

