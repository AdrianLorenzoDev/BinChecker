#!/bin/bash

function addedFilesChecker(){
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
for ((i=1; i<5; i++)); do
	while IFS=" " read -r name permissions md5sum; do
		flag=0
		while IFS=" " read -r oriName oriPermissions oriMd5sum; do
			[[ $name == $oriName ]] && flag=1 && break
		done<"$1$i"	
			[[ $flag -eq 0 ]] && echo "El archivo $name ha sido eliminado">>/var/log/binChecker && continue
			[[ $permissions == $oriPermissions ]] || printf "Los permisos del archivo $name han sido alterados: \n Permisos actuales: $permissions \n Permisos originales: $oriPermissions\n">>/var/log/binChecker
			[[ $md5sum == $oriMd5sum ]] || printf "El contenido del archivo $name ha sido alterado: \n Suma de control actual: $md5sum \n Suma de control original: $oriMd5sum \n">>/var/log/binChecker
	done<"/tmp/prueba/$i"
done

addedFilesChecker $1
}


echo "Comprobación con fecha : $(date +"%d-%m-%Y")" >>/var/log/binChecker

mkdir /tmp/binChecker
tempdir="/tmp/binChecker/"
./snapshot.sh $tempdir

filesChecker $tempdir
rm -rf /tmp/binChecker