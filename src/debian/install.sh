#!/bin/bash

# Based on script from Debian manpages package

set -e

if [ "$#" != 1 ]; then
	echo "Usage: $0 /path/to/install/dir" 1>&2
	exit 1
fi	
	
MANROOT=$1
symlinks=""

for dir in man[1-8n] debian/man[1-8]; do
	echo "-- Processing directory $dir"
	sect=${dir#debian/}
	[ -d $MANROOT/$sect ] || mkdir -p -m 755 $MANROOT/$sect

	for page in $dir/*.[1-8n]*; do
		page=${page##*/}
		echo -n "$page"
		Y=`head -n 1 "$dir/$page"`
		case "$Y" in
		.so*)
			echo -n "(symlinked)"
			symlinks="$symlinks $sect/$page"
			Y="${Y#.so }"
			if [ "${Y%/*}" = "$sect" ]; then
				Y=${Y#*/}
			else if [ "${Y%/*}" = "${Y#*/}" ]; then
				Y=$Y
			else
				Y=../$Y
			fi
			fi
			ln -sf "$Y" "$MANROOT/$sect/$page"
			;;
		*)
			install -p -m 644 "$dir/$page" "$MANROOT/$sect"
			;;
		esac
		echo -n " "
	done
        echo
done

echo "-- Moving and removing manpages:"
while read manpg old_s new_s; do
	# skip comments and empty lines	
	if [ \( "X${manpg}" != "X" \) -a \( "X${manpg:0:1}" != "X#" \) ] ; then

		old_f="$MANROOT/man${old_s:0:1}/$manpg.$old_s"
		new_f="$MANROOT/man${new_s:0:1}/$manpg.$new_s"

		echo -n "$manpg.$old_s"
		if [ -e "$old_f" ] ; then
			if [ "X$new_s" = "X" ] ; then 
				echo -n "(removed)"
			else
				if [ "x$old_f" = "x$new_f" ]; then
					mv "$old_f" "$old_f.tmp"
					old_f="$old_f.tmp"
				fi

				perl -pe '$i+= s;^(\.TH\s+\S+\s+)\S+(\s+.*);${1}'"${new_s}"'${2};gi unless $i>0' \
					< "$old_f" > "$new_f"
	
				touch -r "$old_f" "$new_f"
	
				if [ "x$old_s" = "x$new_s" ]; then
					echo -n "(corrected .TH line)"
				else
					echo -n "(moved to section $new_s)"
				fi
			fi
	
			rm -f "$old_f"
				
		else
			echo -n "(not found!)"
		fi
		echo -n " "
	fi
done < debian/move.list
echo

echo "-- Removing dangling symlinks:"
for i in $symlinks; do
	i="$MANROOT/$i"
	if [ -L "$i" -a ! -e "$i" ]; then
		echo -n "${i##*/}(removed) "
		rm -f "$i"
	fi
done
echo
