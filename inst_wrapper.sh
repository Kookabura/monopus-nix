#!/bin/bash

read -sp "API key: " API_KEY; echo

if [[ -z "$API_KEY" ]]; then
echo "Missing API key"
exit 1
fi

wget -c https://github.com/Kookabura/monopus-nix/archive/refs/heads/develop.tar.gz
tar -xzf develop.tar.gz
cd monopus-nix-develop
chmod -R +x ./install.sh ./json.sh ./common.sh ./monopus ./check_scripts
./install.sh -k $API_KEY