---
layout: post
title: Editing Screencasts in Linux
date: '2013-09-15T14:39:00.000-07:00'
author: Larry Reid
tags:
- video
modified_time: '2013-09-15T14:39:00.062-07:00'
blogger_id: tag:blogger.com,1999:blog-5778824359157275227.post-7123693775727106180
blogger_orig_url: http://technopragmatica.blogspot.com/2013/09/editing-screencasts-in-linux.html
---

My son wants to start putting titles on the Minecraft screencasts he makes. I had tried to use OpenShot to edit his screencasts a few months ago, but the quality degraded so much as to be useless.

I took some time this weekend to dig into the issue. Here's what I learned. But first, here's the tools I'm using.

We're using Linux Mint 13. We used to use RecordMyDesktop, the standard version that comes with the distro, to capture the raw screencast. Recently, I rolled my own screencaster. (More on that elsewhere.) For editing, I use OpenShot, again the version that comes with the distro.

Directly uploading the output of RecordMyDesktop to YouTube produces acceptable videos, so I was reasonably confident that RecordMyDesktop wasn't the problem. I suspected that the process of importing the screencast to OpenShot and then exporting it again was converting formats one or more times along with way, with the attendant loss of quality. So my first task was to figure out the input format.

With a bit of Googling, I found the command line tool that I needed: avprobe. Install the right package:
```
sudo apt-get install libav-tools
```
Then get the file information:
```
avprobe filename.ogv
```
The output I got was:
```
Input #0, ogg, from 'testing-5.ogv':
  Duration: 00:00:06.33, start: 0.000000, bitrate: 963 kb/s
  Stream #0.0: Data: skeleton
  Stream #0.1: Video: theora, yuv420p, 864x512 [PAR 1:1 DAR 27:16], 15 fps, 15 tbr, 15 tbn, 15 tbc
  Stream #0.2: Audio: vorbis, 22050 Hz, mono, s16, 89 kb/s
Unsupported codec with id 0 for input stream 0
```
Next, I opened OpenShot and created a new profile: Edit-> Preferences, then click on the "Profiles" tab, then click on the "Manage Profiles" button, then click on the plus sign to add a new profile. I made it look like this, and then clicked "Save":

![Profile](/assets/images/profile.png)

The output of avprobe didn't map exactly to what Openshot was looking for, so I had to guess a bit at what to fill in. I suspected that "PAR" from avprobe was the "Pixel Ratio" and that "DAR" was the "Aspect Ratio". The frame rate was "15 fps" (frames per second). The size was given by "864x512" in the avprobe output.

If you're doing your own video, note that the size is going to depend on the size of your Minecraft window when you captured the raw screencast, and also on whether you chose to capture the window border or not. And the aspect ratio will also change based on the size.

Next I created a new project selecting the profile I just created in the "Project Profile" field. Then I added clips and edited the video. Finally, I was ready to export.

I selected File-&gt; Export Video... and went straight to the "Advanced" tab. Then I changed the "Profile", "Video Settings", and "Audio Settings" to look like this:

![Advanced Tab](/assets/images/advanced.png)

Then I clicked "Export Video", and I had a video that would upload with acceptable quality to YouTube.
