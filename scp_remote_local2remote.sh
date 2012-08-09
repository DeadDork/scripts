#!/bin/sh

#################################################################################
#    Copyright (c) 2012 Nimrod Omer.                                            #
#                                                                               #
#    Permission is hereby granted, free of charge, to any person obtaining      #
#    a copy of this software and associated documentation files (the            #
#    "Software"), to deal in the Software without restriction, including        #
#    without limitation the rights to use, copy, modify, merge, publish,        #
#    distribute, sublicense, and/or sell copies of the Software, and to         #
#    permit persons to whom the Software is furnished to do so, subject to      #
#    the following conditions:                                                  #
#                                                                               #
#    The above copyright notice and this permission notice shall be included    #
#    in all copies or substantial portions of the Software.                     #
#                                                                               #
#    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,            #
#    EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF         #
#    MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.     #
#    IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY       #
#    CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,       #
#    TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE          #
#    SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.                     #
#################################################################################

# This is a useful script for scp-ing stuff via a reverse-ssh tunnel. It assumes the user has already used something like ssh2remote.sh to connect to the remote computer.

# This particular script will scp from the physical computer to the remote computer the user has ssh'ed to.

read -p "Remote host port number: " remote_port
read -p "Local host name: " local_host
read -p "Enter the file name (with its full file path) that you want to scp: " source
read -p "Enter the destination directory (with its full file path): " destination

scp -r -P "${remote_port}" "${local_host}"@localhost:"${source}" "${destination}"
