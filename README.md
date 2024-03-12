# cairo-tutorial

Tutorial in C using the Cairo graphics library
[https://www.cairographics.org](https://www.cairographics.org)

Tthis tutorial is for Unix-like platforms.

## Dependencies

This project depend on the following C libraries
(they may be already present on your system):

- Cairo [https://www.cairographics.org](https://www.cairographics.org)
- GTK 3 [https://docs.gtk.org/gtk3/](https://docs.gtk.org/gtk3/)

It is also assumed that the pkg-config utility is installed:
[https://www.freedesktop.org/wiki/Software/pkg-config/](https://www.freedesktop.org/wiki/Software/pkg-config/)

## Building on Unix-like platforms

Navigate to your preferred location on the command line. Type the following:

```
git clone https://github.com/kipiberbatov/cairo-tutorial
cd cairo-tutorial
make initialize
make
```

`make initialize` will create **build** directoriy and its subdirectories
**bin**, **demo**, **log**, **object**.

Running `make` will create object files in **build/object** and
executables in **build/bin**.

To run demos, type `make demo`.
This will create static files (PDF, PNG, SVG) in **build/demo**
and will run GTK applications.
For any GTK window, after closing it,
a log file in **build/log** will be created.
This assures that GTK demos will not be rerun on subsequent `make demo`.

To clean object files and log files, type `make clean`.

To clean all build files but not the build directory and its subdirectories,
type `make distclean`.

To return to the original state of the repository, type `make uninitialize`.

By default `make initialize` will create a build directory called **build**.
If you want to call it differently, say **my-build**,
then you type `make _build_dir=my-build initialize`.
In such a case you have to always type **_build_dir=my-build** after **make**.
For instance, building the project will be `make _build_dir=my-build`,
while running demos will be `make _build_dir=my-build demo`

## License

This project uses the public-domain equivalent MIT-0 license.
This license is very similar to the BSD 0-clause license.
However, unlike the Unlicense, it has a copyright statement.
(As far as I know, this is better for legal purposes.)

## What is it in this repository?

This repository contains various vector graphics examples
targeting the following backends:

- GTK
- PDF
- PNG
- SVG

Animations are done via multi-page PDFs (one frame per page) or via GTK.
Unfortunately, to my knowledge, Cairo is unable to render SVG animations.
It is possible to do PNG images and to combine them with ffmpeg.
However, this project is about vector graphics.
Hence, I decided that there is no point of making GIFs or MP4 movies.
