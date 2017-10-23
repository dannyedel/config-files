#!/bin/bash
NAME="$1"
shift 1
if [ -z "$NAME" ] ; then
	echo "Usage: $0 <hostname> [additional-dig-parameters]"
	echo
	echo "Example: $0 google-public-dns-b.google.com @8.8.8.8"
	exit 1
fi

if [ '.' != "${NAME: -1}" ]; then
	# Append dot to hostname
	NAME="${NAME}."
fi

ERRORS=0
REVERSES=
LONGTEXT=
ADDRESSES="$(dig "$@" +short $NAME A $NAME AAAA)"
if [ -z "$ADDRESSES" ] ; then
    echo "CRIT - Cannot resolve $NAME"
    exit 2
fi
LONGTEXT+="$NAME resolves to:
$ADDRESSES

"
for adr in $ADDRESSES ; do
	REVERSE="$(dig "$@" +short -x "$adr" )"
	if [ -z "$REVERSE" ] ; then
		ERRORS=$(($ERRORS+1))
		LONGTEXT+="Cannot resolve $adr"
		LONGTEXT+=$'\n'
	else
		LONGTEXT+=$'\n'
		LONGTEXT+="$adr:"
		LONGTEXT+=$'\n'
		LONGTEXT+="$REVERSE"
		LONGTEXT+=$'\n'
	fi
	REVERSES+="$REVERSE"
	REVERSES+=$'\n'
done
LONGTEXT+=$'\n'
LONGTEXT+=$'\n'
UNIQUE=$( echo "$REVERSES" | sort -u | xargs echo)
if [ "$NAME" != "$UNIQUE" ] ; then
	LONGTEXT+="The hostname $NAME and reverse DNS "
	LONGTEXT+="names do not match:"
	LONGTEXT+=$'\n'
	LONGTEXT+="$UNIQUE"
	ERRORS=$(($ERRORS+1))
fi

if [ 0 -ne $ERRORS ] ; then
	echo "CRIT - $ERRORS errors in DNS configuration"
	echo "$LONGTEXT"
	exit 2
else
	echo "OK -" $NAME "->" $ADDRESSES "->" $UNIQUE
	echo "$LONGTEXT"
	exit 0
fi
