#!/bin/sh
set -e

# Start NiFi in the background
${NIFI_HOME}/bin/nifi.sh run &

# Wait a bit for NiFi to start and possibly crash
sleep 10

# If NiFi is not running, keep the container alive for inspection
if ! pgrep -f "org.apache.nifi.NiFi"; then
  echo "NiFi process not running. Keeping container alive for inspection."
  tail -f /dev/null
else
  # Wait for NiFi process to exit (container will stop if NiFi stops)
  wait
fi
