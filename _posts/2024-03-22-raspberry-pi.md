---
layout: post
toc: true
title: Raspberry Pi
author: Larry Reid
tags: ssh, vpn
---

I recently bought some Raspberry Pi 4s to use as VPN end-points. Here's my notes from the build:

1. Figure out how you're going to write on a micro SD card using your computer.
1. Download onto your computer the imager for installing the operating system on the Pi's micro-SD card: `sudo apt install rpi-imager`. This will get the image for you, so no need to download the O/S separately. (At least for the official images.)
1. Run the imager.
1. Click on the settings to set a bunch of the install params. I set most of them to apply in any session, but they include host name and a few others that you'll have to change for every install. Burning the image takes about 10 minutes.
1. Assemble the Pi. Assembling was a little difficult. The slot for the SD card needs a screwdriver inside to push it open. I think they think it's accessible from outside, but not with my fingers.
1. On first boot it says, "Rebooting in 5 seconds" and then pauses for about 30 s. Then when it gets to the login prompt, it prints the time and reboots.

I loaded the operating system onto three SD cards and assembled two Pis in about 1 1/4 hours. I then wasted two hours trying to get the networking working. It turned out the network cable I was using wasn't completely plugged in to the router, or maybe the cable was a bit flaky. Once I wiggled the cable at the router end, all was good.

In the process of figuring that out, I learned that I could start the wireless network with: `sudo nmcli --ask dev wifi connect your-router-name`. Also, once the `wlan0` is configured it seems to stay configured.
