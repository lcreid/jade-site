---
layout: post
title: Work-flow for a Data Centre Relocation
date: '2013-02-03T08:43:00.002-08:00'
author: Larry Reid
tags:
- Relocation
modified_time: '2013-02-03T22:41:56.790-08:00'
blogger_id: tag:blogger.com,1999:blog-5778824359157275227.post-5691722644180403365
blogger_orig_url: http://technopragmatica.blogspot.com/2013/02/work-flow-for-data-centre-relocation.html
---

I've relocated a couple of data centres, and I've just started working
on another. The last one moved over 600 servers, about half physical and
half virtual. We moved over five months, counting from when the first
production workload went live in the new data centre. Our team consisted
of five PMs working directly with the server, network and storage
admins, and application support teams.

\[Update: Check out the visual representation of this post [here][1]{:
target="_blank"}.\]

We knew we had a lot of work to do in a short time, and we were working
in a diverse and dynamic environment that was changing as we tried to
move it. We needed a flexible and efficient way to move the data centre.
One thing that really helped was a work-flow for the PMs to work with
the various technical and user teams that allowed teams to focus on
doing what they needed to do.

Early in the project we collected all the inventory information we could
to build up a list of all the servers, whether they were physical or
virtual, make and model, O/S, etc., and put it in the Master Device List
(MDL). We then did a high-level breakdown into work packets or affinity
groups in consultation with the application support folks. These works
packets were what was doled out to the individual PMs.

Each PM then began the detailed planning process for the work packet.
Starting from a template, the PM began building the relocation plan,
which was simply a spreadsheet with a few tabs:

* One tab was the plan itself, a minute-by-minute description of
the tasks that had to be done, and who was responsible for doing them,
over the course of the time immediately around the time of the
relocation. Many also included the prerequisite tasks in the days
preceding the relocation
* Another tab was the list of servers,
and the method by which they would be moved. We had a number of possible
move methods, but basically they boiled down to virtual-to-virtual --
copying a virtual machine across the network, lift and shift --
physically moving a server, and leap frog -- copying the image from a
physical server across the network to another, identical physical
server
* The third tab was a list of contact information for
everyone mentioned in the plan, along with the approvers for the
hand-over to production, escalation points, and any other key
stakeholders

At this point many PMs also nailed down a
tentative relocation date and time for the work packet and put it in the
[relocation calendar][2]{: target="_blank"}, a shared calendar in
Exchange. The relocation calendar was the official source of truth for
the timing of relocations. Some PMs preferred to wait until they had
more information. My personal preference is to nail down the date early,
as you have more choice about when to move.

The PM then got the various admins to gather or confirm the key
information for the server build sheet and the server IP list.

The server build sheet contained all the information needed to build the
new server in the new data centre. For a virtual machine, this was
basically the number and size of mounted storage volumes including the
server image itself. This information was key for planning the timing of
the relocation, and in the case of VMs with extra attached storage
volumes, made sure that everything got moved.

For physical servers the build sheet had everything needed for a VM,
plus all the typical physical server information needed by the
Facilities team to assign an available rack location and to rack and
connect the server in the new data centre.

The server IP list simply listed all the current IPs used by the server,
and their purpose. Most of our servers had one connection each to two
separate redundant networks for normal data traffic, along with another
connection to the backup network, and finally a fourth connection to the
out-of-band management network ("lights-out operation" card on the
server). Some servers had more, e.g. for connections to a DMZ or ganging
two connections to provide more throughput.

The PM iterated through these documents with the admins and support
staff until they were ready. One thing that often changed over the
course of planning was the list of servers included in the work packet.
Detailed analysis often discovered dependencies that brought more
servers into the work packet. Or the volume of work proved to be too
much to do in the available maintenance window and the work packet had
to be split into two. Or the move method turned out to be inappropriate.
We encouraged this, as our goal of minimizing or eliminating downtime
and risk was paramount.

When the plan was done the Facilities team took the server build sheet
and arranged for the physical move and connection of servers. The
Network team took the server IP list and used it to assign the new IPs,
and prepare the required network configuration and firewall rules.

The network admins put the new IPs into the same server IP list sheet,
which was available to everyone, so for example the server admins could
assign the new IPs at the time of the relocation.

At the time of the relocation, everyone did their tasks according to the
relocation plan, and the PM coordinated everything. For simple single
server, single application relocations, the team typically moved and
tested the server without intervention from the PM.

Finally, the Backup and Monitoring teams used the server list in the
relocation plan to turn backups and monitoring off for the relocated
servers at the old data centre, and to turn  backups and monitoring on
for the relocated servers at the new data centre.

It wasn't all roses. We had a few challenges.

We set a deadline for the PMs to have the server build sheets and server
IP lists completed two weeks before the relocation, to give time for the
Facilities team to plan transport and workloads for the server room
staff, and for the Network team to check all the firewall rules and
ensure that the new configuration files were right. We often missed that
deadline, and were saved by great people in the Facilities and Network
teams, but not without a lot of stress to them.

There was some duplication of information across the documents, and it
could be tedious to update. As an old programmer, I had to stop myself
several times from running off and building a little application in Ruby
on Rails to manage the process. But we were a relocation project, not a
software development project, so we sucked it up and just worked with
the tools we had.

In summary, we had a repeatable, efficient work-flow that still allowed
us to accommodate the unique aspects of each system we were moving. We
needed five key documents:

* Master device list (MDL), a single spreadsheet for the whole
project
* Relocation calendar, a single shared calendar in
Exchange
* Relocation plan, per work packet
* Server build
sheet, per server, or per work packet with a tab per
server
* Server IP list, a single document for the whole project
(which grew as we went)

The PMs were working with various teams
that knew how to do, and were very efficient at, certain repeatable
tasks:

* Communicating outages to the user base (Communication
Lead)
* Moving a physical server and connecting it in the new
data, or installing a new server as a target for an electronic
relocation of a physical server (Facilities team)
* Moving a
virtual machine or a physical machine image, and its associated storage
(Server and Storage team)
* Reconfiguring the network and firewall
for the relocated servers, including DNS changes (Network team, although
for simple moves the server admin often did the DNS
changes)
* Acceptance testing (Test Lead who organized testing)
* Changing backups and monitoring (Backup team and Monitoring
team)

