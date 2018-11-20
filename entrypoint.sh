#!/bin/bash
printenv | grep -v "no_proxy" >> /etc/env
exec "$@"
