#
# Move all host side NICs matching the NICGLOB pattern OR unconnected ones into the container given as $1
# Example: move-nics.sh centos # Default, same as the one below
# Example: move-nics.sh centos claim-unconnected
# Example: move-nics.sh centos ens*
#

set -x

docker-pid() { docker inspect --format="{{.State.Pid}}" $1 ; }

DSTCT=${1}
NICGLOB=${2:-claim-unconnected}
DSTPID=$(docker-pid $DSTCT)

if [[ "$NICGLOB" = "claim-unconnected" ]]; then
  UNCONNECTEDETH=$(nmcli -t -f device,type,connection device | egrep "ethernet:--$" | cut -d ":" -f1)
  NICS=$UNCONNECTEDETH
else
  NICS=$(cd /sys/class/net/ ; ls -d1 $NICGLOB)
fi

for NIC in $NICS
do
  echo "Moving '$NIC' to netns of '$DSTPID'"
  ip link set netns ${DSTPID} $NIC
done

