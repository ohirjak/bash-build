#!/bin/sh

source version.info

mkdir target

cp src/uw.sh target/uw-$VERSION.sh

sed -i '' "s/@@@VERSION@@@/$VERSION/g" target/uw-$VERSION.sh

if [ -d "src/packages" ] ; then
    mkdir -p target/packages-$VERSION

    cp -R src/packages/* target/packages-0.11-SNAPSHOT/
fi
