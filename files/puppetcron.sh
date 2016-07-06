#!/bin/bash

BASEDIR='/Users/stan/Documents/dlib/repos/testy'
MANIFEST="$BASEDIR/manifests/site.pp"
MODULEDIR="$BASEDIR/modules/thirdparty"
PUPPETFILE="$BASEDIR/Puppetfile"
REMOTE='origin'
REVISION='master'
COUNT=0

cd $BASEDIR

# Check the git branch to see if it's 'master', 
# if not checkout master, then check the branch again
while [[ $(git rev-parse --abbrev-ref HEAD) != $REVISION  ]]
do
    echo "COUNT: $COUNT"
    echo $(git rev-parse --abbrev-ref HEAD)
    if [[ $COUNT < 3 ]]
    then
        git checkout master
        let "COUNT++"
        echo "git rev-parse: $(git rev-parse --abbrev-ref HEAD)"
    else
        echo "COUNT: $COUNT"
        echo "git rev-parse: $(git rev-parse --abbrev-ref HEAD)"
        exit 256
    fi

done

# pull upstream
#
git pull $REMOTE $REVISION --no-edit

if [[ ! -d $MODULEDIR ]]
then
    mkdir -p $MODULEDIR
fi

if [[ -f $PUPPETFILE ]] 
then
    r10k puppetfile install --moduledir $MODULEDIR
else 
    echo "$PUPPETFILE does not exist"
    exit 257
fi

if [[ -f $MANIFEST ]]
then
    puppet apply $MANIFEST
else
    echo "$MANIFEST file not found"
    exit 258
fi
