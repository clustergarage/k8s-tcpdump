#!/bin/bash

if [ "$1" = "" ]; then
  echo "Usage: $0 <pod label selector>"
  exit
fi

# find pod container name
containers=($(kubectl get pods \
  --all-namespaces \
  -l $1 \
  -o jsonpath="{.items[*].status.containerStatuses[*].containerID}"))

for ctr in ${containers[@]}; do
  c=($(echo $ctr | awk -F/ '{print $3}'))
  # find pod unique network interface index inside its container
  ifx=$(docker exec $c /bin/sh -c 'cat /sys/class/net/eth0/iflink')
  # locate that interface on the worker node (virtual interface is veth*)
  # alternatively: `iplink | grep ^$ifx
  for i in /sys/class/net/veth*/ifindex; do
    vethif=$(grep -l $ifx $i)
    if [[ ! -z "$vethif" ]]; then
      vif=($(echo $vethif | awk -F/ '{print $5}'))
      echo "Performing 'tcpdump' on $vif"
      echo " * container: $c"
      echo " * net interface idx: $ifx"
      echo " * veth interface: $vethif"
      # perform network packet captures on that virt interface
      tcpdump -i $vif -nnvvKXXSs 2048
      # -w capture.pcap &
    fi
  done
done
