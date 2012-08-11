#!/bin/bash

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

# Eases connecting to established Sybase or Microsoft SQL Server DBMS servers.

# Variables
# This points to the sqsh connection settings file.
connections_file="${HOME}/.config/scripts/sqsh_connections.settings"

# Functions
# This function creates a new connection.
new_connection () {
	# Get the interface name.
	clear
	while [ -z "${interface}" ]; do
		read -p 'Interface PATH & NAME (e.g. "/home/work/local/etc/freetds.conf")? ' interface
	done

	# Get the server name.
	clear
	PS3='Server name? '
	IFS="	"
	select server in $(awk '/^\[[^\]]+\]/{printf "%s\t", gensub(/^\[([^\]]+)\].*/, "\\1", 1)}' < "${interface}"); do 
		grep -q '^\['"${server}"'\]' "${interface}"
		if [ $? -eq 0 ]; then
			break
		else
			echo 'Bad SERVER selection. Try again.'
		fi
	done
	unset IFS

	# Get the user name. For this, you first have to get the domain, if one is exists.
	clear
	read -p 'DOMAIN name (e.g. "domain" from "domain\tester". N.B. if there is no domain name, leave this empty)? ' domain
	read -p 'USER name (e.g "tester" from "domain\tester")? ' user
	# "user_file" needs four escapes in order to create a proper backslash for the settings file. However, it only needs two escapes when it is part of a new connection.
	test ! -z $domain && user_file="${domain}\\\\${user}" && user="${domain}\\${user}"

	# Adds the connection to the connections file.
	echo -e "${interface} ${server} ${user_file}" >> "${connections_file}"
}

# Makes sure that a scripts directory exists.
test ! -d ~/.config/scripts/ && mkdir -p ~/.config/scripts

# Makes sure that a connections file exists & that it is not empty.
if [ ! -e "${connections_file}" ]; then
	touch "${connections_file}"
	# Create a new connection because none exist yet.
	new_connection
else
	# Select whether to create a new connection setting or use an established one.
	PS3='Choose to create a new connection setting or use an established one. '
	select setting in 'New connection' 'Established connection'; do
		case "${setting}" in
			# If a NEW CONNECTION is desired, then the necessary connection settings are collected.
			'New connection' )
				new_connection
				break
				;;
	
			# If an ESTABLISHED CONNECTION is desired, then the necessary connection settings are retrieved from the settings file.
			'Established connection' )
				clear
				PS3='Choose which established connection to use. '
				IFS='	'
				select connection in $(awk '{printf "%s\t", $0}' < "${connections_file}"); do
					grep -q -F "${connection}" "${connections_file}"
					if [ $? -eq 0 ]; then
						interface="$(echo "${connection}" | awk '{printf "%s", $1}')"
						server="$(echo "${connection}" | awk '{printf "%s", $2}')"
						user="$(echo "${connection}" | awk '{printf "%s", $3}')"
						break
					else
						echo 'Bad CONNECTION selection. Try again.'
					fi
				done
				unset IFS
				break
				;;

			* )
				echo 'Bad SETTING selection. Try again.'
				;;
		esac
	done
fi

# Opens sqsh using the selected connection settings.
clear
sqsh -I "${interface}" -S "${server}" -U "${user}"

exit 0
