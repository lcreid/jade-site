---
layout: kb
toc: true
title: VPN
author: Larry Reid
tags: ssh
---

## Introduction

Here's how I set up a pass-through (tunnel) VPN, which allows me to browse the internet as if I were in my home country, when I'm out of the country. This is not a VPN for logging in to a local network and becoming a member of that local network.

## Prerequisites

Here's the prerequisites, or what you need to know how to do, that aren't covered by this page. You need:

* Two relatively small servers. I used a 1 GB RAM and 8 GB disk Ubuntu for the Certificate Authority (CA) server, and a 2 GB RAM 32 GB SSD card Raspberry Pi 4 for the VPN server. These instructions work for Ubuntu and Debian servers (specifically Ubuntu 22.04 and Debian Bookworm).
* Access to a DNS domain's nameserver, on which you can create a sub-domain where clients connect to the VPN. (Strictly speaking, you _could_ use a hard-coded IP address, but that has a lot of disadvantages. You should know what the trade-offs are, and plan accordingly, before you set up your VPN).
* Access to and knowledge of how to route traffic coming from the internet, to your domain name or IP address, on port 1194/UDP. If you're doing this for a home network, most home routers will allow you to do this. But each is different, so you'll have to figure that out yourself.
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

## How Does It Work

If you're interested, here's a higher level description of how it will all work when it's all put together:

* The CA generates a key pair.
* The VPN server generates a key pair.
* The VPN server generates a Certificate Signing Request (CSR) that contains its public key, and the request encrypted with the private key.
* The VPN server sends the CSR to the CA.
* The CA server "signs" (actually encrypts) the CSR using its private key.
* The CA server gives the signed certificate back to the VPN server.
* The VPN server generates a CSR on behalf of a client.
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
1. Off in the future: Renew the certificate.
1. Install certificate on client.

### CA Set-Up

1. Get a server going with passwordless SSH, `vim`, and `rsync`.
1. [https://www.digitalocean.com/community/tutorials/how-to-set-up-and-configure-a-certificate-authority-ca-on-debian-11#step-1-installing-easy-rsa](https://www.digitalocean.com/community/tutorials/how-to-set-up-and-configure-a-certificate-authority-ca-on-debian-11#step-1-installing-easy-rsa).
1. [https://www.digitalocean.com/community/tutorials/how-to-set-up-and-configure-a-certificate-authority-ca-on-debian-11#step-2-preparing-a-public-key-infrastructure-directory](https://www.digitalocean.com/community/tutorials/how-to-set-up-and-configure-a-certificate-authority-ca-on-debian-11#step-2-preparing-a-public-key-infrastructure-directory).
1. [https://www.digitalocean.com/community/tutorials/how-to-set-up-and-configure-a-certificate-authority-ca-on-debian-11#step-3-creating-a-certificate-authority](https://www.digitalocean.com/community/tutorials/how-to-set-up-and-configure-a-certificate-authority-ca-on-debian-11#step-3-creating-a-certificate-authority).

I believe you don't have to do the rest of the steps for the VPN use case.

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
1.

### Per-Client Credential Generation

*Note:* there are some tweaks to the template client configuration file you need to do if you plan on using Macos clients (and perhaps Windows -- I haven't tested a Windows client). Instead of using the default template configuration file, you can get one [here](https://github.com/lcreid/vpn/raw/main/base.conf) that has most of the configuraton done for you, including the additional tweaks for Macos.

1. [https://www.digitalocean.com/community/tutorials/how-to-set-up-an-openvpn-server-on-debian-11#step-3-generating-a-client-certificate-and-key-pair](https://www.digitalocean.com/community/tutorials/how-to-set-up-an-openvpn-server-on-debian-11#step-3-generating-a-client-certificate-and-key-pair).
1. [https://www.digitalocean.com/community/tutorials/how-to-set-up-an-openvpn-server-on-debian-11#step-8-generating-client-configurations](https://www.digitalocean.com/community/tutorials/how-to-set-up-an-openvpn-server-on-debian-11#step-8-generating-client-configurations).
1. [https://www.digitalocean.com/community/tutorials/how-to-set-up-an-openvpn-server-on-debian-11#step-9-installing-the-client-configuration](https://www.digitalocean.com/community/tutorials/how-to-set-up-an-openvpn-server-on-debian-11#step-9-installing-the-client-configuration).
1. [https://www.digitalocean.com/community/tutorials/how-to-set-up-an-openvpn-server-on-debian-11#step-10-testing-your-vpn-connection-optional](https://www.digitalocean.com/community/tutorials/how-to-set-up-an-openvpn-server-on-debian-11#step-10-testing-your-vpn-connection-optional).

### Per-Client Software Install

I'm not going to give specific instructions here. You can choose the client software you want, as long as it's compatible with OpenVPN. Personally, I've used the official OpenVPN client software on Linux and Macos.

### Install Certificate on Client

This will be specific to your VPN client, so consult the instructions for the client you chose.

#### OpenVPN Client on Linux

The Digital Ocean instructions for Linux and the OpenVPN client show a way to test the connection, and then the internet tells you have to configure Network Manager to have the VPN. _Both_ will permanently add the VPN to Network Manager, so you'll end up with two. You can just do the following to import the `.ovpn` file on Linux:

```bash
nmcli connection import type openvpn file common-name-of-your-vpn.ovpn
```

If you need to remove the connection, do:

```bash
nmcli connection delete id common-name-of-your-vpn
```

The above will remove all connections with the same CN, but then you can add back (just once) the `.ovpn` file you want.

### Revoking Access

1. [https://www.digitalocean.com/community/tutorials/how-to-set-up-an-openvpn-server-on-debian-11#step-11-revoking-client-certificates](https://www.digitalocean.com/community/tutorials/how-to-set-up-an-openvpn-server-on-debian-11#step-11-revoking-client-certificates).
