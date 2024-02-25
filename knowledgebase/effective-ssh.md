---
layout: content_wrapper
title: Effective SSH
author: Larry Reid
tags: ssh
---

## Introduction

This is a really quick guide to using SSH without passwords ("password-less login"):

* Using the SSH client on your computer to access a terminal sesssion on a server.
* Setting up and using the SSH server on one of your servers.
* Remote deploys with Capistrano -- may be applicable to other remote deploy tools.
* Setting up and using a bastion or jump host.

This guide is for people who:

* Are somewhat computer literate, but haven't used SSH before, or only with a password to log in to other computers.
* Use SSH with certificates ("password-less login"), but are somewhat mystified how it works.
* Want to try more advanced uses of SSH, like remote deploys (Capistrano, in the Rails world), or bastion/jump servers.
* Think they know SSH, but dammit, why isn't it working today? By going through the steps in this guide, you may find the one step that you missed.

I'm not a security expert, but I've read enough that I'm confident my personal use of SSH that I describe here is pretty secure. If you're a profitable business or a government, always defer to your security experts in the use of any software.

## Using the Client from Your Computer

The `ssh` client lets you communicate with other computers. Often it's to open a terminal session on another computer, but it can do more than that. And it can do so without a lot of fuss: If you're known to the other computer (you have a login account), you can use `ssh` and your password to securely connect and communicate with the other computer.

Password-less login with SSH is built around the idea of key pairs. One key of the pair is private, and you must absolutely keep it on the system the key pair was generated on. The other key is the public key. You can show it to the world, and copy it anywhere you want. The magic of SSH is that you can communicate from the cmoputer with the private key to any computer with the public key, without anyone being able to read your communication. And if you have your private key, and the computer you want to talk to has your public key, you can connect securely without any passwords.

Your preference should be to generate one key pair per computer that you use. So if you have a desktop and a laptop, you would generate a key pair on each of them. As of late 2023-early 2024, ED25519 is the preferred type of key. A few years ago, support for ED25519 wasn't widespread, so you may read people on the internet suggesting other key types, but things have improved. Use ED25519. And use the default name for the keys, or you might have some grief down the line:

```bash
ssh-keygen -t ed25519
```

When asked for a passphrase, just hit `Enter` (or enter a passphrase, if you're confident you will remember it).

This will create files called `~/.ssh/id_ed25519` and `~/.ssh/id_ed25519.pub`. `~/.ssh/id_ed25519.pub` is the public key.

At this point it's worth checking the premissions on the files you just created:

```bash
ls -ld .ssh # =>
drwx------ 2 you  you  4096 Feb 16 18:25 .ssh
ls -lR .ssh # =>
-rw------- 1 you  you    399 Feb 16 18:25 id_ed25519
-rw-r--r-- 1 you  you     95 Feb 16 18:25 id_ed25519.pub
```

The directory _must_ be `drwx------` (readable, writable, and searchable only by you), and the private key(s) _must_ be `-rw-------` (readable and writable only by you), and they all _must_ be owned by you. SSH will refuse to connect if your private key can be seen or changed by anyone else. `ssh-keygen` should have set everything up correctly, but it doesn't hurt to check, especially if `ssh` isn't working for you.

Now you have to put the public key on the server you want to communicate with. Curiously, this requires that you be able to log in to the server somehow. If you can log in to the server where you want to copy your public key through another means (usually with a password), use one of the methods described in the next two sections. (If your user name on the remote server is the same as your username on your laptop or desktop, you can omit the `server-username@` in the following examples.)

### A Public Respository for your Public Key

If you have a public place where you can store your public key, this first way is a nice option. A "public place" means someplace on the internet accessible via HTTPS. GitHub has a place where you can store public keys that's very convenient for this purpose. (If you don't have a public place to store your public key, skip to the next section.)

If you're using GitHub, [put your public key on GitHub](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account). Then log in to the server, set up the `.ssh` directory if it's not there, and copy the keys from GitHub (Note: be very careful to type two `>` on the line that starts with `curl`):

```bash
ssh server-username@server
ls -ld ~/.ssh
mkdir ~/.ssh && chmod 700 ~/.ssh # If the directory didn't exist.
cp -a ~/.ssh/authorized_keys ~/.ssh/authorized_keys.old # A backup, in case something goes wrong.
curl https://github.com/<your GitHub user name>.keys >> .ssh/authorized_keys
chmod 611 .ssh/authorized_keys
```

### Copying the Key Directly to the Server

If you can log into your account on the server through another means (usually with a password), you can put your public key on the other computer with `ssh-copy-id`:

```bash
ssh-copy-id server-username@server
```

This copies _all_ the public keys from your `~/.ssh` directory to the server.

### Confirm it Worked

Confirm you can log in to the VM from your computer without a password. To check:

```bash
ssh server-username@server
```

If the above worked, disable logins with password for your account. For this step, it's best to leave yourself logged in to the server in one window, log in to the server in another window, and type:

```bash
sudo passwd -l server-username
```

Depending on the operating system of your server, you may not have the `sudo` command, or you may not need it.

Now, log out and try logging back in. If you get in without being asked for a password. everything is good. If you can't log in, with or without a password, go to the window where you left yourself logged in, and type:

```bash
sudo passwd -u server-username
```

This re-enables password login for the account, while you figure out what went wrong in setting up the key files.

### Copying Keys to a Server Account Without Access

Both of the methods above require you to be able to log in to the server with the account to which you want to copy the keys. But often, you can't. If that's the case, you can still set up password-less login for your account, but you, or someone else, has to have a way to log in to the server, to an account with super-user privileges, `sudo` or otherwise. This is also the approach to take if _you_ have access to the server, and you want to give someone else password-less login.

This is where having the user's public key in a public place makes things a lot easier. Basically, we follow the instructions in [A Public Respository for your Public Key](#a-public-respository-for-your-public-key), with a few tweaks to use the right username in the right place.

The approach is to log in as the privileged user, and switch to the target user, and follow the same steps above. So read and type the following carefully:

```bash
ssh server-superusername@server
sudo -iu server-username
# The following are the steps from above:
ls -ld ~/.ssh
mkdir ~/.ssh && chmod 700 ~/.ssh # If the directory didn't exist.
cp -a ~/.ssh/authorized_keys ~/.ssh/authorized_keys.old # A backup, in case something goes wrong.
curl https://github.com/<your GitHub user name>.keys >> .ssh/authorized_keys
chmod 611 .ssh/authorized_keys
exit
```

If the public key isn't stored in a public place, then it's kind of up to you to figure out how you're going to get the key onto the server. One way is to copy the public key to somewhere on the server using `rsync`, then follow steps very similar to those above. On the computer that has the public key, type (make sure to type that colon `:` at the end.):

```bash
sudo rsync path_to_public_key_file server-superusername@server:
```

Then, log in as the privileged account, switch to the target user, and follow the same steps as above. But instead of copying the keys from GitHub (or your public place), copy from the temporary file:

```bash
ssh server-superusername@server
sudo -iu server-username
# The following are the steps from above:
ls -ld ~/.ssh
mkdir ~/.ssh && chmod 700 ~/.ssh # If the directory didn't exist.
cp -a ~/.ssh/authorized_keys ~/.ssh/authorized_keys.old # A backup, in case something goes wrong.
cat ~server-superuser/public_key_file_name >> $SERVER_USER_HOME/.ssh/authorized_keys
chmod 611 .ssh/authorized_keys
exit
rm ~/public_key_file_name
```

Instead of `curl`, we just `cat` the key(s) onto the end of the `authorized_keys`, and then we remove the file we rsync'd over to begin with.

## Setting up a Server as an SSH Server

### The Easy Way

If you're setting up an Ubuntu server, version 22.04 or later, you can set up password-less SSH access during the set-up process. But first you need to have stored your public keys on GitHub. Just follow the prompts during the installation process, and you'll have password-less access for one user with sudo privileges.

I suspect that you can do something similar with other Linux distributions, but I don't have any experience with them. If not, the steps in the next section should get you started.

### The Harder Way AKA For an Existing Server

If the server doesn't have an SSH server installed, install it. (This isn't likely. How are you even logging into it if it doesn't have an SSH server installed?)

Next, make sure you can log in without a password, using one of the methods [above](#using-the-client-from-your-computer) to set up passwordless login for at least one user.

Finally, disable password logins for everyone by editing the SSH server daemon's configuration file:

```bash
sudo cp -a /etc/ssh/sshd_config /etc/ssh/sshd_config.old # In case something goes wrong
sudo vi /etc/ssh/sshd_config
```

Make the following all "no", and make sure they're not commented out:

```config
ChallengeResponseAuthentication no
PasswordAuthentication no
UsePAM no
PermitRootLogin no
```

Save the config and reload the server's configuration file:

```bash
sudo systemctl reload ssh
```

### Bonus Points

If you're building a one-off server, ignore this section. If you're setting up this server as part of building an image, like a base VM for use by developers, or a container to be used by developers or in production, you may want to erase the shell history before you finish:

```bash
history -c && history -w
```

## `ssh-agent` or Deploying with Capistrano

If you need to log in to a server, and then from there log in to another server, and without putting your private keys on the middle machine, there is a way. This is what you have to do for Capistrano deploys, for example, where the "middle" server is the one you're deploying to, and GitHub is the third server you need to log in to (for a non-public repository).

SSH can do this via "agent forwarding." The server, when challenged for a key, delegates the challenge to the SSH agent on the first machine (your workstation). Your workstation will use your private key to authenticate to the third server.

There are four parts to setting this up and then deploying:

* Your workstation or laptop.
* The repository from which you get the code (we'll use GitHub).
* The server (where you want to deploy the application).
* Deploy (this part is Capistrano and Rails-specific, so you can skip it if you're just interested in SSH).

### Your Workstation or Laptop

It's likely that you have little to do here, at least, if you're not using Windows. On modern Linux or Macos workstations and laptops, an SSH agent is started when you log in. On Linux or Macos, or WSL, you can confirm that `ssh-agent` is running, and see the keys it's using, by typing:

```bash
ssh-add -l
```

If the agent is running, it will print a list of keys, which is likely all the keys you have in `~/.ssh`. On the odd chance that the agent is running but the key you need isn't loaded, type:

```bash
ssh-add ~/.ssh/<private key file name>
```

Another way to check that you have a running `ssh-agent`, is to check the environment:

```bash
env | grep SSH
```

You should see something like: `SSH_AUTH_SOCK=/run/user/1000/keyring/ssh`.

As far as I know, WSL does _not_ start `ssh-agent` automatically. Nor does a typical Ubuntu server install, and I assume other Linux servers are similar.

To start the `ssh-agent`:

```bash
eval `ssh-agent`
```

It's very important to remember that this `ssh-agent` will only be usable by SSH sessions that you initiate in the same terminal as the one in which you ran the above command.

### GitHub

If you haven't already done so, put one of your _public_ keys on the GitHub repository of the application you want to deploy. On GitHub, go to Settings and then "SSH and GPG Keys".

### The Server

If you're setting up the server from scratch, you need to do what's described in [Setting up a Server as an SSH Server](#setting-up-a-server-as-an-ssh-server). It's common to run the application on the server as a user dedicated to that application. If that's what you want to do, set up the user on the server.

If you don't already have password-less login to the server-user (the user under which the application will run) on the server, set it up using any of the approaches in [Using the Client from Your Computer](#using-the-client-from-your-computer).

It's possible that the server has agent forwarding disabled. We've seen an Ubuntu AWS machine that had agent forwarding disabled. Look in the `/etc/ssh/ssh_config` of the server for an uncommented line that says `ForwardAgent no`. If you have privileges to change `/etc/ssh/ssh_config`, you can change the line in this file to `yes`, or create a per-user `~/.ssh/config` on the server:

```config
Host *
    ForwardAgent yes
```

(If you have other options in your `~/.ssh/config`, put this one at the end. The options are set the first time they're encountered in these files, and not overriden by any later definitions.)

Log in to the server as `server-username` (the user that will run the application) and try to `ssh` to `github.com`. This is to record the GitHub _host_ in the `known_hosts` file (https://stackoverflow.com/a/40578618). You won't actually get shell access to GitHub:

```bash
ssh git@github.com
```

From your workstation or laptop, test that the forwarding is working:

```bash
ssh -A server-username@server 'ssh -T git@github.com'
```

## Deploy with Capistrano

Do a deploy that won't work, just to get directories set up:

```bash
cap production deploy
```

Copy the `master.key` file to `/var/www/<application-name>/shared/config/master.key` and set it up:

```bash
sudo chown :www-data /var/www/dashboard/html/shared/config/master.key
chmod 640 /var/www/dashboard/html/shared/config/master.key
```

Do the deploy that should work:

```bash
cap production deploy
```

## Bastion or Jump Server

There is some debate as to whether a bastion or jump server actually makes your network more secure. I won't comment on that, because it's not my area of expertise. However, I find a jump server is useful for a couple of other cases:

* If you have a few servers behind a simple router, it's relatively easy to configure the router and jump server to give you secure external access to all your servers.
* The jump server can be the other end point of a simple VPN, so that you can appear to be accessing the internet from wherever the jump server is, rather than where you are. Handy when you're out of the country and you need to access a web site that's only available in your country, for example.

The idea is to forward port 22 on your router to the jump server, and then from there branch out to your other servers, or back out to the internet.

Set up your jump server as an SSH server as described in [Setting up a Server as an SSH Server](#setting-up-a-server-as-an-ssh-server). Set up password-less login to the jump server as described in [Using the Client from Your Computer](#using-the-client-from-your-computer).

Configure your router to forward traffic to port 22 to your jump server.

If you want to jump to your other servers, edit your `~/.ssh/config` file as follows. Get the external (internet) IP address of your router. Make up a name you want to use to represent your jump server (it doesn't have to be a DNS name or anything official). Then put the following at the beginning of your `~/.ssh/config` (replacing "jump-server-name" and "xx.xx.xx.xx" with the name you made up and the IP address of your router):

```config
Host jump-server-name
  HostName xx.xx.xx.xx
  ForwardAgent yes
```
If all you want is a server to be an end point for a simple VPN, you're done. (One way to use the simple VPN is shown below.)

If you want to access other servers behind the jump server, add something like this to `~/.ssh/config` (your server names will be different, of course):

```config
Host server-a
  Host server-a
  ProxyJump jump-server-name

Host server-b
  Host server-b
  ProxyJump jump-server-name
```

`server-a` and `server-b` can be names that will resolve _inside_ the network, i.e., they will be resolved by the jump server.

With the above, when you `ssh server-a` from outside your router, you will be logged in to `server-a`.

You can do other things with `~/.ssh/config`. For example, if you have one server that's running multiple web sites, and each one is deployed with a different user, you can do this:

```config
Host application-a.com
  Host server-a
  User application-a
  ProxyJump jump-server-name

Host application-b.com
  Host server-a
  User application-b
  ProxyJump jump-server-name
```

With the above, when you `ssh application-b.com`, you will be logged in to `server-a` as user `application-b`.

### Simple VPN

Last time I was out of the country for a while, Chrome's support on Linux for proxies was not great. The way I found to be able to browse the internet as if I were at home was to create a small script to start a separate instance of Chrome:

```bash
#! /bin/bash
ssh -fND 9090 jump-server-name && /usr/bin/google-chrome --user-data-dir="$HOME/proxy-profile" --proxy-server="socks5://localhost:9090"
```

By running this script, Chrome would start and route its traffic through my jump server as a proxy, so I could see websites that were only available in my home country.

## Troubleshooting

### Password-less Login

A few basic things:

* Are the permissions correct on your key files? Your private keys must be readable and writable only by the user that owns the file. Otherwise, `ssh` will refuse to use the keys (and you should probably generate new keys).
* Does the server allow password-less login? Check that the `/etc/ssh/sshd_config` is set up as described in the [The Harder Way AKA For an Existing Server](the-harder-way-aka-for-an-existing-server) section.
* Try the `-v` (verbose) argument of the `ssh` command: `ssh -v server-username@server`. This will output copious amounts of information about what `ssh` is doing, much of which won't make any sense. But you may see clues as to what part of the login is failing.
* If you're trying to connect to a server on which you just set up the SSH server, remember to do `sudo systemctl reload ssh` on the server.

An uglier situation I've run into is the following: We could log into the remote server using `ssh` without a password. But when we tried to log in to do a deploy with Capistrano, the login to the target server would fail. The TL;DR of the solution is that we deleted the `known_hosts` file on the client computer, and then logged in first to the remote machine with Capistrano.

The lesson is that if you're having trouble making an SSH connection, you can delete the `~/.ssh/known_hosts` file. Worst case is that you have to answer `yes` a bunch of times for systems you normally connect to without having to say `yes`.

### `ssh-agent`

* Check if you have an agent running in the terminal where you're running `ssh`: `env | grep SSH`. (If you're manually running the `ssh-agent`, it's easy to try to `ssh` in another window that doesn't have the agent.)
* Check that the key you need is loaded: `ssh-add -l`.

## Boring Stories of SSH Debugging.

Earlier we mentioned an ugly situation we ran into: We could log into the remote server using `ssh` without a password. But when we tried to log in to do a deploy with Capistrano, the login to the target server would fail.

Part of the origin of the story is that the server had existed before with the same DNS name and IP address, but had been destroyed and recreated. (The benefit of VMs, right?) Because it had been recreated, it had a new SSH fingerprint.

What we believe was happening is: Capistrano uses a Ruby implementation of SSH, built on some of the same code as the regular `ssh` client, but with some differences. One of the differences, at the time of this issue, anyway, was that the Ruby implementation couldn't write hashed keys in the `known_hosts` file. But it would read them fine (or so they said). On Ubuntu 22.04, the `ssh` client _was_ using hashed keys in the `known_hosts` file.

The line for _unhashed_ keys in the `known_hosts` file can start with a comma-separated list of host names, typically the DNS name and the numeric IP address of the host. The line for _hashed_ keys can only have one host, so you'll find _two_lines for many hosts: one for the DNS name and one for the IP address.

