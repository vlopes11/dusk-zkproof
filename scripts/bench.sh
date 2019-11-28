#!/bin/bash
CURDIR=$(pwd)
BASEPATH=$(realpath $0)
BASEDIR=$(dirname $(dirname $BASEPATH))
VENDORDIR="$BASEDIR/vendor"
BLINDBIDDIR="$VENDORDIR/dusk-blindbidproof"

echo "Running blindbid..."
$BLINDBIDDIR/target/release/dusk-blindbidproof &
if [ $? -ne 0 ]; then
    exit $?
fi
BLINDBIDPID=$!

go test $@
RESULT=$?

kill -15 $BLINDBIDPID

exit $RESULT
