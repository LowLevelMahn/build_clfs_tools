#! /bin/sh
srcdir=/home/bert/build_qemu_images/clfs_cross_tools/system/alpha/sources/step_13_cloog-0.18.2-build/../cloog-0.18.2
PACKAGE=cloog
VERSION=0.18.2

if test -f $srcdir/.git/HEAD; then
    GIT_REPO="$srcdir/.git"
    GIT_HEAD_ID=`GIT_DIR=$GIT_REPO git describe`
elif test -f $srcdir/CLOOG_HEAD; then
    GIT_HEAD_ID=`cat $srcdir/CLOOG_HEAD`
else
    GIT_HEAD_ID="$PACKAGE-$VERSION-UNKNOWN"
fi

echo $GIT_HEAD_ID | sed -e 's/cloog-//'
