#!/usr/bin/env bash
# fake travis
#
# setup the prerequisites that are normally handled by travis.ci so that we
# can run tests locally with a debugger...
#

#---------
# pull down the repo and unzip.
#
sudo yum install git -y
git clone https://github.com/Kong/kong.git
cd kong

#----------------------
# install docker to support Cassandra:
#----------------------

sudo yum install -y yum-utils device-mapper-persistent-data lvm2
sudo yum-config-manager y\
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo

sudo yum install -y docker-ce docker-ce-cli containerd.io
sudo systemctl start docker

#install gcc
sudo yum install -y gcc
sudo yum install -y patch

#install wget
sudo yum install -y wget

# install nginx with PCRE library I think....



#---------
# Setup the environment vars normally provided by kong's travis.yml
# We are selecting the cell from the test matrix that runs against cassandra 
# 3.9...
#--------
export LUAROCKS=3.0.4
export OPENSSL=1.1.1b
export OPENRESTY_BASE=1.13.6.2
export OPENRESTY_LATEST=1.13.6.2
export OPENRESTY=$OPENRESTY_BASE
export DOWNLOAD_CACHE=~/kong-download-cache
export INSTALL_CACHE=~/kong-install-cache
# export KONG_TEST_PG_DATABASE=travis
# export KONG_TEST_PG_USER=postgres
export KONG_TEST_DATABASE=cassandra
export CASSANDRA=3.9
export TEST_SUITE=integration
#export TEST_SUITE=plugins
#export TEST_SUITE=pdk

echo --------------------
echo
echo   starting setup_env.sh
echo
echo --------------------

source .ci/setup_env.sh

#install make dev :(

# source .ci/setup_env.sh

# luacheck -q .
# bin/busted -v -o gtest spec/01-unit

