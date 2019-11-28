#!/bin/bash
CURDIR=$(pwd)
BASEPATH=$(realpath $0)
BASEDIR=$(dirname $(dirname $BASEPATH))
VENDORDIR="$BASEDIR/vendor"
BLINDBIDDIR="$VENDORDIR/dusk-blindbidproof"
BLINDBIDREPO="https://github.com/dusk-network/dusk-blindbidproof.git"

if [ ! -d "$VENDORDIR" ]; then
    echo "Creating vendor dir..."
    mkdir $VENDORDIR
    if [ $? -ne 0 ]; then
        exit $?
    fi
fi

if [ ! -d "$BLINDBIDDIR" ]; then
    echo "Cloning blindbid repository..."
    git clone --depth 1 $BLINDBIDREPO $BLINDBIDDIR
    if [ $? -ne 0 ]; then
        exit $?
    fi
fi

echo "Updating blindbid..."
cd $BLINDBIDDIR
git pull
if [ $? -ne 0 ]; then
    exit $?
fi

cargo build $@
if [ $? -ne 0 ]; then
    exit $?
fi

cd $CURDIR
