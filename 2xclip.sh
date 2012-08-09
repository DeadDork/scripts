#!/bin/sh

# This is a handy script for copying the output from a command, but without a pesky newline character (e.g. for when you want to quickly copy the directory path from one terminal to another).

awk '{printf "%s", $0}' | xclip
