FROM centos:centos7
MAINTAINER "Fabian Deutsch" <fabiand@redhat.com>
ENV container docker
RUN yum -y update && yum clean all

RUN yum install -y http://plain.resources.ovirt.org/pub/yum-repo/ovirt-release35.rpm
RUN yum install --nogpgcheck -y vdsm vdsm-cli ovirt-engine-cli
RUN vdsm-tool configure --force

RUN yum install -y passwd && passwd -d root

RUN yum install -y openssh-server
RUN yum install -y libvirt-daemon-driver-lxc

EXPOSE 54321
EXPOSE 22

VOLUME ["/dev"]

# From teh cockpit dockerfile
RUN mkdir -p /container && ln -s /host/proc/1 /container/target-namespace
ADD atomic-* /container/
RUN chmod -v +x /container/atomic-*

LABEL RUN docker run -it --name vdsm --rm -p 22:22 -p 54321:54321 --privileged --cap-add=ALL --pid=host -v /:/host IMAGE /container/atomic-run
LABEL run docker run -it --name vdsm --rm -p 22:22 -p 54321:54321 --privileged --cap-add=ALL --pid=host -v /:/host -v /dev/:/dev -v /lib/modules:/lib/modules docker.io/fabiand/centos7-node 
LABEL run-host-net docker run --name vdsm --rm --net=host --pid=host --ipc=host --privileged --cap-add=ALL -it docker.io/fabiand/centos7-node

# https://developerblog.redhat.com/2014/05/05/running-systemd-within-docker-container/
#VOLUME [ "/sys/fs/cgroup", "/dev", "/sys" ]
CMD ["/usr/sbin/init"]
