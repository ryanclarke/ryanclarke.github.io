---
title: "XAML to image"
slug: "XAML-to-image"
date: 2014-09-10T13:46:31-04:00
tags: ["SEP"]
categories: ["Technology"]
description: ""
draft: true

---

I added a live tile to the Windows Phone app I'm building. That may not sound like much since almost every app has a live tile, but it's not as straight-forward as I thought.

Windows Phone 8 tiles will display whatever images you specify. I wanted a simple tile so I used the `FlipTileData` with the `BackgroundImage` set to my image URI.

Creating an image out of xaml is not too hard either. Your tile xaml should be a `UserControl`, which works really well with `WriteableBitmap`'s `Render` method which takes a `UIElement` as it's first parameter. Then you call `SaveJpeg` on the bitmap and you've got an image.

The plot just outlined is simple, but there are a number of little details which you must get right or your image will not look right. In fact, when I left them out in my original attempts at this tile it seemed like Windows Phone didn't understand basic xaml controls, like `Grid` and `StackPanel`.

Before we start you need to get the tile dimensions right. I'll be showing a normal/medium sized square tile, so it's just 336 by 336 pixels. Wide tiles are 336 by 691, and the tiny tiles can't be live. You will be putting this width and height as properties on your tile control's root xaml element. You will also be using them a lot of times in the code.

So we have the tile control newed up and we have the dimensions.

```
var tileControl = new MyTileControl();
var tileWidth = 336;
var tileHeight = 336;
```

Then we need to tell the tile what size it should be, since the properties on the root xaml element don't fully do the job.

```
tileControl.Measure(new Size(tileWidth, tileHeight));
```

Here's the part I was missing. If you leave this out the framework won't know what size we just set and will just assume that the tile has no size and will pile everything up into the top corner regardless of grids or anything else. This one takes a `Rect` (the first two parameters are the offset, so give it zeros).

```
tileControl.Arrange(new Rect(0, 0, tileWidth, tileHeight));
```

Now can create the bitmap like I mentioned above. Of course, it needs to know the size too.

```
var bitmap = new WritableBitmap(tileWidth, tile Height));
bitmap.Render(this, null); // Don't need a transform
```

Don't forget to `Invalidate` the bitmap. This is just a scary way to say, please recalculate the entire thing just one more time just to make sure everything isn't bonkers. It's a very important step, but oddly, it doesn't need to know the size again!

```
bitmap.Invalidate();
```

Then you just call `SaveJpeg` on the bitmap. It's not particularly interesting, it's mostly file-related stuff anyway, but I'll include the code here just for completeness.

```
var filePath = "/Shared/ShellContent/MediumTile.jpg";

try
{
    using (var myStore = IsolatedStorageFile.GetUserStoreForApplication())
    using (var fileStream = new IsolatedStorageFileStream(filePath, FileMode.Create, myStore))
    {
        var tileQuality = 80; // 100 is best; don't go below 75
        // 0 is orientation: reserved for possible future use?!
        bitmap.SaveJpeg(fileStream, tileWidth, tileHeight, 0, tileQuality);
    }
}
catch (Exception ex)
{
    // do something
}
```

That's pretty much it. Of course, there are a number of other things to make the code not crash in normal use. I double check that the jpeg write succeeded, I verify that the uri I give to the tile is valid. I have try-catches around all the dangerous code. I generate jpeg paths using a guid so I ensure the image gets recognized as new (and I delete all the old tile images to keep from using up space).

I hope this quick run-through helps you know all the different ways you have to set the size in the tile-making process.

