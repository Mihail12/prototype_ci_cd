#!/bin/bash

if [ $# -ne 1 ] ; then
  echo "Usage: ssh-add-pass keyfile passfile"
  exit 1
fi

expect << EOF
  spawn ssh-add deploy_key
  expect "Enter passphrase"
  send "travis\r"
  expect eof
EOF
ssh-keyscan 35.158.109.210 >> ~/.ssh/known_hosts

expect << EOF
  spawn ssh -o LogLevel=ERROR -i deploy_key ubuntu@35.158.109.210 'bash ~/prototype_ci_cd/deploy.sh'
  expect "Enter passphrase"
  send "travis\r"
  expect eof
EOF