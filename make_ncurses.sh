#!/bin/bash

# Compiles a C files passed in as arguments.

# Normally I would compile C files generically with make, but because -lncurses has to be the last argument to gcc, I gave up. I'm sure that there is a way to do it, and when I eventually take the time to understand make better, I will create the Makefile that does the below, and deprecate this script.

################################################################################
# Functions
################################################################################

usage ()
{
	cat << EOF

make_ncurses.sh source_1.c [source_2.c ... source_n-1.c source_n.c]

(Where source_x.c is a valid C file.)

EOF
	exit 1
}

compile ()
{
	compiler='gcc'
	compiler_flags='-g -Wall -Wextra'
	linker_flags='-lncurses'
	output="-o $( echo "${1}" | sed 's/\(.*\)\.c/\1/' )"

	eval ${compiler} ${compiler_flags} ${output} ${1} ${linker_flags}
}

################################################################################
# Main
################################################################################

# If no C program files are specified in the argument list.
[ $# -lt 1 ] && usage

# Compile all of the files in the argument list.
x=1
while [ $x -le $# ]
do
	compile ${!x}
	x=$( expr $x + 1 )
done

exit 0
