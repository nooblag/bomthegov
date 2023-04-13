# bomthegov Help

## Building timelapse videos

**bomthegov** can assemble basic timelapse videos from the images you have collected for a BOM identifier.

Images are collected in the 'images' folder, and are organised by image type, and then ID.

So for example: `images/radar/IDR023` ... `IDR024` ... and so on.

The folder structure is created depending on what you fetch, and you can fetch for as long as you like (or have disk space for).

All images in an image set will be used to build a timelapse. So for example, if you've collected an entire set of satellite images from the past 2 hours, and run the build timelapse command on that image set, your timelapse will be built of the files from those 2 hours. At the moment, **bomthegov** does not ignore any frames from a collected image set, so whatever images are in the 'images' folder for that ID, is what will be used to build your timelapse.

To begin the process of building a timelapse from a list of available images, you can run:

  `bash bomthegov timelapse list`

That will show you a list of IDs that are ready to timelapse, and ask you questions about what maximum resolution and Frames Per Second (FPS) rate you want the video to be.

If you know the ID of the image set, and you wish to timelapse right away from the command line (with resolution and FPS defaults), you can specify the ID to process, like so:

  `bash bomthegov timelapse IDR024`

and **bomthegov** will start building a timelapse for that ID immediately/uninteractively.



## Process

**bomthegov** uses the software package `imagemagick` to convert satellite and radar images into usable video frames, and then passes those frames to a video encoding tool called `ffmpeg` to assemble a timelapse video.

The conversion process is likely to be resource-intensive on RAM, CPU, and disk, and depending on how many images need to be converted to video frames, and their original resolution, building the timelapse video may take a long time.

Once a timelapse has been successfully created, **bomthegov** will notify you, and then ask if you would like to remove the ID from the timelapse list/move the collected image set to a folder called '.archive' so that your image collection for that same ID starts "fresh" for a new timelapse. Your previously collected images are not deleted during this process, they're simply compressed into an archive file (TAR), and moved to the '.archive' folder inside 'images' where you can either use/merge them again later, or delete them manually if you choose.

You can explore the archived images sets yourself here:

  `images/.archive/`

If you would like to 'clean up' all your stored image sets and archives to start from scratch, you can specify the 'reset' option:

  `bash bomthegov reset`

which will delete everything in 'images' (including the '.archive' folder).

Previously prepared timelapse videos will not be deleted in a reset.



## Technical details

The default maximum video resolution and Frames Per Second (FPS) for timelapse videos is 1920x1080 (full HD) at 25fps.

All timelapse videos export to MP4 video format, which should make them streamable on the web, and viewable on mobile devices.

