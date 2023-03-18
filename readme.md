**bomthegov** is a tool that can fetch satellite images, or rain or wind radar images, from the Australien [sic] [Bureau of Meteorology (BOM)](http://www.bom.gov.au/) public archive, and build simple timelapse videos from the collected data.

It currently relies on `wget` to fetch the images from the public BOM FTP server, `imagemagick` and `ffmpeg` to make timelapse videos, and `dialog` to display pretty menus.

For the moment, it's also particular to Debian-based Operating Systems, prefers GNU `awk`, and probably a somewhat recent version of `bash`.

It's tested but unstable, and of course, a hacky hobby project, so use as beerware.

<br/>

# How to use this thing



## Install

Make sure you have the required software on your system:

```
sudo apt install git gawk wget curl imagemagick ffmpeg dialog
```

Clone this repo and go into it:

```
git clone https://github.com/nooblag/bomthegov.git
cd bomthegov
```

## Usage

```
bash bomthegov
```

will display a help screen to get you started.

<br />

More in-depth documentation can be explored inside the program, by running:

```
bash bomthegov help
```

or by [browsing](docs/readme.md) the 'docs' folder.

<br/>



## Quick Examples

List available satellites:

```
bash bomthegov satellite list
```

Print the list of available satellites as searchable text:

```
bash bomthegov satellite search
```

Fetch 2km resolution infrared/visual true-colour satellite images of Australia in [equirectangular projection](https://en.wikipedia.org/wiki/Equirectangular_projection) from the past 24 hours:

```
bash bomthegov satellite ide00406
```

Fetch the same as above, but narrow the query of images to only inside 10 minutes past 8pm UTC:

```
bash bomthegov satellite ide00406 20:1?
```

Make a timelapse video from that collected image set:

```
bash bomthegov timelapse ide00406
```
