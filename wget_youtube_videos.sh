#!/bin/bash

#######################################################################################
#                                                                                     #
#     Copyright (C) Nimrod Omer.                                                      #
#                                                                                     #
#     To contact me, visit my github page at <https://www.github.com/DeadDork>.       #
#                                                                                     #
#     This script was inspired by <http://calomel.org/youtube_wget.html>.             #
#                                                                                     #
#     Given that the calomel Perl script is licensed with a Creative Commons CC       #
#     BY-SA 3.0 license <http://creativecommons.org/licenses/by-sa/3.0/us/>, this     #
#     script is similarly licensed.                                                   #
#                                                                                     #
#######################################################################################

# This script downloads youtube videos via wget.

# Exits if the number of arguments is wrong.
[ $# -lt 1 -o $# -gt 2 ] && clear && echo -e 'The command must be formatted as follows:\n\n\t./wget_youtube_videos.sh URI [PREFIX]\n\nFor example:\n\n\t./wget_youtube_videos.sh http://www.youtube.com/watch?v=ugw3ARV4X9g\n\nOr:\n\n\t./wget_youtube_videos.sh http://www.youtube.com/watch?v=ugw3ARV4X9g ~/Downloads/youtube/crystal_castles/\n' && exit 1

# Temporary file for the youtube HTML.
HTML_file="/tmp/$(echo "${1}" | sed -r 's/.*watch\?v=([[:alnum:]]*).*/\1/')"

# Downloads the HTML code from the URI.
wget -Ncq -e "convert-links=off" --keep-session-cookies --save-cookies /dev/null --no-check-certificate "${1}" -O "${HTML_file}"

# Sets the URI of the youtube video.
download_address="$(sed -r -e 's/(url_encoded_fmt_stream_map|fallback_host)/\n\1\n/g' "${HTML_file}" | grep -A 1 -m 1 -i 'url_encoded_fmt_stream_map' | sed -n '2 p' | sed -e 's/\\u0026/&/g' -e 's/=url%3D//' -e 's/%25/%/g' -e 's/%3A/:/g' -e 's/%2F/\//g' -e 's/%3F/?/g' -e 's/%3D/=/g' -e 's/%252C/%2C/g' -e 's/%26/?/g' -e 's/%253A/:/g')"

# Sets the title of the youtube video.
title="${2}$(awk '{printf "%s", $0}' "${HTML_file}" | grep -o '<title>.*<\/title>' | sed -r -e 's/(<title>[[:space:]]*|[[:space:]]*<\/title>)//g' -e 's/[^[:alnum:]]+/_/g' -e 's/_*YouTube//').webm"

# Downloads the video.
wget -Ncq -e "convert-links=off" --load-cookies /dev/null --tries=50 --timeout=45 --no-check-certificate "${download_address}" -O "${title}"

exit 0
