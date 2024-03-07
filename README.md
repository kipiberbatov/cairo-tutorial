# cairo-tutorial

Tutorial in C using the cairo graphics library
[https://www.cairographics.org](https://www.cairographics.org)

## Building on Unix-like platforms

Navigate to your preferred location on the command line. Type the following:

```
git clone https://github.com/kipiberbatov/cairo-tutorial
cd cairo-tutorial
make
```

To run demos, type `make demo`.

To clean object files, type `make clean`.

To clean all build files but not the build directory and its subdirectories, type `make distclean`.

To return to the original version of the repository, type `make default-repo`.

By default make will create a __build__ directory called **build**.
If you want to call it differently, say **my-build**, then you type
`make BUILD=my-build`.
In such a case you have to always type **BUILD=my-build** after **make**.
For instance, running demos will be `make BUILD=my-build demo`.

## License

This project uses the public-domain equivalent MIT-0 license.
This license is very similar to the BSD 0-clause license.
However, unlike the Unlicense it has copyright statement which should make
lawyers happy.

## What is it in this repository?

At the moment, there sare simple examples of text rendering for:

- PDF
- PNG
- SVG
