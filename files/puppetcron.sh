#!/bin/bash

BASEDIR='/etc/puppet'
MANIFEST="$BASEDIR/manifests/site.pp"
MODULEDIR="$BASEDIR/modules/thirdparty"
PUPPETFILE="$BASEDIR/Puppetfile"
COUNT=0


cd $BASEDIR

if [[ ! -d $MODULEDIR ]]
then
    mkdir -p $MODULEDIR
fi

if [[ -f $PUPPETFILE ]] 
then
    r10k puppetfile install 
else 
    echo "$PUPPETFILE file not found    "
    exit 257
fi

if [[ -f $MANIFEST ]]
then
    /usr/bin/puppet apply $MANIFEST
else
    echo "$MANIFEST file not found"
    exit 258
fi
