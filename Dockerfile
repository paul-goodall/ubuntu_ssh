FROM       ubuntu:18.04
MAINTAINER Paul Goodall "https://github.com/paul-goodall"

RUN apt-get update
RUN apt-get install -y openssh-server

RUN mkdir /var/run/sshd

# Set initial password for root to 'root':
RUN echo 'root:root' | chpasswd

RUN sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config

RUN mkdir /root/.ssh

RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 22

CMD    ["/usr/sbin/sshd", "-D"]