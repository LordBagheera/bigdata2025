#!/bin/bash -eux

# Cargar variables de entorno hacia en env.sh
if [ ! -f /etc/profile.d/env.sh ]; then
    export SPARK_DIST_CLASSPATH=$(hadoop classpath)
    export -p | sed -E 's/^declare -x /export /' > /etc/profile.d/env.sh
    chmod 644 /etc/profile.d/env.sh
fi
# Lanzar set env and start sshd
exec /usr/sbin/sshd -D -e