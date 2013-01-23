#!/usr/bin/env bash
# Bootstrap script for Chef

echo -n 'self-configuring... '
LOGFILE="$(pwd)"/bootstrap.log
GPGDIR="$(pwd)"/bootstrap.gpg
export DEBIAN_FRONTEND=noninteractive
echo 'done.'

echo 'If things are looking broken, check your log file:'
echo "    ${LOGFILE}"

echo -n 'installing dependencies... '
apt-get install -y git-core >>"$LOGFILE"
echo 'done.'

echo -n 'installing chef repository... '
cat > /etc/apt/sources.list.d/opscode.list <<EOF
deb http://apt.opscode.com/ $(lsb_release -cs)-0.10 main
EOF

mkdir -p /etc/apt/trusted.gpg.d
mkdir -p "$GPGDIR"
chown root:root "$GPGDIR"
chmod 0700 "$GPGDIR"
gpg --homedir "$GPGDIR" --keyserver keys.gnupg.net \
    --recv-keys 83EF826A 2>>"$LOGFILE"
gpg --homedir "$GPGDIR" \
    --export packages@opscode.com \
        | tee /etc/apt/trusted.gpg.d/opscode-keyring.gpg \
		>/dev/null 2>>"$LOGFILE"
apt-get update >>"$LOGFILE"
apt-get install -y opscode-keyring >>"$LOGFILE"
echo 'done.'

echo -n 'upgrading system packages... '
apt-get upgrade -y >>"$LOGFILE"
echo 'done.'

echo -n 'installing chef... '
apt-get install -y chef >>"$LOGFILE" 2>&1
echo 'done.'

echo -n 'cleaning up... '
rm -rf "$GPGDIR"
echo 'done.'

echo 'Bootstrapping complete; you are now ready to provision:'
echo '    $ sudo chef-solo -c solo.rb -j configs/<config>.json'

