#!/bin/bash

hostname=$(hostname)
ip=$1
central=$2

/usr/share/openvswitch/scripts/ovs-ctl start --system-id=$hostname
/usr/share/openvswitch/scripts/ovn-ctl start_controller

sleep 3

ovs-vsctl set open . external-ids:ovn-bridge=br-int
ovs-vsctl set open . external-ids:ovn-remote=tcp:$central:6642
ovs-vsctl set open . external-ids:ovn-encap-type=geneve
ovs-vsctl set open . external-ids:ovn-encap-ip=$ip

ovs-vsctl --may-exist add-br br-ex
ovs-vsctl br-set-external-id br-ex bridge-id br-ex
ovs-vsctl br-set-external-id br-int bridge-id br-int
ovs-vsctl set open . external-ids:ovn-bridge-mappings=external:br-ex

# Add eth2 to br-ex
ovs-vsctl add-port br-ex eth2
