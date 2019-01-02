#!/bin/bash

function addedFilesChecker(){
echo "Comprobación archivos añadidos">>/var/log/binChecker
for ((i=1; i<5; i++)); do
	while IFS=" " read -r name permissions md5sum; do
		flag=0
		while IFS=" " read -r oriName oriPermissions oriMd5sum; do
			[[ $name == $oriName ]] && flag=1 && break
		done<"/tmp/prueba/$i"	
			[[ $flag -eq 0 ]] && echo "El archivo $name ha sido añadido">>/var/log/binChecker
	done<"$1$i"
done
}

function filesChecker(){
echo "Comprobación archivos eliminados">>/var/log/binChecker
for ((i=1; i<5; i++)); do
	while IFS=" " read -r name permissions md5sum; do
		flag=0
		while IFS=" " read -r oriName oriPermissions oriMd5sum; do
			[[ $name == $oriName ]] && flag=1 && break
		done<"$1$i"	
			[[ $flag -eq 0 ]] && echo "El archivo $name ha sido eliminado">>/var/log/binChecker && continue
			[[ $permissions == $oriPermissions ]] || echo "Los permisos del archivo $name han sido alterados">>/var/log/binChecker
			[[ $md5sum == $oriMd5sum ]] || echo "El contenido del archivo $name ha sido alterado">>/var/log/binChecker
	done<"/tmp/prueba/$i"
done

addedFilesChecker $1
}



function removeFiles(){
	rm -f "$1*"
}


mkdir /tmp/binChecker
tempdir="/tmp/binChecker/"
./snapshot.sh $tempdir

filesChecker $tempdir
removeFiles $tempdir
