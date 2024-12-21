#!/bin/bash
touch $HOME/.Xauthority
echo "$XAUTH" | xauth nmerge - || true
ip r del default
exec /bin/bash $@
