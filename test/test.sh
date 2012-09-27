#!/bin/sh
# Test basic functionality

set -e

proram=$0
TMPDIR=${TMPDIR:-/tmp}
TMPBASE=$TMPDIR/tmp.$$
CURDIR=.

case "$0" in
  */*)
        CURDIR=$(cd "${0%/*}" && pwd)
        ;;
esac

AtExit ()
{
    rm -f "$TMPBASE"*
}

Run ()
{
    echo "$*"
    shift
    eval "$@"
}

trap AtExit 0 1 2 3 15

# #######################################################################

file1="$TMPBASE.empty"
file2="$TMPBASE.data"

: > $file1
echo "test" > $file2

Run "%% TEST basic:" bcrypt "$file1"

Run "%% TEST empty encrypt:" bcrypt "$file2"

echo BUG: Subject: Segementation fault if given bogus decrypt password?
echo BUG: From: https://sourceforge.net/tracker/?func=detail&aid=1457812&group_id=62194&atid=499719
echo BUG: ...Try if applicaple to Cygwin

Run "%% TEST empty decrypt:" bcrypt "$file2.bfe"

# End of file
