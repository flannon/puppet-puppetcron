#!/bin/bash

#export PATH="$PATH:/usr/local/rvm/bin"
export PATH="/usr/local/rvm/rubies/ruby-1.9.3-p551/bin:/usr/local/rvm/gems/ruby-1.9.3-p551/bin:/usr/local/rvm/bin:/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin"

export GEM_HOME=/usr/local/rvm/gems/ruby-1.9.3-p551
export GEM_PATH=/usr/local/rvm/gems/ruby-1.9.3-p551:/usr/local/rvm/gems/ruby-1.9.3-p551@global

source /etc/profile.d/rvm.sh
source /usr/local/rvm/environments/ruby-1.9.3-p551

rvm use 1.9.3-p551

BASEDIR='/etc/puppet'
MANIFEST="$BASEDIR/manifests/site.pp"
MODULEDIR="$BASEDIR/modules/thirdparty"
PUPPETFILE="$BASEDIR/Puppetfile"

if [[ -f $MANIFEST ]]
then
    /usr/bin/puppet apply $MANIFEST
else
    echo "$MANIFEST file not found"
    exit 258
fi

