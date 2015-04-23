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

LABEL run docker run --name engine --rm -p 22:22 -p 443:443 -p 80:80 --cap-add=ALL -v /sys/fs/cgroup:/sys/fs/cgroup -it docker.io/fabiand/centos7-engine

COPY *-answers /root/
#RUN engine-setup --offline --config-append=/root/complete-answers

CMD ["/usr/sbin/init"]
