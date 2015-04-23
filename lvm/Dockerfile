FROM centos:centos7
MAINTAINER "Fabian Deutsch" <fabiand@redhat.com>
ENV container docker

RUN yum -y update && yum clean all
RUN yum install -y lvm2

RUN yum install -y passwd && passwd -d root

LABEL run docker run --name lvm --rm --privileged --cap-add=ALL -it -v /dev:/dev docker.io/fabiand/centos7-lvm

VOLUME ["/lib/modules"]
CMD ["/usr/sbin/init"]
