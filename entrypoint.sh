#!/bin/bash
 
set -e

chown -R "unmanic":"unmanic" /config

exec gosu "unmanic" "/run.sh" "$@"