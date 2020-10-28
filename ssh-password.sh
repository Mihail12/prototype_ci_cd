#!/bin/bash

if [ $# -ne 1 ] ; then
  echo "Usage: ssh-add-pass keyfile passfile"
  exit 1
fi

expect << EOF
  spawn ssh-add $1
  expect "Enter passphrase"
  send "travis\r"
  expect eof
EOF