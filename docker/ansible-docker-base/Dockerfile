FROM centos:7.4.1708
MAINTAINER jerome.petazzoni@docker.com

RUN yum clean all && \
    yum -y install epel-release && \
    yum makecache all && \
    yum -y upgrade glibc nscd ca-certificates && \
    yum -y update && yum -y swap fakesystemd systemd && \
    yum -y install acl sudo strace && \
    sed -i -e 's/^Defaults.*requiretty/Defaults    !requiretty/' -e 's/^%wheel.*ALL$/%wheel    ALL=(ALL)    NOPASSWD: ALL/' /etc/sudoers && \
    yum -y autoremove && \
    yum -y install bzip2 file findutils git gzip iproute nmap-ncat procps-ng sudo tar which unzip xz zip curl bash mc wget nano && \
    yum clean all && rm -rf /var/cache/yum

# Install Docker from Docker Inc. repositories.
RUN curl -sSL https://get.docker.com/ | sh

# https://repo.saltstack.com/#rhel
RUN yum install -y https://repo.saltstack.com/yum/redhat/salt-repo-latest-2.el7.noarch.rpm && \
    yum install -y \
        salt-master \
        salt-minion \
        salt-ssh \
        salt-syndic \
        salt-cloud \
        salt-api && \
    systemctl enable salt-master.service salt-minion.service
EXPOSE 4505-4506

# Install the magic wrapper.
#ADD ./wrapdocker /usr/local/bin/wrapdocker
#RUN chmod +x /usr/local/bin/wrapdocker

#RUN groupmod -g 993 docker
RUN groupadd --gid 1000 user
RUN useradd --uid 1000 --gid 1000 -m --shell /bin/bash user
#RUN usermod -aG docker user

# Define additional metadata for our image.
VOLUME /var/lib/docker
#CMD ["wrapdocker"]
ADD ./Dockerfile /Dockerfile
#CMD ["bash"]
#CMD ["/bin/sh", "-c", "while true; do sleep 10; done"]
#CMD ["/bin/bash"]
#CMD ["/usr/bin/salt-master", "--log-level=info"]
#ENTRYPOINT ["/usr/lib/systemd/systemd", "--switched-root", "--system", "--deserialize", "21"]
ENTRYPOINT ["/usr/lib/systemd/systemd", "--switched-root", "--system"]
