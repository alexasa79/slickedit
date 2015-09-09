#!/bin/bash

if [ "$1" == "-h" -o $# -gt 1 ]; then
	echo ""
	echo "usage: create-project [project name]"
	echo "       - will use current directory name as project name unless project name is specified"
	echo ""
	exit 0
fi

if [ $# -eq "1" ]; then
	proj=$1
else
	proj=$(basename $(pwd))
fi

echo "Creating project $proj"

exe=$0
dir=$(dirname $exe)
cp -f $dir/template.vpw ./$proj.1.vpw
cp -f $dir/template.vpj ./$proj.1.vpj
sed "s/%PROJECTNAME/$proj/" $proj.1.vpw > $proj.vpw
sed "s/%PROJECTNAME/$proj/" $proj.1.vpj > $proj.2.vpj

find . -name "*.cpp" -o -name "*.c" -o -name "*.h" -o -name "*.cc" -o -name "*.hxx" -o -name "*.hpp" -o -name "*.sh" -o -name "*.py" -o -name "*.pl" \
-o -name "Makefile" -o -name "*.def" -o -name "README.*" -o -name "README" | grep -v "\.svn" | sed 's/^\.\///' | awk '{ print "<F N=\""$1"\"/>" }' > $proj.files
sed -e "/%PROJECTFILES/r $proj.files" -e '/%PROJECTFILES/d' $proj.2.vpj > $proj.vpj

rm -f $proj.1.vpw
rm -f $proj.1.vpj
rm -f $proj.2.vpj
rm -f $proj.files
