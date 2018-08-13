FROM centos:7.5.1804
MAINTAINER jerome.petazzoni@docker.com

RUN yum clean all && \
    yum -y install epel-release && \
    yum makecache all && \
    yum -y upgrade glibc nscd ca-certificates && \
    yum -y update && yum -y swap fakesystemd systemd && \
    yum -y install acl sudo strace net-tools hostname && \
    sed -i -e 's/^Defaults.*requiretty/Defaults    !requiretty/' -e 's/^%wheel.*ALL$/%wheel    ALL=(ALL)    NOPASSWD: ALL/' /etc/sudoers && \
    yum -y autoremove && \
    yum -y install bzip2 file findutils git gzip iproute nmap-ncat procps-ng sudo tar which unzip xz zip curl bash mc wget nano && \
    yum clean all && rm -rf /var/cache/yum

# https://repo.saltstack.com/#rhel
RUN yum install -y https://repo.saltstack.com/yum/redhat/salt-repo-latest-2.el7.noarch.rpm && \
    yum install -y \
        salt-master \
        salt-minion \
        salt-ssh \
        salt-syndic \
        salt-cloud \
        salt-api && \
    systemctl enable salt-minion.service
EXPOSE 4505-4506

RUN groupadd --gid 1000 user
RUN useradd --uid 1000 --gid 1000 -m --shell /bin/bash user

#ENTRYPOINT ["/usr/bin/salt-minion", "--log-level=info"]
#ENTRYPOINT ["/usr/lib/systemd/systemd", "--switched-root", "--system", "--deserialize", "21"]
ENTRYPOINT ["/usr/lib/systemd/systemd", "--switched-root", "--system"]
