---
title: "In Praise of File > New > Project"
slug: "in-praise-of-file-new-project"
date: 2016-02-06T10:58:00-05:00
tags: ["SEP", "talk"]
categories: ["Technology"]
frameworks: []
description: ""
featured: ""
draft: true

---

*Have you ever read one of those books which promises to level up your dev skills but "I'm awesome, be like me" seems to be the author's main message? I'm sorry, this may be a post like that.*

They say you can learn a lot from failure. I believe we can learn more from success, that success has more potential lessons, if we would only be as reflective with success as with failure. Regardless, this post is about something that I believe I got really right and the resulting benefits.

I started a new project. That's it. I went into Visual Studio and clicked File. Then I hovered over New. Then I clicked Project. Within seconds I had an empty F# console project sitting open on my computer waiting for me to figure out what to put into it. This might be shocking, but...

## Starting a New Project is Easy.

It's so easy, shamefully easy. I have been wanting to learn F# for two years. Two. Years.

 * I've read Dave Fancher's excellent *The Book of F#*. 
 * I've watched conference talks.
 * I've read blog posts. 
 * I've watched user group talks.

I've spent entire months not starting a cool new project. I guess didn't want to feel "I know nothing about what I'm doing." It can be overwhelming. But it's also really fun to start from zero and build (and learn) something awesome.

I started the new project at about 7:10 at the local Code and Coffee meetup (7-9am every Thursday morning at SoHo Café, Carmel, IN). By the time I left I had some pattern matching parsing args. I love the initial rush of accomplishment and discovery; it's bizarre I can spent so many months avoiding that. Don't be like me.

Another thing you will find when you start a new side project: your...

## New Ideas Improve Your Other Projects.

The biggest thing I've taking from the F# shenanigans so far is the importance of referential transparency. An expression is referential transparent if all the functions in the expression are pure functions. A function is pure if it always returns the same result for a given input and if it has no observable side effects.

This last month at my day job I've been trying to write my C# methods to be more referentially transparent. Or at least not quite so opaque. Pure functions are just so much easier to test!

Additionally, I've been trying to keep state in a more immutable way. State is tricky to deal with, and if I can reduce the amount the state changes I can reduce my risk for errors.

My goal with all this is to write bug-free code. It's funny, because a lot of the code I'm writing write now is bug fixes and the accompanying refactorings. I believe that my recent fun foray into F# has helped my write better C# at work.

## So...

Starting a new project is easy, low risk, and pretty likely to have big rewards. Do it: File > New > Project today.

