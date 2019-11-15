FROM centos:8

RUN yum install https://repo.percona.com/yum/percona-release-latest.noarch.rpm -y && yum clean all
RUN percona-release enable-only tools
RUN yum install percona-xtrabackup-24 -y && yum clean all

ENTRYPOINT ["xtrabackup"]
