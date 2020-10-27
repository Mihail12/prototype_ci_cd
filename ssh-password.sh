#!/usr/bin/expect -f
spawn ssh-add /tmp/deploy_key
expect "Enter passphrase for /tmp/deploy_key:"
send "travis\n";
expect "Identity added: /tmp/deploy_key (/tmp/deploy_key)"
interact