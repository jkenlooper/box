FROM ubuntu:16.04

LABEL maintainer="Jake Hickenlooper jake@weboftomorrow.com"


# Set the locale
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y locales
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN apt-get update && apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN echo 'root:screencast' | chpasswd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

# Run the initial scripts as root
ADD init-apt-get.sh /var/box/
WORKDIR /var/box/

RUN ./init-apt-get.sh

# Create user login
RUN adduser --disabled-password jake
RUN usermod -aG sudo jake
ADD id_rsa.pub /home/jake/.ssh/authorized_keys
RUN chown jake:jake /home/jake/.ssh
RUN chmod 700 /home/jake/.ssh
RUN chown jake:jake /home/jake/.ssh/authorized_keys
RUN chmod 600 /home/jake/.ssh/authorized_keys
RUN echo 'jake:isgreat' | chpasswd

# install vim
ADD vim.sh vim.patch /var/box/
RUN ./vim.sh

# install tmux
ADD tmux.sh /var/box/
RUN ./tmux.sh

# install nodejs (npm)
ADD nodejs.sh /var/box/
RUN ./nodejs.sh

# Python
ADD python-pip.sh /var/box/
RUN ./python-pip.sh

ADD python-packages.sh /var/box/
RUN ./python-packages.sh

# Run the other scripts as the user
USER jake
WORKDIR /home/jake/
RUN git clone https://github.com/jkenlooper/dotfiles.git
# RUN cd dotfiles && make

EXPOSE 22

# create the mount point
VOLUME /home/jake/projects

USER root

CMD ["/usr/sbin/sshd", "-D"]

# Create a container
# docker run -d --name testbox2 -p 8022:22 -v /Users/jake/projects/ testbox

# ssh in (password is screencast)
# ssh root@localhost -p 8022
