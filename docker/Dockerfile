FROM centos:7.4.1708
#FROM ubuntu:14.04
MAINTAINER jerome.petazzoni@docker.com

# Let's start with some basic stuff.
#RUN apt-get update -qq && apt-get install -qqy \
#    apt-transport-https \
#    ca-certificates \
#    curl \
#    lxc \
#    iptables
RUN yum install -y \
    sudo \
    curl \
    bash \
    git \
    mc \
    wget \
    nano
#    lxc \
#    iptables

# for systemd
# https://github.com/trinitronx/ansible-docker-base/blob/master/stable-centos7/Dockerfile
RUN yum clean all && \
    yum -y install epel-release && \
    yum makecache all && \
    yum -y upgrade glibc nscd ca-certificates && \
    yum -y update && yum -y swap fakesystemd systemd && \
    yum -y install acl sudo && \
    sed -i -e 's/^Defaults.*requiretty/Defaults    !requiretty/' -e 's/^%wheel.*ALL$/%wheel    ALL=(ALL)    NOPASSWD: ALL/' /etc/sudoers

# Install Docker from Docker Inc. repositories.
RUN curl -sSL https://get.docker.com/ | sh

# https://repo.saltstack.com/#rhel
RUN yum install -y https://repo.saltstack.com/yum/redhat/salt-repo-latest-2.el7.noarch.rpm
RUN yum install -y \
        salt-master \
        salt-minion \
        salt-ssh \
        salt-syndic \
        salt-cloud \
        salt-api

RUN yum -y autoremove && \
    yum clean all && rm -rf /var/cache/yum

# Install the magic wrapper.
ADD ./wrapdocker /usr/local/bin/wrapdocker
RUN chmod +x /usr/local/bin/wrapdocker

RUN groupmod -g 993 docker
RUN groupadd --gid 1000 user
RUN useradd --uid 1000 --gid 1000 -m --shell /bin/bash user
RUN usermod -aG docker user

# Define additional metadata for our image.
VOLUME /var/lib/docker
#CMD ["wrapdocker"]
ADD ./Dockerfile /Dockerfile
#CMD ["bash"]
#CMD ["/bin/sh", "-c", "while true; do sleep 10; done"]
CMD ["/bin/bash"]
