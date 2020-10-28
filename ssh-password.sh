#!/bin/bash

if [ $# -ne 1 ] ; then
  echo "Usage: ssh-add-pass keyfile passfile"
  exit 1
fi
chmod 400 deploy_key
expect << EOF
  spawn ssh -o LogLevel=ERROR -i deploy_key ubuntu@35.158.109.210 'bash ~/prototype_ci_cd/deploy.sh'
  expect "Enter passphrase"
  send "travis\r"
  expect eof
EOF