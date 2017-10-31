# Box

Portable, reliable, reproducable

## Goals

* web development work on a remote machine
* isolated from host system updates

* Tools are all on a linux system and easily set up.
* No GUI apps, only using CLI based apps.

## Setup

On the host machine configure SSH agent forwarding to the remote box.

On the remote box

```
git clone git@github.com:jkenlooper/box.git
make root
```

SSH in as user
```
make user
```

## TODO

... other stuff ...
