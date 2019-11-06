---
title: "3 Reasons to Use F#"
slug: "3-reasons-to-use-f-sharp"
date: 2019-11-05T19:45:00-05:00
tags: ["SEP"]
categories: ["Technology"]
frameworks: ["F Sharp", ".NET"]
description: "In lieu of anything more objective, I will be using my opinions to explain why F# is such a wonderful language."
featured: "featured"

---

Picking the best programming language is difficult because we can’t just pick the one with the largest goodness number. Obviously, these objective goodness numbers are the easiest and most reliable way to find the best language, but someone neglected to assign them. Instead we individually convert our time slowly into experiences and our experiences into understanding and our understanding into opinions. Then we add these thoughtfully-honed opinions to all the other ones we’ve created in the heat of debate as the need arose.

So in lieu of anything more objective, I will be using my opinions to explain why [F#](https://fsharp.org/) is such a wonderful language. I will use reasons to support my claim that these are good opinions and not the flimsy kind.

### Predictable functions and safe data

Most of the programming I do involves editing, fixing and extending existing code. The ease at which I can create brand new software is less important than my ability to understand and adapt existing functionality and architecture. F#’s emphasis on pure functions and immutable data structures make F# easier to understand.

A function is pure if an input will always return the same output and it has no side-effects. This means it does not depend on any mutable state for determining its output and it does not change anything in the program or environment other than its return value. F#’s bias toward immutable values assists in that any value once set will never change. A data structure can be shared around knowing that one function will not change it out from other another function.

This may seem extreme to a programmer used to creating an object and updating its properties and fields as necessary, but the interdependencies that spread through reliance on shared mutable state quickly lead to tricky debugging sessions. And writing solid tests around a group of impure functions with mutable state can be onerous or even impossible. With pure functions, dependencies are easy to see and tests usually require simpler setup and can have better coverage.

Immutable data can be hard to handle at first because a shared object, if changed in a function, will not be changed in any other references since the change involves creating an altered copy and leaving the original as it was. This altered copy will only exist as the return value of the function which updated it. This aspect of immutable data forces program flow to be architected more like a railroad track than a bumper car rink. Think of most web backends: a single track for the request to the database and back with the response. The data is following a single path. Many business applications are like this. Obviously, there will be a lot of complexity in an application of any worth, but having the high-level architecture be this simple succession of functions returning new immutable pieces of state makes for highly reasonable and testable code. It makes for code that can be tweaked and extended with confidence.

Let me add that impure functions are necessary and mutable data can be convenient. F# is a very practical language and allows both of those things. Interacting with a database or filesystem, writing to logs and debug statements are no trouble with F# and the better you encapsulate the intrinsic impurity they add, the cleaner the rest of your program will be. A mutable value simply requires the `mutable` keyword and the compiler and tooling will assist and warn as necessary as you interact with it.

### Algebraic types for domain modeling

F# has a powerful algebraic type system. It’s called algebraic because it includes both sum and multiplicative types. Sum types say that a type could be this OR that, so all the possibilities of this are added to that. Multiple types say that a type can be this AND that, so all the possibilities of this are multiplied with that. Additionally, there are alias types that wrap one type in another. This algebraic way of combining types is very conducive for domain modeling.

F#’s alias types are wonderful for wrapping simple types in a more descriptive and compiler protected object. For instance, a string with an email address could be alias to `UnverifiedEmailAddress` and `VerifiedEmailAddress`. That way it couldn’t get used accidentally for the user name like it could with raw strings.

F#’s union types are useful for combining various states that can be quite diverse within a single type. For example, an `EmailAddress` type could be a union of `UnverifiedEmailAddress`, `VerifiedEmailAddress`, and `None`. When dealing with `EmailAddress` the compiler knows and enforces that you are handling the three valid options. This is far more expressive and safer than having an `emailAddress` string and a `isVerified` Boolean, either of which could be null, and which must be combined to figure out what the full story is. With the union types we are just summing together all the possibilities of `EmailAddress` into one compiler understood type.

Where union types provide a way to sum a type by saying it could be this OR that OR something else, record and tuple types allow multiplication by saying this type contains this AND that. I don’t have space to fully explore F#’s record and tuple types, and they really aren’t much different from a conventional class. But where many languages have a lot of syntax involved in creating a class (many of them conventionally giving each class definition its own file) F# makes it easy to create very expressive data structures in a few lines of code. It’s even further out of scope of this article, but F# also includes syntax for creating standard C# objects with inheritance, interfaces, attributes, virtual methods and all that jazz, if you should need the go fully-fledged into OO programming in the middle of an F# project.

The way these powerful sum and multiplicative types can be combined to build accurate domain models is best left to [Scott Wlaschin](https://fsharpforfunandprofit.com/) in his excellent book [_Domain Modeling Made Functional_](https://fsharpforfunandprofit.com/books/#domain-modeling-made-functional-ebook-and-paper). Many of the principles and techniques he describes in that book can be used in other languages (and probably should be!) but F# is particularly well suited, thanks to its type system, to domain modeling. I think this fact alone makes F# a first-choice language for business applications.

### .NET framework and ecosystem

Lastly, we come to the ecosystem. Without tooling and a full library of useful packages, a language is not going to get much use, and many great languages are left in this condition. But F# is built on the .NET framework and runs on .NET Core, which is open-source and available for all platforms, and backed by the full resources of Microsoft. Furthermore, F# comes with the ability to easily consume the vast collection of .NET packages, mostly written in C#, that have been collected in the Nuget package manager and elsewhere. And on top of that, there’s the interdimensional portals built right into F# that allow you to create and use real C# classes and methods inside F#.

### So F# is the best

Choosing to build with a functional programming language, despite the many benefits, can feel like a risky move. Functional languages can often get a bad reputation of being hard to use or poorly supported. But F#’s pragmatic approach gives the richness of a functional language with easy interdimensional portals back into the object-oriented world where desirable. And it is backed by the full variety and legacy of the .NET ecosystem. And on top of all that, It contains the very best mix of functional programming features including functions as first-class objects, immutable data by default, algebraic data types, and many more that I haven’t mentioned. For a deeper look at five of these F# features, check out David Inman’s clear and detailed article [Best Reasons to Learn F#](https://www.sep.com/sep-blog/2019/10/03/best-reasons-for-learning-f/).

Comparing F# to all the other languages is outside the scope of this article, but I believe that this unique set of features clearly positions F# in the elite group of best languages. I would enthusiastically use it on a new piece of software. In my very good and not flimsy opinion, it is the very best programming language.
