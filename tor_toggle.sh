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

# A quickie script to toggle Tor.

change_row=$(awk '/^ *#? *forward-socks5 *\/ *127.0.0.1:9050 +\./{print NR}' </etc/privoxy/config)

clear
if [[ "$(awk 'NR=='$change_row /etc/privoxy/config)" =~ ^\ *\# ]]; then
	tor_status='OFF'
else
	tor_status='ON'
fi
echo "Tor is $tor_status"
PS3='Toggle Tor?'
select toggle in 'Yes' 'No'; do
	case $toggle in
		'Yes' )
			if [ "${tor_status}" == 'OFF' ]; then
				sudo bash -c "sed -i \"$change_row \"'s/^ *#\(.*\)/\1/' /etc/privoxy/config"
				echo "Tor toggled ON."
			elif [ "${tor_status}" == 'ON' ]; then
				sudo bash -c "sed -i \"$change_row \"'s/\(.*\)/#\1/' /etc/privoxy/config"
				echo "Tor toggled OFF."
			fi
			break
			;;
		'No' )
			break
			;;
		* )
			echo 'Bad entry. Try again.'
			;;
	esac
done

exit 0
