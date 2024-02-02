---
layout: post
title: Firewall on the VM Quick Reference
date: '2008-04-07T20:22:00.000-07:00'
author: Larry Reid
tags:
- VMWare
- Zenoss
- Virtualization
- Ubuntu
- IT Infrastructure
modified_time: '2008-04-09T07:50:47.173-07:00'
blogger_id: tag:blogger.com,1999:blog-5778824359157275227.post-5129258379906131366
blogger_orig_url: http://technopragmatica.blogspot.com/2008/04/firewall-on-vm-quick-reference.html
---

[Here's how to set up the firewall][1]. Here's my <span
style="font-family: courier new;">/etc/iptables.rules</span>:  
  
<span style="font-family:courier new;">\*filter</span>  
<span style="font-family:courier new;">\:INPUT ACCEPT
\[273:55355\]</span>  
<span style="font-family:courier new;">\:FORWARD ACCEPT \[0:0\]</span>  
<span style="font-family:courier new;">\:LOGNDROP - \[0:0\]</span>  
<span style="font-family:courier new;">\:OUTPUT ACCEPT
\[92376:20668252\]</span>  
<span style="font-family:courier new;">-A INPUT -m state --state
RELATED,ESTABLISHED -j ACCEPT</span>  
<span style="font-family:courier new;"># Accept SSH so we can manage the
VM  
-A INPUT -i eth0 -p tcp -m tcp --dport 22 -j ACCEPT</span>  
<span style="font-family:courier new;" /><span
style="font-family:courier new;">-A INPUT -i lo -j ACCEPT</span>  
<span style="font-family:courier new;"># Allow ping (Zenoss uses it to
see if you're up).</span>  
<span style="font-family:courier new;">-A INPUT -p icmp --icmp-type
echo-request -j ACCEPT</span>  
<span style="font-family:courier new;"># Allow SNMP.</span>  
<span style="font-family:courier new;">-A INPUT -p udp -s 0/0 --sport
1024:65535 --dport 161:162 -j ACCEPT</span>  
<span style="font-family:courier new;" /><span
style="font-family:courier new;"># Silently block NetBIOS because we
don't want to hear about Windows</span>  
<span style="font-family:courier new;">-A INPUT -p udp --dport 137:139
-j DROP</span>  
<span style="font-family:courier new;">-A INPUT -j LOGNDROP</span>  
<span style="font-family:courier new;"># Drop and log the rest.</span>  
<span style="font-family:courier new;">-A LOGNDROP -p tcp -m limit
--limit 5/min -j LOG --log-prefix "Denied TCP: " --log-level 7</span>  
<span style="font-family:courier new;">-A LOGNDROP -p udp -m limit
--limit 5/min -j LOG --log-prefix "Denied UDP: " --log-level 7</span>  
<span style="font-family:courier new;">-A LOGNDROP -p icmp -m limit
--limit 5/min -j LOG --log-prefix "Denied ICMP: " --log-level 7</span>  
<span style="font-family:courier new;">-A LOGNDROP -j DROP</span>  
<span style="font-family:courier new;">COMMIT</span>  
  
  
More on this later.



[1]: https://help.ubuntu.com/community/IptablesHowTo
