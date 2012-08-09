#!/bin/bash

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

# This script manually moves swap memory back to RAM.

# My script borrows heavily from <https://help.ubuntu.com/community/SwapFaq/#Empty_Swap>. I changed it a bit to make it more verbose and easier to understand for a novice (like me).

# Sets 'mem' to the amount of RAM that is currently free.
mem=$(free | grep 'Mem:' | awk '{print $4}')
# Sets 'swap' to the amount of swap memory that is currently being used.
swap=$(free | grep 'Swap:' | awk '{print $3}')

if (( ${mem} < ${swap} )); then # Checks that 'mem' is not less than 'swap'.
	echo 'There is not enough RAM to write swap back, so nothing was done.'
	exit 1
else # If there is enough 'mem', then swap memory is moved into RAM and swap is reset.
	sudo swapoff -a
	sudo swapon -a
fi

exit 0
