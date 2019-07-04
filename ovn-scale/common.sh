#!/bin/bash

source /vagrant/utils/common-functions

# Allow ssh public key authentication for root
mkdir -p /root/.ssh/
cp /home/vagrant/.ssh/authorized_keys /root/.ssh/authorized_keys

# Allow lots and lots of pids (in case we want to use lots of iperf instances)
echo 1000000 > /proc/sys/kernel/pid_max

install_ovs

yum install psmisc -y

# Install EPEL repo
yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm

# Install iperf for traffic tests
yum install iperf -y