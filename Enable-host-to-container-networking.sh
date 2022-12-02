#!/usr/bin/env bash

#Change these variables!
NIC_NAME="eth0"
DOCKER_ROUTING_INTERFACE_NAME="dockerrouteif"
DOCKERNETWORK_IP_ADDRESS="192.168.0.249/32"
DOCKERNETWORK_IP_RANGE="192.168.0.64/26"
SLEEP_TIME="15" #seconds

sleep ${SLEEP_TIME} #Do not rush things if executing during boot. This line is not mandatory and can be removed.


ip link add ${DOCKER_ROUTING_INTERFACE_NAME} link ${NIC_NAME} type macvlan mode bridge ; ip addr add ${DOCKERNETWORK_IP_ADDRESS} dev ${DOCKER_ROUTING_INTERFACE_NAME} ; ip link set ${DOCKER_ROUTING_INTERFACE_NAME} up
ip route add ${DOCKERNETWORK_IP_RANGE} dev ${DOCKER_ROUTING_INTERFACE_NAME}
