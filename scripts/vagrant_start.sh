#!/bin/bash

FILE="Vagrantfile"
SCRIPT="/home/vagrant/src/scripts/kube-cluster.sh"

mkdir -p vm
cd vm

set +e

if [ ! -f $FILE ]; then
	echo "Creating Vagrant Box"
	vagrant init
	rm -rf Vagrantfile
	cp ../Vagrantfile .
fi

vagrant up
vagrant ssh -c "sh $SCRIPT"

set -e
