#!/bin/bash

target_dir=$1
arch=$2
exclude_dir=arch/$2

echo $exclude_dir
echo "generating ctags! please hold on!"
if [ "$target_dir"x != ""x ] ; then
		cd $target_dir
fi
rm -f *cscope.*
rm -f tags
ctags -R

if [ "$arch"x != ""x ] ; then
	find . -path "./$exclude_dir/*" -name '*.[hcSs]' -print > cscope.files
	find . -name '*.[hcsS]' | grep -v '^\./arch/' >> cscope.files
else
	find . -name '*.[hcsS]' > cscope.files
fi

echo "generating cscope.files.tmp! please hold on!"
if [ "$target_dir"x = ""x ] ; then
		cscope -bkq -i cscope.files 
else
		cscope -bkq -i cscope.files -P $target_dir
fi
#rm -f cscope.files
