# Arch Linux Setup

## Set locale and create new user

```
$ echo LANG=en_US.UTF-8 >> /etc/locale.conf
$ echo HOSTNAME=<hostname> >> /etc/rc.conf
$ ln -s /usr/share/zoneinfo/UTC /etc/localtime
$ adduser <username>
$ groupadd sudo
$ gpasswd -a <username> sudo
```

## Edit /etc/hosts and sudoers

```
# vim /etc/hosts
<ip> sub.host.com <hostname>
# visudo
%sudo ALL=(ALL) NOPASSWD: ALL
```

## Update system

```
$ pacman-key --init
$ pacman-key --populate archlinux
$ pacman -Syu base-devel git nginx tmux zsh
$ chsh # /bin/zsh
$ logout
```

## Edit SSH config/push pub key

```
# vim ~/.ssh/config
Host <hostname>
HostName <ip>
User <username>
```

```
$ scp ~/.ssh/id_rsa.pub <username@<ip>:id_rsa.pub
$ ssh <hostname> # Will ask for PW
$ mkdir -p .ssh
$ chown -R <username> .ssh
$ chmod 700 .ssh
$ cat id_rsa.pub >> .ssh/authorized_keys
$ chmod 600 .ssh/authorized_keys
$ rm id_rsa.pub
$ logout
$ ssh <hostname> # Shouldn't ask for PW
```

## Disable PW/root login restart SSH

```
# sudo vim /etc/ssh/sshd_config (remote)
PasswordAuthentication no
PermitRootLogin no
```

```
$ sudo systemctl ssh restart
```

## Postgresql

```
$ sudo pacman -Syu postgresql
$ sudo mkdir /var/lib/postgres/data
$ sudo chown -c postgres:postgres /var/lib/postgres/data
$ sudo -i -u postgres
$ initdb -D '/var/lib/postgres/data'
$ exit
$ createuser -s -U postgres --interactive # Enter your username as role
$ sudo systemctl enable postgresql
$ sudo systemctl start postgresql
```

## Redis

```
$ sudo pacman -Syu redis
$ sudo systemctl enable redis
$ sudo systemctl start redis
```
