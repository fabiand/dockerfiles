#
# Make a 1:1 mapping of all the host side NICs matching the NICGLOB pattern into the container given as $1
# Example: map-nics.sh centos eth*
#

set -x

docker-pid() { docker inspect --format="{{.State.Pid}}" $1 ; }

DSTCT=${1}
NICGLOB=${2:-eth*}
DSTPID=$(docker-pid $DSTCT)

for NIC in $(cd /sys/class/net/ ; ls -d1 $NICGLOB)
do
  NN=${NIC}p${DSTPID}
  ip link add $NN link $NIC type macvlan mode passthru
  ip link set netns ${DSTPID} $NN
done

