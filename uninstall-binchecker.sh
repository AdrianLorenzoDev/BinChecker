#!/bin/bash
if [ $EUID != 0 ]; then
	echo "$0: Es necesario ejecutar este programa con permisos de administrador"
	exit -1
fi

rm -rf /etc/binChecker
rm -rf /opt/binChecker

exit 0
