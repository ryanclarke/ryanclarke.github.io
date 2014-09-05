---
title: "Bending Linq-to-Entities to my will"
slug: "bending-linq-to-entities-to-my-will"
wordpress_url: "http://www.ryanclarke.net/post/bending-linq-to-entities-to-my-will/"
date: "2013-02-06"
tags: ["ASP.NET MVC", "C#", "Programming"]
categories: ["Technology"]
description: ""

---

I am building an ASP.NET MVC 4 application using Entity Framework as my ORM on top of an existing SQL Server database. This is model-first, not code-first. I am fairly new to Linq-to-Entities. Recently I ran into something that gave me many problems and I had great trouble finding any help online. I've now solved it, twice. This is my story. I have a view that need to display a list of Modules (as in, classroom teaching). Each Module belongs to a Unit, but each Unit can have many Modules. Each Module can have multiple Instructors, and each Instructor can teach many Modules. There is a ModuleInstructor table to join that relationship. Unit -1:N- Module -N:1- ModuleInstructor -1:N- Instructor EntityFramework has these for objects [unnecessary properties trimmed for brevity]:
Anyway, I wanted to display: UnitName, ModuleDate, Instructor(s) in a comma-separated list. My problem was that I had the hardest time getting Linq to get the Instructors, all I could retrieve was the ModuleInstructors which didn't have any of the Instructor information loaded.
My first solution was to modify the Module class to add another collection:
In the ModuleController I got everything except the Instructors, then the Instructors separately and for looped through inserting them into the collection.
According to LinqPad this take two SQL statements. Not too bad. It's not that much of strain on the server either because I don't have many Instructors and there are only 20 Modules being shown at any one time. However, I figured there must be a way to do it in one database call. Here's my new solution. I still loop through inserting Instructors into the Modules object's Instructor collection, but I get all the Instructors with everything else.   According to LinqPad it takes only SQL statement and it performs slightly faster that the first method. To be perfectly honest, I have trouble picturing exactly how this works and why, but it does. I am very happy that I stuck with the problem, coming back to it several times more until I got it "just right." My one question: is this the best way to do this or is there a still better way? Maybe I'll never know, but at least it's better that it was before. See [Linq-to-Entities with a many to many relationship](http://stackoverflow.com/questions/14742145/linq-to-entities-with-a-many-to-many-relationship "Linq-to-Entities with a many to many relationship - StackOverflow") on StackOverflow for more discussion regarding this problem.
