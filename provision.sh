#!/bin/bash

FILE="Vagrantfile"
SCRIPT="options.sh"

mkdir -p vm
cp $SCRIPT vm/
cd vm

set +e

IP=vagrant ssh -c "hostname -I | cut -d' ' -f2" 2>/dev/null
echo "IP Address $IP"
if [ ! -f $FILE ]; then
	echo "File Does not Exist"
        vagrant init geerlingguy/ubuntu1804
	sed -i -e 's/# config.vm.network "private_network"/ config.vm.network "private_network"/' $FILE
fi

vagrant up

# Copying Script in Vagrant Machine

scp -o StrictHostKeyChecking=no -i /home/rle0572/vault/src/project/deployScript/vm/.vagrant/machines/default/virtualbox/private_key $SCRIPT vagrant@$(awk 'BEGIN { FS = ", ip:"}{print $2}' Vagrantfile | grep '"'| cut -d '"' -f 2):~/

vagrant ssh -c "./$SCRIPT start"
echo "outside: $HOME"

set -e

