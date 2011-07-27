#!/bin/bash
if which yum &> /dev/null; then
   echo "You are in the RedHat family"   
   ./dist/install_yum.sh
else
   echo "You are in the Debian family"
    ./dist/install_apt.sh
fi
