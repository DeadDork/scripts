#!/bin/bash

# Opens a client to the URXVT256 daemon--and if one is not running, begins it

urxvt256cc "$@"
if [ $? -eq 2 ]; then
	urxvt256cd -q -o -f
	urxvt256cc "$@"   
fi
