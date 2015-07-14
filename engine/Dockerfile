FROM centos:centos7
MAINTAINER "Fabian Deutsch" <fabiand@redhat.com>
ENV container docker
RUN yum -y update && yum clean all

RUN yum install -y http://plain.resources.ovirt.org/pub/yum-repo/ovirt-release35.rpm
RUN yum install --nogpgcheck -y ovirt-engine

RUN yum install -y passwd && passwd -d root

RUN yum install -y openssh-server

EXPOSE 22
EXPOSE 80
EXPOSE 443

# https://github.com/docker/docker/blob/master/docs/sources/userguide/labels-custom-metadata.md
LABEL run docker run --name engine -p 443:443 -p 80:80 --cap-add=ALL -v /sys/fs/cgroup:/sys/fs/cgroup:ro -it docker.io/fabiand/engine
LABEL run-ext-vols docker run --name engine --rm --volumes-from engine-data -p 443:443 -p 80:80 --cap-add=ALL -v /sys/fs/cgroup:/sys/fs/cgroup:ro -it docker.io/fabiand/engine

COPY *-answers /root/

# chaneg hostname at deploy time: http://www.ovirt.org/Changing_Engine_Hostname
#RUN engine-setup --offline --config-append=/root/complete-answers

CMD ["/usr/sbin/init"]
