#!/bin/bash
if (($# < 1)); then
	exit -1
fi

function createStamp(){
	IFS=$'\n'
	for file in $(find $1 -maxdepth 1); do
		(stat -c "%n %A" $file && md5sum $file | cut -d" " -f1) | sed ':a;N;$!ba;s/\n/ /g' >> "$2$3"
	done;
}

mkdir "$1/" 2>/dev/null
i=1 
for directory in /bin /sbin /usr/bin /usr/sbin; do
	createStamp $directory $1 $i
	(( i++ ))
done;
