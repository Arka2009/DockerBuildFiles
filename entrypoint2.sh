#!/bin/bash
# entrypoint.sh file for starting the xvfb with better screen resolution, configuring and running the vnc server
. /root/chipyard/env.sh
export DISPLAY=:20
Xvfb :20 -screen 0 1366x768x16 &
x11vnc -forever -usepw -create &
exec "$@"