---
layout: post
title: Showing Lists of Events in Drupal 6
date: '2009-04-17T16:10:00.000-07:00'
author: Larry Reid
tags:
- Drupal
- PAC
modified_time: '2009-07-14T10:43:04.290-07:00'
blogger_id: tag:blogger.com,1999:blog-5778824359157275227.post-1329450578866534961
blogger_orig_url: http://technopragmatica.blogspot.com/2009/04/showing-lists-of-events-in-drupal-6.html
---

I wanted to have a page in Drupal that showed upcoming events for the
Parent Advisory Council of my son's school, with a tab making it easy to
show past events. The idea was to have one place to go to find out about
upcoming events, or to find previous events so you could get materials
from the event (e.g. handouts provided by speakers).  
  
Drupal has a pretty good module for showing calendars, but it shows them
on day, week or month views in a calendar. My users wanted to see a list
of events. Our events are more spread out, so a list or table view is
actually easier to work with.  
  
So to summarize, we want:  
<ul><li>A menu in Drupal's primary menu for "Events"</li><li>The menu
takes the user to a page that shows upcoming (in the future)
events</li><li>There is a tab on the page for "All Events". Clicking the
tab shows all events, paged with 20 events per page</li><li>There is
also a tab for "Upcoming Events". Clicking it takes you back to just the
future events</li><li>Events have to have a start and end time, and may
have an additional description and attachments (e.g. agenda, minutes,
hand-outs)  
</li></ul>The high level overview of what I did is:  
<ol><li>Install and enable some contributed modules</li><li>Create a
"content type" for events. This defines what information you're going to
store for each event</li><li>Define a "view" and two "displays" for the
view. The view and its displays are partly a query of the information
you want to appear, and partly the definition of the menus that get you
to the information. The format of the information is defined by your
theme, which I won't talk about in this post</li><li>Put the menu in the
right place</li><li>Create some events and test it out. Testing is
really important. It's almost impossible to get this right the first
time</li></ol>A small warning before you get started: The smallest error
in anything can lead to very bizarre behaviour, or simply to some part
of the page not showing up, with no apparent connection to the error. It
took me days to get this working (with a lot of side-tracks into Drupal
esoterica). Don't expect to get it right the first time, even with
detailed instructions.  
  
Here's what I did. I don't guarantee that I've covered every single
thing, so please let me know by commenting on this story if I missed
anything. (I assume you know how to do Drupal basics like install
modules.)  
<ol><li>Install the Content Creation Kit (CCK), Views, Date, and
Advanced Help modules. Date module version 6.x.2.1 won't work for the
use case we're trying to implement. The filter relative to a date (e.g.
"now") is broken, which means you won't be able to show upcoming events.
Use date-6.x-2.x-dev (see [http://drupal.org/node/426990][1]) until the
fix gets rolled into the release version  
</li><li>Enable the "Content" part of CCK</li><li>Enable all parts of
Date <span style="font-style: italic;">except</span> "Date Locale" and
"Date Tools", unless you want them for other reasons. Also, if you're
running on PHP5 you don't need "Date PHP4"</li><li>Enable the "Views"
and "Views UI" parts of Views</li></ol>Now, create the content type for
events:  
<ol><li>Administration-> Content Management-> Content
Types</li><li>Click on the "Add content type" link at the top of the
"Content types" area</li><li>Enter the name "Event" and type "event".
There are many options to set, and the help text is pretty
self-explanatory. Under "Workflow settings", "Attachments", make sure
they're enabled (since we said that was a goal of what we're doing).
Most of the other options depend on your needs, although under "Workflow
settings" it's likely you'll want to turn off "Promoted to front page"
under "Default options"</li><li>Click the "Save content type" button at
the bottom of the page</li><li>Click on "Manage fields" beside the Event
content type</li><li>Under "Add", "Existing field", select "Datetime:
field\_event\_datetime..." You may have to scroll down to see the
existing fields. If you don't see an existing field called
"field\_event\_datetime", then create one under "Add", "New field"  
</li><li>Click "Save"</li><li>You will be presented with another page
allowing you to set a bunch of options. Set them according to your
needs</li><li>Click "Save"</li></ol>Now create the view. You really
should read the Drupal Views documentation, which you have available
because you installed the Advanced Help module. Read it now. Click on
Administer-> Site building-> Views and you'll be given a link to the
documentation near the top of the "Views" area  
  
Now, here's my summary of what's important in the Views documentation:  
<ul><li>A view can have several displays. The display determines where
the view is seen, and can also override some parts of the view's default
settings. In the rest of this post, I use "view" and "display" in these
specific meanings  
</li><li>Set up the common aspects of the view first in the Default
display. In our case, that means the output format (a table), the fields
to be viewed, and some of the filters</li><li>Be very careful when
editing non-default displays to click "Override" before editing anything
that you want to be unique to the display. If you don't explicitly click
"Override", you'll change the default which will affect other displays
that use the default value  
</li></ul>So what we have to do is:  
<ol><li>Create the view</li><li>Set up the default for the view the way
we want it</li><li>Create a "Page" display for the "Upcoming Events"
tab</li><li>Move the menu to the right place</li><li>Enter some test
events</li><li>Check that the "Upcoming Events" tab works  
</li><li>Create another "Page" display for the "All Events"
tab</li><li>Check that the "All Events" tab works  
</li></ol>Here are the steps:  
<ol><li>Administer-> Site building-> Views</li><li>Click the "Add" link
at the top of the "Views" area</li><li>Put "event\_list" in the "View
name" field, and "Event List" in the "View tag"</li><li>Make sure the
"View type" is node and click "Next"</li><li>This brings you to the
Views UI page. I found this page to be extremely unintuitive. You have
to be patient and always remember to scroll down after clicking on
something, because many links simply change what's displayed below
what's likely visible when you click on the link</li></ol>Set the
defaults for the view:  
<ol><li>Under "Basic Settings", click "Unformatted" under "Style".
Scroll down. You'll see some radio buttons. Click "Table" and click
"Update". Ignore the error message that appears about no fields defined.
We'll get to that later  
</li><li>Beside ""Use pager", click "No". Scroll down. Select the "Mini
pager" radio button and click "Update"</li><li>Beside "More link", click
"No". Scroll down. Select the "Create more link" check box and click
"Update"</li><li>Under "Fields", click on the "+" beside
"Fields"</li><li>Scroll down. Click on the check boxes for "Content:
Event Dat and Time... From date". <span style="font-style:
italic;">Don't</span> check the box for the corresponding "To Date"
field. Both are included in the "From date". Click on the check boxes
for "Node: Body", "Node: Title", and "Upload: Attached files". Click
"Add"</li><li>You'll now be presented with a number of pages to allow
you to set options for each field. For "Event Date...", accept the
defaults by clicking "Update"</li><li>For "Node: Body", accept the
defaults by clicking "Update"</li><li>For "Node: Title", click the "Link
this field to its node" checkbox and click "Update"</li><li>For "Upload:
Attached file", click the "Link this field to download the file"
checkbox and click "Update"</li><li>Now, put the fields in the order you
want: Click the up and down arrows by "Fields". Scroll down. Drag
"Title" up to the top and click "Update"</li><li>Set the sort order: By
"Sort criteria", click the "+". Scroll down. Select "Content: Event date
and time" and click "Add"  
</li><li>In the next page, select "Ascending", so the next event will
appear at the top of the list. Click "Update"</li><li>Choose the nodes
you want to display, specifically the published event nodes. Click the
"+" beside "Filters". Scroll down. Select the checkbox for "Node:
Published" and "Node: Type" and click "Add"</li><li>On the page for
"Node: Published", click the "Yes" radio button and click
"Update"</li><li>On the "Node: Type" page, click the "Event" checkbox
under "Node type" and click "Update"</li><li>Click "Save". We have our
default view set up.</li></ol>Create the "Upcoming Events" page:  
<ol><li>Click the "Add Display" button (the drop down box above it
should read "Page" already)</li><li>Under "Basic settings", click on
"Page" beside "Name". Scroll down. Type in "Upcoming Events" and click
"Update"</li><li>Click on "None" beside Title. Scroll down. Click
"Override". Enter "Upcoming Events" and click "Update"</li><li>Under
"Page settings", click on "None" beside "Path". Scroll down. Enter
"events/upcoming\_events" and click "Update"</li><li>Click on "No menu"
beside "Menu". Scroll down. Select the "Default menu tab" radio button.
Enter "Upcoming Events" under "Title". Click "Update"</li><li>On the
next page, click on the "Normal menu item" radio button, and enter
"Events" under "Title". Click "Update"</li><li>Click on the work
"Filters". Scroll down. Click on "Override" and then "Update". This
overrides the filter selection but makes a copy of the two filters that
we set as default</li><li>Click on the "+" beside "Filters". Scroll
down. Click on the checkbox beside "Date: Date (node)". Make sure you
get the right one. There are three fields that start with "Date:". Click
"Add"</li><li>Scroll down until you see a heading that says "Date
field(s)". Select the checkbox beside "Content: Event Date and Time...
From date". Click "Update"</li><li>On the next page that appears, under
"Operator", pick "Is greater than or equal to". Under "Date default",
enter "now". Click "Update"  
</li><li> Click "Save". Note that after clicking "Save" you're again
editing the default settings, not the upcoming events display. Be
careful to select the display you mean to edit. I got that wrong lots of
times</li></ol>Set up the menus correctly:  
<ol><li>The above puts the menu under the site navigation menu. We want
it under the Primary Links menu. Click on Administer-> Site building->
Menus</li><li>Click on "edit" beside "Events"</li><li>Under the "Parent
item" heading, select "<primary>" from the drop-down list</primary>

</li><li>Click "Save". The "Events" menu will show up at the end of your
primary menu. Drag it to the appropriate place in the list and click
"Save configuration"</li></ol>Create an event to test what you have so
far:  
<ol><li>Go to "Create Content"</li><li>Click on "Event"</li><li>Enter an
event on the your current day or sometime in the future. It should be
self-evident how. Watch that you end date is after the start date. The
user interface doesn't automatically do it like some other programs do.
Click "Save"</li><li>Enter another event with a date in the past. Again,
make sure the end date is the same as the start date  
</li><li>Click on the "Events" menu on your primary menu. You should see
the one future event you just entered, but not the past event  
</li></ol>If the event doesn't show up, see the troubleshooting tips at
the end of this post.  
  
Create the "All Events" page:  
<ol><li>Click on Administer-> Site building-> Views</li><li>Select
"edit" for the "Event List"</li><li>Click the "Add Display" button (the
drop down box above it should read "Page" already)</li><li>Under "Basic
settings", click on "Page" beside "Name". Scroll down. Type in "All
Events" and click "Update"</li><li>Click on "None" beside Title. Scroll
down. Click "Override". Enter "All Events" and click
"Update"</li><li>Under "Page settings", click on "None" beside "Path".
Scroll down. Enter "events/all\_events" and click "Update"</li><li>Click
on "No menu" beside "Menu". Scroll down. Select the "Menu tab" radio
button. Enter "All Events" under "Title". Click "Update"</li><li> Click
"Save". Note that after clicking "Save" you're again editing the default
settings, not the upcoming events display </li></ol>Test again:  
<ol><li>Click on the "Events" menu</li><li>You should see the table with
the one future event. You should also see two tabs for "All Events" and
"Upcoming Events"</li><li>Click on "All Events". You should see both
events in the table</li><li>Click on "Upcoming Events". You should see
just the future event again</li></ol>Here are some troubleshooting tips:

<ul><li>If the events aren't sorting the way you think they should
according to the display's "Sort Criteria", click on the little gear
beside "Style" under "Basic Settings". Scroll down. If the radio button
under "Default Sort" is anything but "None", the sort here will override
the sort in "Sort Criteria". Click on the radio button beside
"None"</li><li>With the Date module circa March-April 2009, you have to
install a patch or you'll get error messages when creating events. Get
the patch [here][2] and how to install it is [here][3]  
</li><li>If the menu doesn't appear on the primary menu, or the tabs
don't appear, make sure the paths for each display are below the same
name as I showed above. In other words, the display paths should be of
the form "x/y" and "x/z", even though the user will never navigate to
"x"</li><li>Recheck <span style="font-style: italic;">all</span> your
settings. This is tedious but essential. In my experience, any one being
wrong can cause a mysterious and seemingly unrelated failure</li><li>Be
sure that you didn't accidentally change the defaults instead of
overriding them, or didn't accidentally override something that should
be taken from defaults. Values taken from the default display are in
<span style="font-style: italic;">italics</span> when looking at other
displays</li></ul>I hope this helps someone.



[1]: http://drupal.org/node/426990
[2]: http://drupal.org/node/409476#comment-1404814
[3]: http://drupal.org/node/409476#comment-1436100
