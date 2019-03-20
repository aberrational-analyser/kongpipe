#!/usr/bin/env bash
# fake travis
#
# setup the prerequisites that are normally handled by travis.ci so that we
# can run tests locally with a debugger...
#
echo ---------------------------------------
echo "clone the kong repo"
echo ---------------------------------------
sudo yum install git -y
git clone https://github.com/Kong/kong.git
cd kong

echo --------------------------------------- 
echo "install docker to support Cassandra"
echo ---------------------------------------
sudo yum install -y yum-utils device-mapper-persistent-data lvm2
sudo yum-config-manager y\
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo

sudo yum install -y docker-ce docker-ce-cli containerd.io
sudo groupadd docker
sudo usermod -aG docker vagrant
sudo systemctl start docker
docker run hello-world

echo ---------------------------------------
echo "install gcc and patch"
echo should this be build-essential
echo will that include m4
echo ---------------------------------------
sudo yum group install -y "Development Tools"
sudo yum install -y m4

echo ---------------------------------------
echo "install wget"
echo ---------------------------------------
sudo yum install -y wget

echo ---------------------------------------
echo "install OpenResty dependencies"
echo ---------------------------------------
sudo yum install -y pcre pcre-devel zlib zlib-devel unzip

echo ---------------------------------------
echo Set travis.ci environment vars
echo ---------------------------------------
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
export JOBS=2

echo ----------------------------------------
echo
echo   sourcing kong/.ci/setup_env.sh
echo
echo ---------------------------------------
source .ci/setup_env.sh

echo ---------------------------------------
echo
echo   completed kong/.ci/setup_env.sh
echo
echo ---------------------------------------

# after setup_env.sh completes, we should write the exports out
# to some .rc file so that we don't loose them with the shell session
# ends
RC_FILE=~/.bashrc
echo "export PATH=$OPENSSL_INSTALL/bin:$OPENRESTY_INSTALL/nginx/sbin:$OPENRESTY_INSTALL/bin:$LUAROCKS_INSTALL/bin:$CPAN_DOWNLOAD:$PATH" >> $RC_FILE
echo "export LD_LIBRARY_PATH=$OPENSSL_INSTALL/lib:$LD_LIBRARY_PATH # for openssl's CLI invoked in the test suite" >> $RC_FILE

#install 
echo ---------------------------------------
make dev

luacheck -q .
