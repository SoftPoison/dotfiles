#!/bin/bash

source ~/.config/rdp.conf

function rdp {
    ip=$(virsh -c 'qemu:///system' net-dhcp-leases default | grep -i "$1" | awk '{print $5}' | awk -F/ '{print $1}')
    
    if [ "$ip" == "" ]; then
        return 1
    fi

    wlfreerdp "/u:$USERNAME" "/p:$PASSWORD" "/v:$ip" /dynamic-resolution
}

rdp "$1"
