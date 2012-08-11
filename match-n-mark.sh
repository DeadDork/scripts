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

# Usage:

#	./match-n-mark.sh MATCH_FIELD MATCH_PREFIX SOURCE_MATCH_FILE TARGET_MATCH_FILE

# That is, if you want to mark with the prefix '*' all entries from file B that, in their second field, have a match in file A, then enter:

#	./match-n-mark.sh '$2' '*' A B

# This will output all lines from file B, and those lines that have in the second field a match from file A will be marked with '*' at the start of the output row.

##########BEGIN CODE##########

# Makes sure that all of the variables have been entered.
test -z "${1}" -o -z "${2}" -o -z "${3}" -o -z "${4}" && echo "match-n-mark.sh MATCH_FIELD MATCH_PREFIX SOURCE_MATCH_FILE TARGET_MATCH_FILE" && exit 1

# Match script.
awk '{
	"grep -i -q -F -e \"" '"${1}"' "\" '${3}'; echo $?" | getline match_line;
	close("grep -i -q -F -e \"" '"${1}"' "\" '${3}'; echo $?");
	if (match_line == 0) {
		print "'"${2}"'" $0;
	} else {
		print $0;
	}
}' < ${4}
exit 0
