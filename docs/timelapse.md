# bomthegov Help

## Building timelapse videos

**bomthegov** can assemble basic timelapse videos from the images you have collected for a BOM identifier.

Images are collected in the 'images' folder, and are organised by image type, and then ID.

So for example: `images/radar/IDR023` ... `IDR024` ... and so on.

The folder structure is created depending on what you fetch, and you can fetch for as long as you like (or have disk space for).

All images in an image set will be used to build a timelapse. So for example, if you've collected an entire set of satellite images from the past 2 hours, and run the build timelapse command on that image set, your timelapse will be built of the files from those 2 hours. At the moment, **bomthegov** does not ignore any frames from a collected image set, so whatever images are in the 'images' folder for that ID, is what will be used to build your timelapse.

To see a list of available image sets that can be timelapsed, you can run:

  `bash bomthegov timelapse list`

If you know the ID of the image set you wish to timelapse right away, you can specify it, like so:

  `bash bomthegov timelapse IDR024`

and **bomthegov** will start building it immediately.


## Process

**bomthegov** uses the software package `imagemagick` to convert satellite and radar images into usable video frames, and then passes those frames to a video encoding tool called `ffmpeg` to assemble a timelapse video.

The conversion process is likely to be resource-intensive on RAM, CPU, and disk, and depending on how many images need to be converted to video frames, and their original resolution, building the timelapse video may take a long time.

Once a timelapse has been successfully created, **bomthegov** will notify you, and then move the collected image set to a folder called '.archive' so that your image collection for that same ID starts "fresh" for a new timelapse from now on. Your previously collected images are not deleted however, they're simply moved to the '.archive' folder inside 'images' where you can either use/merge them again later, or delete them manually if you choose.

You can explore the archived images sets yourself here:

  `images/.archive/`

If you would like to 'clean up' all your stored image sets and archives to start from scratch, you can specify the 'reset' option:

  `bash bomthegov reset`

which will delete everything in 'images' (including the '.archive' folder).

Previously prepared timelapse videos will not be deleted in a reset.


## Technical details

The "Frames Per Second" (FPS) for timelapse videos are currently set as follows:

  * Radar images timelapse at 10fps,
  * Satellite images timelapse at 25fps.

These rates may change in future versions of **bomthegov**.

Timelapse videos export to MP4 video format, with default settings that should make them streamable on the web, and viewable on mobile devices.

