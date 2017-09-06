#!/bin/sh

source build.info

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
echo VERSION='"'$RELEASE_VERSION'"' > build.info

# git commit
git add build.info
git commit -m "release $RELEASE_VERSION"

# git tag
git tag $RELEASE_VERSION

# Set snapshot version
echo VERSION='"'$FUTURE_VERSION_SNAPSHOT'"' > build.info

# git commit
git add build.info
git commit -m "snapshot $FUTURE_VERSION_SNAPSHOT"
