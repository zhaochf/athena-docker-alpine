#!/bin/bash

set -e

# Start ssh service
/usr/sbin/sshd -D


exec "$@"