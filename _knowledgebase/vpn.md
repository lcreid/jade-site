---
layout: kb
toc: true
title: VPN
author: Larry Reid
tags: ssh
---

## Introduction

Here's how I set up a pass-through (tunnel) VPN, which allows me to browse the internet as if I were in my home country, when I'm out of the country. This is not a VPN for logging in to a local network and becoming a member of that local network.

**You have to renew the client certificates every two years.** To see which ones need to be renewed soon, on the VPN server:

```bash
for f in ~/client-configs/keys/*.crt; do echo -n $f: ; openssl x509 -in $f -text -noout | grep -A 2 "Validity"; done
```

## Prerequisites

Here's the prerequisites, or what you need to know how to do, that aren't covered by this page. You need:

* Access to and knowledge of how to route traffic coming from the internet, to your domain name or IP address, on port 1194/UDP. If you're doing this for a home network, most home routers will allow you to do this. But each is different, so you'll have to figure that out yourself. _Very important:_ see the notes [below](routing).
* Two relatively small servers. I used a 1 GB RAM and 8 GB disk Ubuntu for the Certificate Authority (CA) server, and a 2 GB RAM 32 GB SSD card Raspberry Pi 4 for the VPN server. These instructions work for Ubuntu and Debian servers (specifically Ubuntu 22.04 and Debian Bookworm).
* Access to a DNS domain's nameserver, on which you can create a sub-domain where clients connect to the VPN. (Strictly speaking, you _could_ use a hard-coded IP address, but that has a lot of disadvantages. You should know what the trade-offs are, and plan accordingly, before you set up your VPN).
* If you're doing this for anything other than home personal use, you should have a security expert confirm that these instructions provide the level of security you need.
* The instructions below assume you have password-less SSH log-in ability from your desktop/laptop to the CA and VPN servers. You can do this without password-less SSH, but you'll be typing your password a lot.
* In addition to password-less log-in, your desktop/laptop should have a key agent running. Most Linux desktop distributions, and Macos, have this. I believe that WSL on Windows does not have it by default, but you can set one up. There's a lot of SSH-ing and rysnc-ing between servers in these instructions, and it's convenient if you always SSH to another server with `ssh -A` so you don't have to copy credentials in so many places.

You may find [this article]({% link _knowledgebase/effective-ssh.md %}) useful if you want to learn about password-less log-in and the use of key agents and agent forwarding.

I followed Digital Ocean's excellent instructions. They organize them as these two pages:

* [Set up a small server](https://www.digitalocean.com/community/tutorials/how-to-set-up-and-configure-a-certificate-authority-ca-on-debian-11) as your Certificate Authority (CA). It only generates key-pairs and can be off most of the time (and should be off, they say, so it's harder to steal the keys).
* [Set up the VPN server](https://www.digitalocean.com/community/tutorials/how-to-set-up-an-openvpn-server-on-debian-11).

This page summarizes what I did to set up a VPN. It reorganizes and leaves out some steps from the Digital Ocean instructions. The re-organization was to separate out the instructions for adding a new client to an existing VPN. The instructions removed were mostly for the CA server, as they included additional steps for the use case where you want to test or deploy internal HTTPS servers using your own certificates -- steps that aren't needed for a VPN.

Random notes (to self):

* For the Ubuntu servers, I used the minimal Ubuntu install.
* Because of the minimal install, I had to `sudo apt install vim rsync` on both servers.

### Routing

Much to my chagrin, I discoverd that not all ISPs in the world do things the same as the common (in my experience) approach in North America. In one of the places where I wanted to put a VPN, it turned out that between my home router and the whole internet, there was another router doing NAT, and obviously I had no way of changing that router.

Reading on the internet convinced me that double-NATting is possible. In addition, I observed that the WAN address on my router was not the same as the IP address I got from browsing to whatsmyip.org.

In addition, sometime in the last year, this ISP started changing the password on their clients' routers every day at midnight local time. It was tremendously inconvenient to get the password from them, although at least it was possible. But then it was only good for the one day.

So all in all, the whole adventure stalled there. It's beyond my current network fu to build a VPN that originates in the "double-NATted" ISP to the "single-NATted" ISP, but I'm hoping that I will someday be able to do something like that.

## How Does It Work

If you're interested, here's a higher level description of how it will all work when it's all put together:

* The CA generates a key pair.
* The VPN server generates a key pair.
* The VPN server generates a Certificate Signing Request (CSR) that contains its public key, and the request encrypted with the private key.
* The VPN server sends the CSR to the CA.
* The CA server "signs" (actually encrypts) the CSR using its private key.
* The CA server gives the signed certificate back to the VPN server.
* For each client, the VPN server generates a CSR on behalf of a client.
* The CA server "signs" the CSR using its private key.
* The CA server gives the signed certificate back to the VPN server.
* The VPN server builds a `.ovpn` file for the client.
* The client uses the `.ovpn` file to negotiate a secure connection with the VPN.
* Communication between the VPN server and the client is now secure.

## Work Breakdown

I tried to separate out the steps you need to do one-time per VPN, from those that you have to do one time per VPN client. Here's how they break down:

1. CA set-up and one-time key-pair generation. (These instructions work for one CA and multiple VPNs, as long as the VPN common names are different, and the client common names are different per VPN.)
1. VPN server set-up and one-time key-pair generation.
1. Per-client credential generation.
1. One-time install client software on client.
1. Install certificate on client.
1. Every 180 days, renew the certificate revocation list on the CA and move to the VPN servers.
1. Every two years: Renew the client certificate.

### CA Set-Up

1. Get a server going with passwordless SSH, `vim`, and `rsync`.
1. [https://www.digitalocean.com/community/tutorials/how-to-set-up-and-configure-a-certificate-authority-ca-on-debian-11#step-1-installing-easy-rsa](https://www.digitalocean.com/community/tutorials/how-to-set-up-and-configure-a-certificate-authority-ca-on-debian-11#step-1-installing-easy-rsa).
1. [https://www.digitalocean.com/community/tutorials/how-to-set-up-and-configure-a-certificate-authority-ca-on-debian-11#step-2-preparing-a-public-key-infrastructure-directory](https://www.digitalocean.com/community/tutorials/how-to-set-up-and-configure-a-certificate-authority-ca-on-debian-11#step-2-preparing-a-public-key-infrastructure-directory).
1. [https://www.digitalocean.com/community/tutorials/how-to-set-up-and-configure-a-certificate-authority-ca-on-debian-11#step-3-creating-a-certificate-authority](https://www.digitalocean.com/community/tutorials/how-to-set-up-and-configure-a-certificate-authority-ca-on-debian-11#step-3-creating-a-certificate-authority).

You don't have to do the rest of the steps for the VPN use case.

### VPN Set-Up

This one has the most steps, and isn't really described as a unit in the Digital Ocean documentation. Instead of using the default template configuration file, you can get one [here](https://github.com/lcreid/vpn/raw/main/server-common-name.conf) that has most of the configuraton done for you.

1. Get a server going with passwordless SSH, `vim`, and `rsync`.
1. [https://www.digitalocean.com/community/tutorials/how-to-set-up-and-configure-a-certificate-authority-ca-on-debian-11#step-1-installing-easy-rsa](https://www.digitalocean.com/community/tutorials/how-to-set-up-and-configure-a-certificate-authority-ca-on-debian-11#step-1-installing-easy-rsa).
1. [https://www.digitalocean.com/community/tutorials/how-to-set-up-and-configure-a-certificate-authority-ca-on-debian-11#step-2-preparing-a-public-key-infrastructure-directory](https://www.digitalocean.com/community/tutorials/how-to-set-up-and-configure-a-certificate-authority-ca-on-debian-11#step-2-preparing-a-public-key-infrastructure-directory).
1. [https://www.digitalocean.com/community/tutorials/how-to-set-up-an-openvpn-server-on-debian-11#step-1-installing-openvpn](https://www.digitalocean.com/community/tutorials/how-to-set-up-an-openvpn-server-on-debian-11#step-1-installing-openvpn).
1. [https://www.digitalocean.com/community/tutorials/how-to-set-up-an-openvpn-server-on-debian-11#step-2-creating-the-server-certificate-key-and-encryption-files](https://www.digitalocean.com/community/tutorials/how-to-set-up-an-openvpn-server-on-debian-11#step-2-creating-the-server-certificate-key-and-encryption-files).
1. [https://www.digitalocean.com/community/tutorials/how-to-set-up-an-openvpn-server-on-debian-11#step-4-configuring-the-openvpn-service](https://www.digitalocean.com/community/tutorials/how-to-set-up-an-openvpn-server-on-debian-11#step-4-configuring-the-openvpn-service).
1. [https://www.digitalocean.com/community/tutorials/how-to-set-up-an-openvpn-server-on-debian-11#step-5-adjusting-the-server-networking-configuration](https://www.digitalocean.com/community/tutorials/how-to-set-up-an-openvpn-server-on-debian-11#step-5-adjusting-the-server-networking-configuration).
1. [https://www.digitalocean.com/community/tutorials/how-to-set-up-an-openvpn-server-on-debian-11#step-6-starting-and-enabling-the-openvpn-service](https://www.digitalocean.com/community/tutorials/how-to-set-up-an-openvpn-server-on-debian-11#step-6-starting-and-enabling-the-openvpn-service).
1. [https://www.digitalocean.com/community/tutorials/how-to-set-up-an-openvpn-server-on-debian-11#step-7-creating-the-client-configuration-infrastructure](https://www.digitalocean.com/community/tutorials/how-to-set-up-an-openvpn-server-on-debian-11#step-7-creating-the-client-configuration-infrastructure).
1. Create directories on the VPN server, and set permissions, in preparation for per-client credential generation:

    ```
    mkdir -p ~/client-configs/keys
    chmod -R 700 ~/client-configs
    ```
1. Copy the CA cert and the TA key to the new directory:
    ```
    sudo cp ~/easy-rsa/ta.key ~/client-configs/keys/
    sudo cp /etc/openvpn/ca.crt ~/client-configs/keys/
    ```

### Per-Client Credential Generation

*Note:* there are some tweaks to the template client configuration file you need to do if you plan on using Macos clients (and perhaps Windows -- I haven't tested a Windows client). Instead of using the default template configuration file, you can get one [here](https://github.com/lcreid/vpn/raw/main/base.conf) that has most of the configuraton done for you, including the additional tweaks for Macos.

This is something I have to do every two years, so I'm going to write my own instructions here. They are mostly copied from the Digital Ocean pages, but among others, I've optimized them so it's easier to just cut and paste the commands.

1.  Set some environment variables. Replace the values with the correct name for you:

    ```
    CLIENT_COMMON_NAME=client
    CA_SERVER_NAME=ca-server
    VPN_SERVER_NAME=vpn-server
    ```
    If you're creating a batch of client `.ovpn` files, you should only have to change the first environment variable for each one.

1. On the VPN server, generate the request.

    ```
    cd ~/easy-rsa
    ./easyrsa gen-req $CLIENT_COMMON_NAME nopass
    ```
    Press Enter to confirm the common name.
1. Copy the resulting key to the key directory.

    ```
    cp pki/private/$CLIENT_COMMON_NAME.key ~/client-configs/keys
    ```
1. Transfer the request file securely to the CA server:

    ```
    rsync pki/reqs/$CLIENT_COMMON_NAME.req $CA_SERVER_NAME:/tmp
    ```
1. _On the CA server_, import the ceritificate request (if this is not the first time you've imported a request for this common name, delete the existing file first):

    ```
    cd ~/easy-rsa
    rm pki/reqs/$CLIENT_COMMON_NAME.req
    ./easyrsa import-req /tmp/$CLIENT_COMMON_NAME.req $CLIENT_COMMON_NAME
    ```
1. Sign the request:

    ```
    ./easyrsa sign-req client $CLIENT_COMMON_NAME
    ```
    Type "yes" to confirm that you intend to sign the request.
1. Transfer the file back to the VPN server:

    ```
    rsync pki/issued/$CLIENT_COMMON_NAME.crt $VPN_SERVER_NAME:/tmp
    ```
1. On the VPN server, mv the signed file to the keys directory:

    ```
    mv /tmp/$CLIENT_COMMON_NAME.crt ~/client-configs/keys
    ```
1. Generate the `.ovpn` file:

    ```
    cd ~/client-configs
    sudo ./make_config.sh $CLIENT_COMMON_NAME
    ```

1. [https://www.digitalocean.com/community/tutorials/how-to-set-up-an-openvpn-server-on-debian-11#step-10-testing-your-vpn-connection-optional](https://www.digitalocean.com/community/tutorials/how-to-set-up-an-openvpn-server-on-debian-11#step-10-testing-your-vpn-connection-optional).

### Per-Client Software Install

I'm not going to give specific instructions here. You can choose the client software you want, as long as it's compatible with OpenVPN. Personally, I've used the official OpenVPN client software on Linux and Macos.

### Install Certificate on Client

This will be specific to your VPN client, so consult the instructions for the client you chose.

#### OpenVPN Client on Linux

The Digital Ocean instructions for Linux and the OpenVPN client show a way to test the connection, and then the internet tells you have to configure Network Manager to have the VPN. _Both_ will permanently add the VPN to Network Manager, so you'll end up with two. You can just do the following to import the `.ovpn` file on Linux:

```bash
nmcli connection import type openvpn file $CLIENT_COMMON_NAME.ovpn
```

If you need to remove the connection, do:

```bash
nmcli connection delete id $CLIENT_COMMON_NAME
```

The above will remove all connections with the same CN, but then you can add back (just once) the `.ovpn` file you want.

#### Digital Ocean's Instructions

For reference, Digital Ocean's installation instructions are [here](https://www.digitalocean.com/community/tutorials/how-to-set-up-an-openvpn-server-on-debian-11#step-9-installing-the-client-configuration).

### Renew the Certificate Revocation List

The certification revocation list `crl.pem` has to be updated periodically (every 180 days) on the CA server, and then moved to all the VPN servers that use certificates generated by the CA.

On the CA server (you'll be prompted for the passphrase for the certificates on this server):

```bash
cd ~/easy-rsa
./easyrsa gen-crl
```

Then, copy it over to the VPN server:

```bash
rsync pki/crl.pem vpn-server:
```

On the VPN server, put it in the VPN configuration directory, and restart the service:

```bash
sudo chown root:root ~/crl.pem
sudo mv ~/crl.pem /etc/openvpn/
sudo systemctl restart openvpn@common-name-of-your-vpn.service
```

That's it. No need to regenerate certificates or `.ovpn` files.

### Renew the Client Certificate

Simply generate a new `.ovpn` file for each client when needed. Follow the instructions [here](#per-client-credential-generation).

I read of a `./easyvpn renew $CLIENT_COMMON_NAME` command, but it didn't work for me.

### Checking Validity of Certificates

The certificates will expire. You can check your certs on the server by (for the server):

```bash
openssl x509 -in <service-name>.crt -text -noout | grep -A 2 "Validity"
```

For clients, if you have the `.crt` files on the server still, you can use the above command. If the certs are only on the clients, and they're not Linux systems, I don't know what to do.

### Revoking Access

1. [https://www.digitalocean.com/community/tutorials/how-to-set-up-an-openvpn-server-on-debian-11#step-11-revoking-client-certificates](https://www.digitalocean.com/community/tutorials/how-to-set-up-an-openvpn-server-on-debian-11#step-11-revoking-client-certificates).
