# Box

Portable, reliable, reproducable

## Goals

* web development work on a linux system
* isolated from host system updates

* Tools are all on a linux system and easily set up.
* No GUI apps, only using CLI based apps.

## Setup

On the host machine configure SSH agent forwarding to the remote box.

If using mac terminal; use the box-input.terminal profile.  Font used is from http://input.fontbureau.com/

* Install [docker](https://www.docker.com) on the host machine. 
* Checkout this repo and cd to the directory.  
* Copy over your public key (id_rsa.pub) to the directory.  This will be added
  to the box as */home/jake/.ssh/authorized_keys*.
* Build the docker image and name it as 'box'.
* Say something cheesy because this is going to take a while at first.

```
docker build -t box . && \
say -v Fred "$USER, your box is ready.  Try not to break it this time, mmm k?" || \
say -v Fred "You broke it! It worked on my machine."
```

Now that the image has been built; create a container.  Use `-d` to start in
detached mode, `--name` to set a name for the container instead of an auto
generated one.  The port 8022 will be set on the host machine to map to port 22
on the box.  Set a volume to share a directory (projects) on the host machine.
This is just the way I like to run the docker container; adjust as needed.

```
docker run -d --name box-1 -p 8022:22 -v $HOME/projects/:/home/jake/projects box:latest
```

SSH in with the port of 8022 as user.

```
ssh -p 8022 jake@localhost
```

While logged in the box; run the initial dotfiles setup.  This part hasn't been
fully dockerized.  Follow the rest of the directions which requires exiting and
logging back in a couple of times.  There is probably a better way of doing
that, oh well.

```
cd dotfiles
make
```

That's it.  If everything went right, there should be a running docker
container which can be `ssh`ed into just like a remote machine.  But, unlike
a remote machine, directories on the host machine can easily be shared.  Also,
the ping time is super great!

## Cheat sheet of docker commands related to this

List the images.

```
docker image ls
```

List all the containers.

```
docker ps -a
```

Starting and stopping using the container name.

```
docker start box-1
docker stop box-1
```

Or, just refer to the [docker reference documentation](https://docs.docker.com/reference/)
