#!/bin/bash
export -p > /root/env_var.sh
/usr/sbin/sshd
tail -f /dev/null
