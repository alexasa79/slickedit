#!/bin/bash

if [ $# -ne "1" ]; then
	echo "usage: create-project <project name>"
	exit 0
fi

proj=$1
echo "Creating project $proj"

exe=$0
dir=$(dirname $exe)
cp -f $dir/template.vpw ./$proj.1.vpw
cp -f $dir/template.vpj ./$proj.1.vpj
sed "s/%PROJECTNAME/$proj/" $proj.1.vpw > $proj.vpw
sed "s/%PROJECTNAME/$proj/" $proj.1.vpj > $proj.2.vpj

find -type f | sed 's/^\.\///' | awk '{ print "<F N=\""$1"\"/>" }' > $proj.files
sed -e "/%PROJECTFILES/r $proj.files" -e '/%PROJECTFILES/d' $proj.2.vpj > $proj.vpj

rm -f $proj.1.vpw
rm -f $proj.1.vpj
rm -f $proj.2.vpj
rm -f $proj.files
