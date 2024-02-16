---
layout: content_wrapper
title: SSH
author: Larry Reid
tags: ssh
---

## Key Pairs

One per machine. ED25519 is the best. Name it the default.

On your own computer, generate a key pair and copy it to the VM. Use ED25519. Use the default identity or you will have some grief down the line:

```bash
ssh-keygen -t ed25519
ssh-copy-id <username>@vm*
```

Now you can log in to the VM from your computer without a password:

```bash
ssh '<username>@vm'
```

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

