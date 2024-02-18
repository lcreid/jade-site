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

This is where having the user's public key in a public place makes things a lot easier. Basically, we follow the instructions in [A Public Respository for your Public Key](#a-public-respository-for-your-public-key), with a few tweaks to use the right username in the right place. So read and type the following carefully:

```bash
ssh server-superusername@server
SERVER_USERNAME=server-username
SERVER_USER_HOME=`getent passwd $SERVER_USERNAME | cut -d: -f6`
ls -ld $SERVER_USER_HOME/.ssh
sudo mkdir $SERVER_USER_HOME/.ssh && chmod 700 $SERVER_USER_HOME/.ssh # If the directory didn't exist.
sudo cp -a $SERVER_USER_HOME/.ssh/authorized_keys $SERVER_USER_HOME/.ssh/authorized_keys.old # A backup, in case something goes wrong.
sudo curl https://github.com/<GitHub user name of the >.keys >> $SERVER_USER_HOME/.ssh/authorized_keys
sudo chmod 611 $SERVER_USER_HOME/.ssh/authorized_keys
sudo chown -R $SERVER_USERNAME:$SERVER_USERNAME $SERVER_USER_HOME/.ssh
```

If the public key isn't stored in a public place, then it's kind of up to you to figure out how you're going to get the key onto the server. One way is to copy the public key to somewhere on the server using `rsync`, then follow steps very similar to those above. On the computer that has the public key, type (make sure to type that colon `:` at the end.):

```bash
sudo rsync path_to_public_key_file server-superusername@server:
```

Then follow the same steps as above, but instead of copying the keys from GitHub (or your public place), copy from the temporary file:

```bash
ssh server-superusername@server
SERVER_USERNAME=server-username
SERVER_USER_HOME=`getent passwd $SERVER_USERNAME | cut -d: -f6`
ls -ld $SERVER_USER_HOME/.ssh
sudo mkdir $SERVER_USER_HOME/.ssh && chmod 700 $SERVER_USER_HOME/.ssh # If the directory didn't exist.
sudo cp -a $SERVER_USER_HOME/.ssh/authorized_keys $SERVER_USER_HOME/.ssh/authorized_keys.old # A backup, in case something goes wrong.
sudo cat ~/public_key_file_name >> $SERVER_USER_HOME/.ssh/authorized_keys
sudo chmod 611 $SERVER_USER_HOME/.ssh/authorized_keys
sudo chown -R $SERVER_USERNAME:$SERVER_USERNAME $SERVER_USER_HOME/.ssh
rm ~/public_key_file_name
```

Instead of `curl`, we just `cat` the key(s) onto the end of the `authorized_keys`, and then we remove the file we rsync'd over to begin with.

## Setting up a Server as an SSH Server

Finally, disable password logins for everyone:

```bash
sudo vi /etc/ssh/sshd_config
```

and make the following all "no", and make sure they're not commented out:

```config
ChallengeResponseAuthentication no
PasswordAuthentication no
UsePAM no
PermitRootLogin no
```

Save the config and then:

```bash
sudo systemctl reload ssh
```

(See https://chealion.ca/2016/06/20/ssh-key-types-and-cryptography-the-short-notes/ and the Mozilla page it references.)

(Or you can simply disable password logins on a per-user basis: `sudo passwd -l <username>`.)

Finally, clean up the evidence:

```bash
history -c && history -w
```

## `ssh-agent` or Deploying with Capistrano

If you need to log in to a remote machine, and then from there log in to another machine, and without putting your keys on the middle machine, there is a way. This is what you have to do for Capistrano deploys, where the "middle" machine is the one you're deploying to, GitHub is the third machine you need to log in to.

* Make sure the middle machine allows agent forwarding in the _client_ SSH config. Check `/etc/ssh/ssh_config`. We have seen an Ubuntu AWS machine that had agent forwarding disabled. Either change the default config for everyone (`/etc/ssh/ssh_config`), or create a per-user `~/.ssh/config`:

    ```config
    Host *
      ForwardAgent yes
    ```

* Check that the first machine (your workstation) has a running `ssh-agent`. One way is to check the environment:

    ```bash
    env | grep SSH
    ```

    You should see something like: `SSH_AUTH_SOCK=/run/user/1000/keyring/ssh`.

    To start the `ssh-agent`:

    ```bash
    eval `ssh-agent`
    ```

* Check that the agent on the first machine has keys loaded:

    ```bash
    ssh-add -l
    ```

    To add a key:

    ```bash
    ssh-add ~/.ssh/<private key file name>
    ```

1. Allow users who will be doing deploys to log in as the deploy user. Replace `deploy-user` with the user who owns the files on the remote server (`vm`).

    Copy the user's public key to the deployment user:

    ```bash
    ssh-copy-id -i deploy-user@vm
    ```

    If the user keeps their public keys in GitHub, you can log in as `deploy-user` and do this:

    ```bash
    cp -a ~/.ssh/authorized_keys ~/.ssh/authorized_keys.bak # in case something goes wrong.
    curl https://github.com/<user>.keys >> ~/.ssh/authorized_keys
    ```

    Make sure to use `>>` (two `>`) in the above command.

2. Put the _public_ key on the repository of the applicaton you want to deploy.

3. Log in to the server as `deploy-user` (the deployment user) and try to `ssh` to `github.com`. This is to record the GitHub _host_ in the `known_hosts` file (https://stackoverflow.com/a/40578618):

    ```bash
    ssh git@github.com
    ```

4. Back on your machine, test that the forwarding is working:

    ```bash
    ssh -A deploy-user@vm 'ssh -T git@github.com'
    ```

5. Do a deploy that won't work, just to get directories set up:

    ```bash
    cap production deploy
    ```

6. Copy the `secrets.yml` file to `/var/www/dashboard/shared/config/secrets.yml` and set it up: (This is old, I think. Now we want `master.key`.)

    ```bash
    sudo chown :www-data /var/www/dashboard/html/shared/config/secrets.yml
    chmod 640 /var/www/dashboard/html/shared/config/secrets.yml
    ```

7. Do the deploy that should work:

    ```bash
    cap production deploy
    ```

## Jump Server

## Troubleshooting


