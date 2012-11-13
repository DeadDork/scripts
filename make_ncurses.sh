#!/bin/bash

# Compiles C files passed in as arguments.

# Normally I would compile C files generically with make. However, -lncurses has to be the last argument to gcc when compiling programs that use ncurses. This isn't easy to do in make, so I gave up on doing it this way for the time being. When I eventually take the time to understand make better, I will definitely create a Makefile that does the below, and deprecate this script.

# Do note that this script doesn't do anything "fancy" like making sure that the arguments passed in are even C files, etc.

################################################################################
# Functions
################################################################################

usage ()
{
	cat << EOF

make_ncurses.sh source_1.c [header_1.h source_2.c ... source_n-1.c header_n-1.h source_n.c header_n.h]

(Where any source_x.[c|h] file must be a valid C source file.)

N.B. source_1 will be the name of the binary output. This gives you the flexibility to compile one binary with a lot of source files, or a binary from a single source file if you're writing a quick and dirty single test program However, it will not allow you to compile several binaries at the same time.

EOF
	exit 1
}

compile ()
{
	compiler='gcc'
	compiler_flags='-g -Wall -Wextra'
	linker_flags='-lncurses'
	output="-o $( echo $1 | sed 's/\(.*\)\.c/\1/' )"

	eval ${compiler} ${compiler_flags} ${output} "${@}" ${linker_flags}
}

################################################################################
# Main
################################################################################

# Checks to make sure that there is at least one argument.
[ $# -lt 1 ] && usage

# Compile all of the files in the argument list.
compile "${@}"

exit 0
