Image sprint here was created using ImageMagick convert

To add a new image to the sprite complete the following two steps

    $ convert new_favico.png -bordercolor transparent -border 10 tmp.png

    $ convert favico_sprite.png tmp.png -append out.png

Then `out.png` is the new `favico_sprite.png`. Be sure added images are 16x16

Note: original sprite was created using:

    $ convert *.png -bordercolor transparent -border 10 -append out.png

But this will cause insertion and reindexing woes if its use is continued.

_And of course don't forget to crush the new png when done._
