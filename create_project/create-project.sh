#!/bin/bash

if [ "$1" == "-h" -o "$1" == "--help" -o $# -gt 1 ]; then
	echo ""
	echo "usage: create-project [project name]"
	echo "       - Will create SlickEdit project either in current directory or in directory"
	echo "         specified by SLICKEDITPROJ environment variable. Project name will be either"
	echo "         name of current directory or as specified in second argument."
	echo ""
	exit 0
fi

if [ $# -eq "1" ]; then
	proj_name=$1
else
	proj_name=$(basename $(pwd))
fi

if [ -e "$SLICKEDITPROJ" ]; then
	proj_file=$SLICKEDITPROJ/$proj_name
else
	proj_file=$(pwd)/$proj_name
fi

echo "Creating workspace $proj_file.vpw"

exe=$0
dir=$(dirname $exe)
cp -f $dir/template.vpw $proj_file.1.vpw
cp -f $dir/template.vpj $proj_file.1.vpj
sed "s/%PROJECTNAME/$proj_name/" $proj_file.1.vpw > $proj_file.vpw
sed "s/%PROJECTNAME/$proj_name/" $proj_file.1.vpj > $proj_file.2.vpj

find . -name "*.cpp" -o -name "*.c" -o -name "*.h" -o -name "*.cc" -o -name "*.hxx" -o -name "*.hpp" -o -name "*.sh" -o -name "*.py" -o -name "*.pl" \
-o -name "Makefile" -o -name "*.make" -o -name "*.mak" -o -name "*.def" -o -name "README.*" -o -name "README" | grep -v "\.svn" | sed 's/^\.\///' > $proj_file.files1

for file in $(cat $proj_file.files1); do
	if [ ! -h $file ]; then
		file2=$(realpath $file)
		echo $file2 >> $proj_file.files2
	fi
done

cat $proj_file.files2 | awk '{ print "<F N=\""$1"\"/>" }' > $proj_file.files

sed -e "/%PROJECTFILES/r $proj_file.files" -e '/%PROJECTFILES/d' $proj_file.2.vpj > $proj_file.vpj

rm -f $proj_file.1.vpw
rm -f $proj_file.1.vpj
rm -f $proj_file.2.vpj
rm -f $proj_file.files
rm -f $proj_file.files1
rm -f $proj_file.files2
