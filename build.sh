#!/bin/sh

source version.info

mkdir target

cp src/uw.sh target/uw-$VERSION.sh

sed -i '' "s/@@@VERSION@@@/$VERSION/g" target/uw-$VERSION.sh
