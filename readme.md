This quick script scrapes specified rain radar images from [BOM](http://www.bom.gov.au/).

It currently uses `curl` to fetch the images and `imagemagick` to make animated GIFs with resulting scrapes.

## Install

Make sure you have `curl` and `imagemagick` on your system:

```
sudo apt install curl imagemagick
```

Clone this repo and go into it:

```
git clone https://github.com/nooblag/bomthegov.git
cd bomthegov
```

## Usage

```
bash radars.sh
```

When you've had enough, interrupt the scraping by pressing CTRL + C and `imagemagick` will then try to build animated GIFs for each radar from whatever is scraped.
