#!/bin/sh

VERSION_FILE="version.info"

source $VERSION_FILE

echo "Current version: $VERSION"

MAJOR_MINOR=${VERSION%-*}
MAJOR=${MAJOR_MINOR%.*}
MINOR=${MAJOR_MINOR#*.}
IS_SNAPSHOT=${VERSION#*-}

if [ "$IS_SNAPSHOT" != "SNAPSHOT" ] ; then
    echo "Current version is release already."
    exit 1
fi

RELEASE_VERSION=$MAJOR_MINOR

echo "Current release version: $RELEASE_VERSION"

FUTURE_VERSION="$MAJOR.$((MINOR+1))"
FUTURE_VERSION_SNAPSHOT="$FUTURE_VERSION-SNAPSHOT"

echo "Future snapshot version: $FUTURE_VERSION_SNAPSHOT"

echo "Releasing..."

# Set release version
echo VERSION='"'$RELEASE_VERSION'"' > $VERSION_FILE

# git commit
git add $VERSION_FILE
git commit -m "release $RELEASE_VERSION"

# git tag
git tag $RELEASE_VERSION

# make a build
./build.sh

# make a deploy
# copy built file (target/uw-VERSION.sh) to nexus

# Set snapshot version
echo VERSION='"'$FUTURE_VERSION_SNAPSHOT'"' > $VERSION_FILE

# git commit
git add $VERSION_FILE
git commit -m "snapshot $FUTURE_VERSION_SNAPSHOT"
