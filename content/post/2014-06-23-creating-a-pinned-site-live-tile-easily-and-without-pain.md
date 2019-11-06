---
title: "Creating a Pinned Site Live Tile easily and without pain"
slug: "creating-a-pinned-site-live-tile-easily-and-without-pain"
wordpress_url: "http://www.ryanclarke.net/post/creating-a-pinned-site-live-tile-easily-and-without-pain/"
date: 2014-06-23T09:00:00-04:00
tags: ["Internet Explorer", "SEP", "Windows", "Windows Phone"]
categories: ["Technology"]
frameworks: ["Windows 8.1", "Windows Phone 8.1", "IE 11"]
description: "Get the value of an app live tile with a website. It's stupid easy and I included lots of links."

---

The list of things a developer must add to their website is constantly growing. I'm not talking about the big things; I'm talking about the little stuff that would be stupid to leave out. For instance, favicons were introduced by Internet Explorer 5 in 1999 (they made it into the HTML 4.01 recommendation later that year). Your site would function just as well without a favicon but you would be crazy not to have one. It's basically a requirement. The same thing goes for the description meta tag and apple-touch-icon, among others.

And now there's another one: Pinned Site Live Tiles as implemented by IE11 in Windows 8.1 and Windows Phone 8.1. Pinned SLTs (which I call "slivets") allows a website to have a series of beautiful images for the different sizes of Windows tiles and even allows the display of website information using some lovely built-in tile templates using a simple xml schema.

It's a little more involved than, say, a favicon but it's really not hard. Especially for the value you get. Microsoft has a lot of documentation to make this easy. What can be hard is finding the right page since it's not all in one place. Here are some links to help you avoid wasted time and pain.

### Quick start

[buildmypinnedsite.com](http://www.buildmypinnedsite.com "http://www.buildmypinnedsite.com")- This is the very first place you should go if you want slivets. This easy wizard will get you up and running in no time. You will probably want to replace the images with something more professional and customize the urls to match your site, but it quickly gives you something that's working and gives you a good place from which to start customizing. It's basically the File \> New of slivets. [Make a Windows 8.1 Pinned Live Tile for YOUR website in minutes](http://www.hanselman.com/blog/MakeAWindows81PinnedLiveTileForYOURWebsiteInMinutes.aspx "http://www.hanselman.com/blog/MakeAWindows81PinnedLiveTileForYOURWebsiteInMinutes.aspx") - I'm not going to give a complete how-to because Scott Hanselman already has and his is better than mine would be. He walks you through the wizard site above and explains what it all means.

### Designing

[Create live tiles for your websites in IE11](http://msdn.microsoft.com/en-us/library/ie/dn455115%28v=vs.85%29.aspx "http://msdn.microsoft.com/en-us/library/ie/dn455115%28v=vs.85%29.aspx") - This is the jumping off place to explore the Microsoft help for slivets. Start here with questions. 

[Pinned Sites](http://msdn.microsoft.com/en-us/library/ie/hh772707%28v=vs.85%29.aspx "http://msdn.microsoft.com/en-us/library/ie/hh772707%28v=vs.85%29.aspx") - This the jumping off place to explore the Microsoft API documentation for pinned sites including schemas for the browser config, for html meta tags, and the complete list of properties, methods and events used by the browser. This is really helpful for pulling off some cool and crazy website-to-slivet interactions with the variety of available javascript hooks. 

[The tile template catalog (Windows Runtime apps)](http://msdn.microsoft.com/en-us/library/ie/hh761491.aspx "http://msdn.microsoft.com/en-us/library/ie/hh761491.aspx") - You'll want to pick your tiles to fit the data you are displaying. This is the comprehensive list of all possible tiles with example xml and result photo to get you started. You should find several you like. Of course, you can make the tile look like whatever you want by simply picking the single photo template and generating the custom-formatted image yourself. But that would take more server infrastructure on your end and would risk making your tiles clash with the aesthetic of the OS. Still, the option is there.

### Debugging

[Build a live tile](http://msdn.microsoft.com/en-us/library/ie/dn439794%28v=vs.85%29.aspx "http://msdn.microsoft.com/en-us/library/ie/dn439794%28v=vs.85%29.aspx") - This starts out as Microsoft's how-to guide but important part is at the very bottom under "Testing and finding problems with live tiles." Slivets are designed to light up with whatever pieces are present and if they aren't there, fallback to normal behavior. This is really nice for end-users, but it can make development difficult because when something doesn't work, IE is quite taciturn about reasons. The tips at this link are simple but indispensable.

[Fiddler](http://www.telerik.com/fiddler "http://www.telerik.com/fiddler") - While we are on the topic of debugging, you pretty much have to have Fiddler to monitor the network traffic. This will tell you if the endpoints you defined are even being hit. I wasted a couple hours trying to solve a seemingly impossible problem with my slivets, but after I used Fiddler I solved the problem in minutes.

If you need any more help feel free to contact me. Of course, if you'd like to talk to someone who actually knows something, I've found Microsoft Program Managers [MattHidinger](https://twitter.com/MattHidinger "Twitter @MattHidinger") and [Jacob Rossi](https://twitter.com/jacobrossi "Twitter @jacobrossi") to be quick, friendly and very helpful.
