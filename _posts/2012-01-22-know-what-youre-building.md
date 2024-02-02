---
layout: post
title: Know What You're Building
date: '2012-01-22T08:32:00.000-08:00'
author: Larry Reid
tags:
- Relocation
- IT Infrastructure
modified_time: '2012-01-22T08:32:51.526-08:00'
blogger_id: tag:blogger.com,1999:blog-5778824359157275227.post-7688404540884911941
blogger_orig_url: http://technopragmatica.blogspot.com/2012/01/know-what-youre-building.html
---

"Know what you're building" seems like an obvious thing to say, but I
don't think we do it that well in IT. For my recent data centre
relocation project, we applied that principle successfully to a couple
of areas. The network lead wrote up exactly what he was building, and
the storage lead listed out every device he needed. But we never did a
complete "final state" description of the new data centre.  
  
It all worked pretty well, although we needed a number of meetings
during the design phase of our new data centre -- laying out the racks,
non-rack equipment, power, cabling for the networks. I think we needed
to have a lot of meetings because there isn't a commonly accepted way to
draw a plan of a data centre that covers the requirements of all the
people in the room.  
  
I'm running into the issue again in a smaller way now that we're
designing the new central communication room for the equipment that used
to be in the old data centre, but needs to remain behind for local
operations (mostly the network gear to service a large office building).

  
Just as a refresher, here are all the people you need to involve:  
  
<ul><li>The server team(s) know the physical dimensions of the servers,
their weight, how many network ports they have and how they need to be
configured, whether they need SAN-attached storage, backup requirements,
how much power and cooling the server needs</li><li>The network team(s)
know the network devices, which have most of the same requirements as
servers, the approach for connecting, which defines the need for cables
and patch panels, and the cabling, which may affect weight of cable
trays or floor loading</li><li>The storage team(s) know the switching
devices, which have most of the same requirements as the network
devices</li><li>The electrical engineer or consultant needs to know all
the power requirements and placement of all the equipment</li><li>The
mechanical engineer or consultant needs to know the cooling requirements
and placement of all the equipment</li><li>The structural engineer or
consultant needs to know the weight and placement of all the
equipment</li><li>The trades who actually build it all need to know
exactly what they're building</li><li>There's likely some other poor
person, maybe a building architect, who has to pull this all
together</li></ul>  
Add to all that the fact that the technology in a data centre is
constantly changing, at least in terms of the number and type of servers
in the room. Also, the requirements and constraints tend to be
circular: For example, the number of network ports on a server affects
the amount of network gear you need, which affects how many servers you
can have (either through port capacity or rack space), which affects how
much power and cooling you need but also how many network ports you
need.  
  
You also have to worry about other details than can seriously derail an
otherwise great plan. For example, when running fibre, you need to make
sure it's the right kind of fibre and that it has the right connectors.
Power cables in a data centre can be varied, so again you need to make
sure that the power distribution units (PDUs) in the racks can be
connected to your servers.  
  
  
{: .Apple-interchange-newline}With all this, it can be hard for people
to come to an agreement on what to build. We don't have well-established
ways of describing what's going to be built in a way that everyone
understands. There's software to help do this, but it tends to be
unreasonably expensive for a medium-sized enterprise.  
  
Regardless of how hard or expensive it is, there's a lot of value in
figuring out what you're going to build, before you built it. We were
successful using Excel and Word to describe what to build, and drawings
of floor plans. We had to be extremely careful about versions and
keeping the different documents in sync. In the end, happily it all
worked out.

