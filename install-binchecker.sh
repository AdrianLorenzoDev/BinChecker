#!/bin/bash
if [ $EUID != 0 ]; then
	echo "$0: Es necesario ejecutar este programa con permisos de administrador"
	exit -1
fi

mkdir -p /etc/binChecker/
./scripts/snapshot /etc/binChecker


mkdir -p /opt/binChecker
cp ./scripts/snapshot /opt/binChecker/snapshot
cp ./scripts/compareSnapshot /opt/binChecker/compareSnapshot

exit 0
