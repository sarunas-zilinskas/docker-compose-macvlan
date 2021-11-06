#!/usr/bin/env bash

#Change these variables!
NIC_NAME="eth0"
DOCKERNETWORK_NAME="dockervlan"
DOCKERNETWORK_IP_ADDRESS="192.168.0.249/32"
DOCKERNETWORK_IP_RANGE="192.168.0.64/26"

sleep 15 #Do not rush things if executing during boot. This line is not mandatory and can be removed.


ip link add ${DOCKERNETWORK_NAME} link ${NIC_NAME}type macvlan mode bridge ; ip addr add ${DOCKERNETWORK_IP_ADDRESS} dev ${DOCKERNETWORK_NAME} ; ip link set ${DOCKERNETWORK_NAME} up
ip route add ${DOCKERNETWORK_IP_RANGE} dev ${DOCKERNETWORK_NAME}
