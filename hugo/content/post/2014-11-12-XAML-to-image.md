---
title: "How to save a XAML view as an image"
slug: "XAML-to-image"
date: 2014-11-12T10:19:31-05:00
tags: ["SEP"]
categories: ["Technology"]
frameworks: ["Windows Phone 8", ".NET 4.5"]
description: "There are a number of little details which you must get right or you'll end up with a mess and the image will not look right."

---

I needed to take a xaml view and turn it into a bitmap. My Windows Phone app needed a live tile and the so I used `FlipTileData` with the `BackgroundImage` property set to my image URI. Almost every app has a tile so how hard can it be? Good news, it isn't hard! Here's how I turned the xaml view for my tile into the image I needed.

## We'll call this the starting point

Your xaml should be a `UserControl`, which works really well with `WriteableBitmap`'s `Render` method which takes a `UIElement` as it's first parameter. Then you call `SaveJpeg` on the bitmap and you've got an image.

Sounds simple, but there are a number of little details which you must get right or you'll end up with a mess and the image will not look right. In fact, in my original attempts at this tile it seemed like Windows Phone didn't understand basic xaml controls, like `Grid` and `StackPanel`. Scary.

## In which pixels matter for future reasons

Before we start writing all the super cool code, we need to get the tile dimensions right. I'll be showing a normal/medium sized square tile, so it's just 336 by 336 pixels. Wide tiles are 336 by 691, and the tiny tiles can't be live (so its dimensions are just mental cruft which I decided not to aquire). You will be putting this width and height as properties on your tile control's root xaml element. You will also be using them a lot of times in the code so we'll just 'save' them in a nice DRY place.

So we have the tile control newed up and we have the dimensions.

```
var tileControl = new MyTileControl();
var tileWidth = 336;
var tileHeight = 336;
```

## The beating heart of the essay

Then we need to tell the tile what size it should be, since the properties on the root xaml element don't fully do the job.

```
tileControl.Measure(new Size(tileWidth, tileHeight));
```

Here's the part I was missing. If we leave `Arrange` out the framework won't know what size we just set and will just assume that the tile has no size and will pile everything up into the top corner regardless of grids or anything else. This one takes a `Rect` (the first two parameters are the offset, so give it zeros).

```
tileControl.Arrange(new Rect(0, 0, tileWidth, tileHeight));
```

Now we can create the bitmap like I mentioned above. Of course, it needs to know the size too.

```
var bitmap = new WritableBitmap(tileWidth, tileHeight));
bitmap.Render(tileControl, null); // Don't need a transform
```

Don't forget to `Invalidate` the bitmap. This is just a scary but concise way to say, "please recalculate the entire thing one more time just to make sure everything isn't bonkers." It's a very important step, but oddly, this time it doesn't need to know the size!

```
bitmap.Invalidate();
```

## Once more in case you missed it

So here's the formula for success written all in one go.

```
var tileControl = new MyTileControl();
var tileWidth = 336;
var tileHeight = 336;

tileControl.Measure(new Size(tileWidth, tileHeight));
tileControl.Arrange(new Rect(0, 0, tileWidth, tileHeight));

var bitmap = new WritableBitmap(tileWidth, tileHeight));
bitmap.Render(tileControl, null);
bitmap.Invalidate();
```

## Finishing the deed

Then we just call `SaveJpeg` on the bitmap. It's not particularly interesting, mostly file-related stuff, but I'll include the code here just for completeness.

```
var filePath = "/Shared/ShellContent/MediumTile.jpg";

try
{
    using (var myStore = IsolatedStorageFile.GetUserStoreForApplication())
    using (var fileStream = new IsolatedStorageFileStream(filePath, FileMode.Create, myStore))
    {
        var tileQuality = 80; // 100 is best quality but large; don't go below 75
        // 0 is orientation: reserved for possible future use?!
        bitmap.SaveJpeg(fileStream, tileWidth, tileHeight, 0, tileQuality);
    }
}
catch (Exception ex)
{
    // do something
}
```

## Final disclaimers

That's pretty much it. Of course, there are a number of other things to make the code not crash in normal use. I double check that the jpeg write succeeded, I verify that the uri I give to the tile is valid. I have try-catches around all the dangerous code. I generate jpeg paths using a guid so I ensure the image gets recognized as new (and I delete all the old tile images to keep from using up space).

I hope this quick run-through helps you know all the different ways you have to set the size in the tile-making process.

