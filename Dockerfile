FROM ubuntu:16.04

LABEL maintainer="Jake Hickenlooper jake@weboftomorrow.com"

# Set the locale (mostly from stackoverflow and a bit hacky)
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y locales
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# Inspired by https://docs.docker.com/engine/examples/running_ssh_service/
RUN apt-get update && apt-get install -y openssh-server
RUN mkdir /var/run/sshd

# Run the initial scripts as root
COPY init-apt-get.sh /var/box/
WORKDIR /var/box/

RUN ./init-apt-get.sh

# Create user login
RUN adduser --disabled-password jake
RUN usermod -aG sudo jake
COPY id_rsa.pub /home/jake/.ssh/authorized_keys
RUN chown jake:jake /home/jake/.ssh
RUN chmod 700 /home/jake/.ssh
RUN chown jake:jake /home/jake/.ssh/authorized_keys
RUN chmod 600 /home/jake/.ssh/authorized_keys
RUN echo 'jake:isgreat' | chpasswd

# install vim
COPY vim.sh vim.patch /var/box/
RUN ./vim.sh

# install tmux
COPY tmux.sh /var/box/
RUN ./tmux.sh

# install nodejs (npm)
COPY nodejs.sh /var/box/
RUN ./nodejs.sh

# Python
COPY python-pip.sh /var/box/
RUN ./python-pip.sh

COPY python-packages.sh /var/box/
RUN ./python-packages.sh

# Docker
## Skipping docker in docker for now
#RUN apt-get update && apt-get --yes install apt-transport-https ca-certificates gnupg2 software-properties-common
#RUN curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg | apt-key add -
#RUN add-apt-repository \
#   "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") \
#   $(lsb_release -cs) \
#   stable"
#
#RUN apt-get update && apt-get --yes install docker-ce
#
## add user to docker group
#RUN gpasswd -a jake docker

CMD ["/usr/sbin/sshd", "-D"]
