---
layout: post
title: Basic Tiny VM Part 1
date: '2008-03-25T22:25:00.000-07:00'
author: Larry Reid
tags:
- VMWare
- Zenoss
- Virtualization
- Ubuntu
- IT Infrastructure
modified_time: '2008-03-28T20:06:39.407-07:00'
blogger_id: tag:blogger.com,1999:blog-5778824359157275227.post-4057566093623251968
blogger_orig_url: http://technopragmatica.blogspot.com/2008/03/basic-tiny-vm-part-1.html
---

The basic tiny <span class="blsp-spelling-error"
id="SPELLING_ERROR_0">VM</span> needs:  
<ul><li><span class="blsp-spelling-error"
id="SPELLING_ERROR_1">Ubuntu</span> 6.06.1 Server (the basic install,
not LAMP)</li><li><span class="blsp-spelling-error"
id="SPELLING_ERROR_6">VMTools</span><span class="blsp-spelling-error"
id="SPELLING_ERROR_2" /></li><li><span class="blsp-spelling-error"
id="SPELLING_ERROR_2">SNMP</span> so you can monitor it (I'm using
[<span class="blsp-spelling-error"
id="SPELLING_ERROR_3">Zenoss</span>][1])  
</li><li>ssh so you can administer it  
</li><li><span class="blsp-spelling-error"
id="SPELLING_ERROR_4">ntp</span> as a client so it keeps time. For now
I'll sync to my existing <span class="blsp-spelling-error"
id="SPELLING_ERROR_5">ntp</span> server  
</li><li>basic firewall rules that allow the above</li></ul>Build an ISO
library in <span style="font-family:courier new;">/<span
class="blsp-spelling-error" id="SPELLING_ERROR_7">usr</span>/local/<span
class="blsp-spelling-error" id="SPELLING_ERROR_8">vmware</span>/<span
class="blsp-spelling-error" id="SPELLING_ERROR_9">ISOs</span></span>.
Put in the <span class="blsp-spelling-error"
id="SPELLING_ERROR_10">Ubuntu</span> CD and type:  
  
<span style="font-family:courier new;">mount /<span
class="blsp-spelling-error" id="SPELLING_ERROR_11">dev</span>/<span
class="blsp-spelling-error" id="SPELLING_ERROR_12">cdrom</span></span>  
<span style="font-family:courier new;"><span class="blsp-spelling-error"
id="SPELLING_ERROR_13">sudo</span> dd if=/<span
class="blsp-spelling-error" id="SPELLING_ERROR_14">dev</span>/<span
class="blsp-spelling-error" id="SPELLING_ERROR_15">cdrom</span>0
of=/usr/local/vmware/ISOs/Ubuntu-6.06.1.iso</span>  
  
The <span class="blsp-spelling-error"
id="SPELLING_ERROR_16">VMTools</span> <span class="blsp-spelling-error"
id="SPELLING_ERROR_17">ISOs</span> are in the <span
style="font-family:courier new;">/<span class="blsp-spelling-error"
id="SPELLING_ERROR_18">tmp</span>/<span class="blsp-spelling-error"
id="SPELLING_ERROR_19">vmware</span>-server-<span
class="blsp-spelling-error"
id="SPELLING_ERROR_20">distrib</span>/lib/<span
class="blsp-spelling-error"
id="SPELLING_ERROR_21">isoimages</span></span>:  
  
<span style="font-family:courier new;"><span class="blsp-spelling-error"
id="SPELLING_ERROR_22">sudo</span> <span class="blsp-spelling-error"
id="SPELLING_ERROR_23">cp</span> /<span class="blsp-spelling-error"
id="SPELLING_ERROR_24">tmp</span>/<span class="blsp-spelling-error"
id="SPELLING_ERROR_25">vmware</span>-server-<span
class="blsp-spelling-error"
id="SPELLING_ERROR_26">distrib</span>/lib/<span
class="blsp-spelling-error"
id="SPELLING_ERROR_27">isoimages</span>/\*.<span
class="blsp-spelling-error" id="SPELLING_ERROR_28">iso</span> /<span
class="blsp-spelling-error"
id="SPELLING_ERROR_29">usr</span>/local/<span
class="blsp-spelling-error" id="SPELLING_ERROR_30">vmware</span>/<span
class="blsp-spelling-error" id="SPELLING_ERROR_31">ISOs</span></span>  
  
Install <span class="blsp-spelling-error"
id="SPELLING_ERROR_32">VMTools</span>. [Here][2] are some good
instructions.  
  
<span style="font-family:courier new;"><span class="blsp-spelling-error"
id="SPELLING_ERROR_33">sudo</span> apt-get install ssh </span><span
style="font-family:courier new;"><span class="blsp-spelling-error"
id="SPELLING_ERROR_34">ntp</span>-simple</span><span
style="font-family:courier new;"> <span class="blsp-spelling-error"
id="SPELLING_ERROR_35">snmpd</span> <span class="blsp-spelling-error"
id="SPELLING_ERROR_36">snmp</span> </span>  
  
(<span class="blsp-spelling-error" id="SPELLING_ERROR_37"
style="font-family:courier new;">snmp</span> is the package that
contains <span class="blsp-spelling-error" id="SPELLING_ERROR_38"
style="font-family:courier new;">snmpconf</span>, which you need to set
up <span class="blsp-spelling-error" id="SPELLING_ERROR_39">snmp</span>,
and <span class="blsp-spelling-error"
id="SPELLING_ERROR_40">snmpwalk</span>, which is useful for debugging.) 

  
Configure the <span class="blsp-spelling-error"
id="SPELLING_ERROR_41">ntp</span> server. I've set up an <span
class="blsp-spelling-error" id="SPELLING_ERROR_42">ntp</span> server in
the <span class="blsp-spelling-error" id="SPELLING_ERROR_43">DNS</span>,
so I set the "server" line in <span style="font-family:courier
new;">/etc/<span class="blsp-spelling-error"
id="SPELLING_ERROR_44">ntp</span>.<span class="blsp-spelling-error"
id="SPELLING_ERROR_45">conf</span></span> to the following:  
  
<span style="font-family:courier new;">server <span
class="blsp-spelling-error" id="SPELLING_ERROR_46">ntp</span></span>  
  
And then restart <span class="blsp-spelling-error"
id="SPELLING_ERROR_47">ntp</span>:  
  
<span style="font-family:courier new;">/etc/init.d/ntp-server
restart</span>  
  
Run <span style="font-family:courier new;"><span
class="blsp-spelling-error"
id="SPELLING_ERROR_48">snmpconf</span></span> to set up <span
class="blsp-spelling-error" id="SPELLING_ERROR_49">SNMP</span>. That's
probably a whole post in itself.  
  
I'll do the firewall later. I've ignored my family for too long tonight.



[1]: http://www.zenoss.com/
[2]: http://communities.vmware.com/message/456990;jsessionid=C204FAF5712838C6C9D8633D63CF6EFD
