# bomthegov Help

**bomthegov** is a tool that can fetch [satellite](satellite.md) images, or [rain or wind radar](radar.md) images, from the Australien [sic] [Bureau of Meteorology (BOM)](http://www.bom.gov.au/) public archive, and build simple [timelapse](timelapse.md) videos from the collected data.



## Usage

**bomthegov** is written in `bash` and hence accepts arguments in a hierarchy, like so:

Usage: `bash bomthegov <option> <arguments> ...`

##### Available options:

| Option    | Description                                       |
| --------- | ------------------------------------------------- |
| satellite | Collect images from a satellite.                  |
| radar     | Collect images from a radar.                      |
| timelapse | Generate a timelapse video from collected images. |
| reset     | Delete all collected images, and archives.        |
| update    | Download and apply latest version of bomthegov.   |
| debug     | Turn on/off code debug logging.                   |
| version   | Display version information.                      |

Specifying a option from that list will set up **bomthegov** to do those different things.

Most options in the above list require further user input, called 'arguments.' Most options have help articles in the 'docs' folder that explain their operation in more detail, or you can access help by specifying the argument `help` after the option name. For example:

  `bash bomthegov satellite help`

will display the help file pertaining to the `satellite` option.

If an option requires arguments, but arguments have not been provided, **bomthegov** should help you by listing what arguments are available to build a successful command.



## How does this thing work?

The Australien [sic] Bureau of Meteorology (BOM) publishes various satellite images, and rain and wind radar images, on its [public FTP server](http://www.bom.gov.au/catalogue/anon-ftp.shtml). The images are organised by identifiers (IDs).

**bomthegov** is a simple tool that takes your input, and builds a query for the BOM server, returns any matches, and fetches/downloads the files.

Files are collected in the 'images' folder, and are organised by image type, and then ID.

So for example: `images/radar/IDR023` ... `IDR024` ... and so on.

The folder structure is created depending on what you fetch.

You can run a fetch command many times, and only the most recent images will be fetched. In fact, **bomthegov** is designed to be able to run as an automated task, so that you can fetch new images at regular intervals, without causing too much disk or network inrush.

Once you have collected some images, you can build a timelapse video from that collection.

To list what image sets are available to make a timelapse, you can run:

  `bash bomthegov timelapse list`

which, will show you a list of IDs that are ready to turn into timelapse videos.

