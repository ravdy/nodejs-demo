FROM centos:latest

RUN yum install -y yum-utils \
    device-mapper-persistent-data \
    lvm2

RUN yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo

RUN yum install -y docker-ce docker-ce-cli containerd.io

RUN systemctl enable docker

CMD ["/usr/sbin/init"]

