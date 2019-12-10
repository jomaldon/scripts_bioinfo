#!/bin/bash -e
## Script de bash (utuntu 16.04) para monitorear estado de la RAM
# github: jomaldon

echo "      date     time $(free -m | grep total | sed -E 's/^    (.*)/\1/g')"
while true; do
    echo "$(date '+%Y-%m-%d %H:%M:%S') $(free -m | grep Mem: | sed 's/Mem://g')"
    sleep 5
done
