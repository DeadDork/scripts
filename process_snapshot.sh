#!/bin/sh

#################################################################################
#    Copyright (c) 2012 Nimrod Omer.                                            #
#                                                                               #
#    To contact me, visit my github page at <https://www.github.com/DeadDork>.  #
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

# This is a quick little script for showing what process is doing what when the script is called. I found that I was using the ps command per the below quite often, and simply opted to scriptify it for ease. It's pretty much a lazy man's htop.

ps aux | awk '(NR == 1){print} ((NR > 1) && ($3 > 0)){print} ((NR > 1) && ($4 > 0)){print}'

exit 0
