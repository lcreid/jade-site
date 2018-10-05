---
layout: post
title: Changing Fonts on Linux Fillable PDF Forms
date: '2018-01-26T11:50:00.001-08:00'
author: Larry Reid
tags:
modified_time: '2018-01-26T11:50:12.496-08:00'
blogger_id: tag:blogger.com,1999:blog-5778824359157275227.post-6969417967636550956
blogger_orig_url: http://technopragmatica.blogspot.com/2018/01/changing-fonts-on-linux-fillable-pdf.html
---
I was trying to fill out the [Canadian passport renewal form](https://www.canada.ca/content/dam/ircc/migration/ircc/english/passport/forms/pdf/pptc054.pdf) on my Ubuntu 16.04 laptop. I was able to enter data into the fields just fine, but the font that was displayed after I left each field was almost unreadable.

I had seen this problem before with other fillable PDFs, like for example some from the Canadian Revenue Agency, so I decided it was time to figure out the problem.

I started by opening the form that was giving me grief, and clicked on File-> Properties, and then clicked on the Fonts tab. This gave me a list of fonts. Some of them were not the standard PDF fonts, as noted by the fact that it said "Not one of the standard 14 fonts." just below the font name.

(Background: The PDF specification says there are 14 standard fonts that should display the same, as much as possible, in any viewer.)

I recognized two of the fonts as likely being [monospaced](https://en.wikipedia.org/wiki/Monospaced_font "monospaced") fonts based on their names. Typically, forms designers use monospaced fonts for input because they can fit the text to pre-defined boxes on the form. I noticed that below the monospaced fonts, it said they were being substituted with "DejaVu Sans", which didn't sound like a monospaced font to me.

So I poked around on Google and found a few useful pages. From them, I figured out the following:

First, I put the following into `~/.config/fontconfig/conf.avail/69-courierstd-to-couriernew.conf`:
```
<?xml version="1.0"?>
<!DOCTYPE fontconfig SYSTEM "fonts.dtd">
<fontconfig>
  <match target="pattern">
    <test name="family">
      <string>CourierStd</string>
    </test>
    <edit name="family" mode="prepend">
      <string>Courier New</string>
    </edit>
  </match>
</fontconfig>
```
By putting it in that directory, I made it available but not enabled. To enable it, I made a symbolic link to it by doing:
```
ln -s ~/.config/fontconfig/conf.avail/69-courierstd-to-couriernew.conf ~/.config/fontconfig/conf.d
```

CourierStd was one of the fonts that was in the PDF form, and was being substituted with DejaVu Sans. I knew that Courier New was a font on my system because it shows up in Libre Office Writer and other programs that deal with fonts. So the contents of the file tell Linux to use Courier New when a document asks for CourierStd.

The way the fonts work on Ubuntu, it may take up to 30 seconds for the system to recognize the new substitution. After waiting for 30 seconds, I opened the passport renewal form again and voilà, I had Courier New on the fields I filled in.

The above works for the logged in user. If I had more than one user ID on my system, I might have put the same file in `/etc/fonts/conf.avail`, and linked to it from `/etc/fonts/conf.d`. That would make the substitution work for all users on the system.

From what I understand, other Linux distributions may store their fonts in different places. You can try to figure out where to put the file by reading `/etc/fonts/fonts.conf`.

The [Ubuntu wiki page on fonts](https://wiki.ubuntu.com/Fonts) is a good place to start if you want to learn more about fonts on Ubuntu.
