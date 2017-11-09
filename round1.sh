#!/bin/bash

# ROUND 1: Try making a snap out of a bare bones root

if [[ "$EUID" != "0" ]]; then
    echo "I .. AM... not g.. ROOT"
    exit 1
fi

ROOTDIR="`pwd`/ROOT"

# Bit of house keeping to ensure package managers don't jank up the rootfs
function init_root()
{
    if [[ ! -d "$ROOTDIR" ]]; then
        mkdir $ROOTDIR
    fi

    mkdir -p $ROOTDIR/run/lock
    mkdir -p $ROOTDIR/var
    ln -s ../run/lock $ROOTDIR/var/lock
    ln -s ../run $ROOTDIR/var/run
}

# Desparately attempt to install a package
function install_package()
{
    eopkg install -y -D "$ROOTDIR" --ignore-comar $*
}

# Similar to install_package, just uses -c notation.
function install_component()
{
    install_package -c $*
}

# Ugly, add a repo to the directory
function add_repo()
{
    eopkg add-repo -D "$ROOTDIR" "Solus" $1
}

function configure_pending()
{
    echo "NOT YET IMPLEMENTED :O"
}


# Bring up the root tree
init_root

# Let's get a repo going.
add_repo "https://packages.solus-project.com/unstable/eopkg-index.xml.xz"
