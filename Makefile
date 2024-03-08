################################## CONSTANTS ###################################
_cairo_cflags := $(shell pkg-config --cflags cairo)
_cairo_libs := $(shell pkg-config --libs cairo)
_gtk_cflags := $(shell pkg-config --cflags gtk+-3.0)
_gtk_libs := $(shell pkg-config --libs gtk+-3.0)

_build_dir := build

################################## VARIABLES ###################################
_bin :=
_object :=
_demo :=
_demo_gtk :=

################################### DEFAULT ####################################
.PHONY: all
all: link

################################## INITIALIZE ##################################
.PHONY: initialize
initialize:
	mkdir -p $(_build_dir)
	mkdir -p $(_build_dir)/bin
	mkdir -p $(_build_dir)/object
	mkdir -p $(_build_dir)/demo

##################################### GTK ######################################
$(_build_dir)/bin/cairo-gtk: $(_build_dir)/object/cairo-gtk.o
	$(CC) -o $@ $(_gtk_libs) $<

_bin += $(_build_dir)/bin/cairo-gtk

$(_build_dir)/object/cairo-gtk.o: src/cairo-gtk.c
	$(CC) -o $@ $(_gtk_cflags) -O2 -c $<

_object += $(_build_dir)/object/cairo-gtk.o

.PHONY: demo-gtk
demo-gtk: $(_build_dir)/bin/cairo-gtk
	$<

_demo_gtk += demo-gtk


$(_build_dir)/bin/cairo-gtk-shapes: $(_build_dir)/object/cairo-gtk-shapes.o
	$(CC) -o $@ $(_gtk_libs) $<

_bin += $(_build_dir)/bin/cairo-gtk-shapes

$(_build_dir)/object/cairo-gtk-shapes.o: src/cairo-gtk-shapes.c
	$(CC) -o $@ $(_gtk_cflags) -O2 -c $<

_object += $(_build_dir)/object/cairo-gtk-shapes.o

.PHONY: demo-gtk-shapes
demo-gtk-shapes: $(_build_dir)/bin/cairo-gtk-shapes
	$<

_demo_gtk += demo-gtk-shapes


$(_build_dir)/bin/cairo-gtk-click: $(_build_dir)/object/cairo-gtk-click.o
	$(CC) -o $@ $(_gtk_libs) $<

_bin += $(_build_dir)/bin/cairo-gtk-click

$(_build_dir)/object/cairo-gtk-click.o: src/cairo-gtk-click.c
	$(CC) -o $@ $(_gtk_cflags) -O2 -c $<

_object += $(_build_dir)/object/cairo-gtk-click.o

.PHONY: demo-gtk-click
demo-gtk-click: $(_build_dir)/bin/cairo-gtk-click
	$<

_demo_gtk += demo-gtk-click

##################################### PDF ######################################
$(_build_dir)/bin/cairo-pdf: $(_build_dir)/object/cairo-pdf.o
	$(CC) -o $@ $(_cairo_libs) $<

_bin += $(_build_dir)/bin/cairo-pdf

$(_build_dir)/object/cairo-pdf.o: src/cairo-pdf.c
	$(CC) -o $@ $(_cairo_cflags) -O2 -c $<

_object += $(_build_dir)/object/cairo-pdf.o

$(_build_dir)/demo/image.pdf: $(_build_dir)/bin/cairo-pdf
	$< "Hello, cairo!" $@

_demo += $(_build_dir)/demo/image.pdf

##################################### PNG ######################################
$(_build_dir)/bin/cairo-png: $(_build_dir)/object/cairo-png.o
	$(CC) -o $@ $(_cairo_libs) $<

_bin += $(_build_dir)/bin/cairo-png

$(_build_dir)/object/cairo-png.o: src/cairo-png.c
	$(CC) -o $@ $(_cairo_cflags) -O2 -c $<

_object += $(_build_dir)/object/cairo-png.o

$(_build_dir)/demo/image.png: $(_build_dir)/bin/cairo-png
	$< "Hello, cairo!" $@

_demo += $(_build_dir)/demo/image.png

##################################### SVG ######################################
$(_build_dir)/bin/cairo-svg: $(_build_dir)/object/cairo-svg.o
	$(CC) -o $@ $(_cairo_libs) $<

_bin += $(_build_dir)/bin/cairo-svg

$(_build_dir)/object/cairo-svg.o: src/cairo-svg.c
	$(CC) -o $@ $(_cairo_cflags) -O2 -c $<

_object += $(_build_dir)/object/cairo-svg.o

$(_build_dir)/demo/image.svg: $(_build_dir)/bin/cairo-svg
	$< "Hello, cairo!" $@

_demo += $(_build_dir)/demo/image.svg

################################### BUILDING ###################################
.PHONY: link
link: $(_bin)

.PHONY: compile
compile: $(_object)

.PHONY: demo
demo: $(_demo) $(_demo_gtk)

################################### CLEANING ###################################
.PHONY: clean
clean:
	-$(RM) $(_object)

.PHONY: distclean
distclean: clean
	-$(RM) $(_bin) $(_demo)

.PHONY: uninitialize
uninitialize: distclean
	-$(RM) -r $(_build_dir)
