#!/bin/bash
touch $HOME/.Xauthority
echo "$XAUTH" | xauth nmerge - || true
#sudo /usr/bin/ip r del default
exec $CMD
