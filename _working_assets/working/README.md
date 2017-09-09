working asset files
====

### `rss.svg`

standard image for rss feeds, free from
[icomoon](https://icomoon.io/app/#/select)

no real need to optimize

### `email.svg`

found on icomoon as well from a third party

```json
{
   "metadata": {
      "name": "Entypo",
      "url": "http://www.entypo.com/",
      "designer": "Daniel Bruce",
      "designerURL": "http://danielbruce.se/",
      "license": "CC BY-SA 3.0",
      "licenseURL": "http://creativecommons.org/licenses/by-sa/3.0/us/",
      "iconsHash": -993250148
   }
}
```

### `link.svg`

icon for anchor links etc

related files:

- `opt-link.svg` optimized image using <https://github.com/svg/svgo>
    - then converted to datauri using the same tool:

        svgo -i opt-link.svg -o - --datauri=unenc
- `stolen-link.svg` original file I worked from, lifted from iconic

### `prof.jpg`

source for headshot image

related files:

- `prof_thumb.jpg` resized and compressed

   convert prof.jpg -resize 110x -strip -quality 85% prof_thumb.jpg

### `sm_bg.jpg`

experimenting with degrading quality and size of `bg.jpg` for initial load

similar convert settings as with prof just more aggresive and adding

    -gaussian-blur 0.2

related filed:

- `qsm_bg.jpg` quite degraded

### `favicon.xcf`

gimp source file for favicon icon layers
