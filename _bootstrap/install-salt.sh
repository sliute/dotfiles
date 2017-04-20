#!/bin/sh

set -eu
IFS=$'\n\t'

bootstrap_root_dir="$(dirname "$(dirname "$(readlink -fn "$0")")")"

apt-get install -y curl

# -X doesn't work under Ubuntu as services are started by default
curl -L https://bootstrap.saltstack.com/develop | sh
systemctl stop salt-minion
systemctl disable salt-minion

cp "${bootstrap_root_dir}/_bootstrap/local-state.conf" /etc/salt/minion.d
sed -i "s%{{ bootstrap.root_dir }}%${bootstrap_root_dir}%" /etc/salt/minion.d/local-state.conf
