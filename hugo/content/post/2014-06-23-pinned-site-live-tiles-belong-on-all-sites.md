---
title: "Pinned Site Live Tiles belong on all sites"
slug: "pinned-site-live-tiles-belong-on-all-sites"
wordpress_url: "http://www.ryanclarke.net/post/pinned-site-live-tiles-belong-on-all-sites/"
date: "2014-06-23"
tags: ["Internet Explorer", "SEP", "Windows", "Windows Phone"]
categories: ["Technology"]
description: ""
featured: "featured"

---

Imagine if you could take your existing website and turn it into an app with minimal effort. Of course, that's impossible. But you *can* get 75%\* of the way there with an awesome new Internet Explorer feature I recently implemented on one of SEP's sites called Pinned Site Live Tiles.

### What are Pinned Site Live Tiles?

I am sure you are familiar with live tiles. They first came with the launch of Windows Phone and now are a defining feature of Windows 8+ as well. Live tiles allow apps that have been pinned to the user's start screen to update their tile with dynamically generated and presumably relevant information. Pinned SLTs (which I will now call slivets) bring that feature to Windows 8.1's IE11 when you pin a web link to the start screen. They basically transform a simple bookmark with a blurry favicon into something almost indistinguishable from a real app. Scott Hanselman wrote an [easy how-to guide](http://www.hanselman.com/blog/MakeAWindows81PinnedLiveTileForYOURWebsiteInMinutes.aspx "Make a Windows 8.1 Pinned Live Tile for YOUR website in minutes") on his blog.

But things just got better. Nestled deep within [Matt Hidinger](https://twitter.com/matthidinger "Twitter @MattHidinger")'s interesting "[Live Tiles Enhancements](http://channel9.msdn.com/Events/Build/2014/2-523 "MSDN Channel9")" talk from Microsoft's BUILD conference was a cool little revelation: slivets work on Windows Phone 8.1 as well as Windows 8.1. So now they work on all of Microsoft's desktop, tablet, and phone platforms.

### A Disclaimer

I guess it's worth mentioning that slivets only work when IE11 is the default browser. But that limitation doesn't matter since it won't affect your target audience. Anyone interested in apps, namely users of Windows tablets and Windows Phones, are almost certain to have IE as their default browser. And frankly, many desktop users never change their default browser away from IE.

### The Case for Pinned Site Live Tiles

Slivets work for almost the entire the app-inclined Windows user base and for all of Windows Phone users. This is a large market, and although currently perched at third place in worldwide market share, it is an underserved market too. Some may scoff at the size of this user base in comparison with Android and iOS. But anyone with a great website who wants apps is likely already going the Android/iOS route since they give the most bang for the many bucks it takes to build an app. That leaves just the Windows platforms in need of apps, and slivets fills those exact markets.

You can enable one of the signature Windows platforms' features just by adding a couple meta tags to your header and a few xml files. Who cares about bang vs. buck when the price is nearly free. In fact, it's so easy that even if you don't have iOS/Android apps you should still enable slivets, the same way you would be silly not to include an apple-touch-icon.

From now on, I plan to add slivets to all the websites I build unless it's unnecessary or technically impossible.

*Adding slivets to your site is not difficult, but there are some tricky situations that can waste your time if you don't know where to look for answers. I've included some more technical information and helpful tips in my companion article, "[How to create a Pinned Site Live Tile without pain](http://www.ryanclarke.net/post/creating-a-pinned-site-live-tile-easily-and-without-pain/ "How to create a Pinned Site Live Tile without pain")."*

\*Disclaimer: invented number.

