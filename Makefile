################################## CONSTANTS ###################################
_cairo_cflags := $(shell pkg-config --cflags cairo)
_cairo_libs := $(shell pkg-config --libs cairo)
_gtk_cflags := $(shell pkg-config --cflags gtk+-3.0)
_gtk_libs := $(shell pkg-config --libs gtk+-3.0)

_build_dir := build

################################## VARIABLES ###################################
_bin :=
_object :=
_demo_static :=
_log :=

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
	mkdir -p $(_build_dir)/log

##################################### GTK ######################################
$(_build_dir)/bin/cairo-gtk: $(_build_dir)/object/cairo-gtk.o
	$(CC) -o $@ $(_gtk_libs) $<

_bin += $(_build_dir)/bin/cairo-gtk

$(_build_dir)/object/cairo-gtk.o: src/cairo-gtk.c
	$(CC) -o $@ $(_gtk_cflags) -O2 -c $<

_object += $(_build_dir)/object/cairo-gtk.o

$(_build_dir)/log/cairo-gtk.log: $(_build_dir)/bin/cairo-gtk
	$<
	printf "This file was created after running %s\n" \
	  $(_build_dir)/bin/cairo-gtk > $@
	printf "Creation time: " >> $@
	echo $(shell date -u) >> $@

_log += $(_build_dir)/log/cairo-gtk.log


$(_build_dir)/bin/cairo-gtk-shapes: $(_build_dir)/object/cairo-gtk-shapes.o
	$(CC) -o $@ $(_gtk_libs) $<

_bin += $(_build_dir)/bin/cairo-gtk-shapes

$(_build_dir)/object/cairo-gtk-shapes.o: src/cairo-gtk-shapes.c
	$(CC) -o $@ $(_gtk_cflags) -O2 -c $<

_object += $(_build_dir)/object/cairo-gtk-shapes.o

$(_build_dir)/log/cairo-gtk-shapes.log: $(_build_dir)/bin/cairo-gtk-shapes
	$<
	printf "This file was created after running %s\n" \
	  $(_build_dir)/bin/cairo-gtk-shapes > $@
	printf "Creation time: " >> $@
	echo $(shell date -u) >> $@

_log += $(_build_dir)/log/cairo-gtk-shapes.log


$(_build_dir)/bin/cairo-gtk-click: $(_build_dir)/object/cairo-gtk-click.o
	$(CC) -o $@ $(_gtk_libs) $<

_bin += $(_build_dir)/bin/cairo-gtk-click

$(_build_dir)/object/cairo-gtk-click.o: src/cairo-gtk-click.c
	$(CC) -o $@ $(_gtk_cflags) -O2 -c $<

_object += $(_build_dir)/object/cairo-gtk-click.o

$(_build_dir)/log/cairo-gtk-click.log: $(_build_dir)/bin/cairo-gtk-click
	$<
	printf "This file was created after running %s\n" \
	  $(_build_dir)/bin/cairo-gtk-click > $@
	printf "Creation time: " >> $@
	echo $(shell date -u) >> $@

_log += $(_build_dir)/log/cairo-gtk-click.log

##################################### PDF ######################################
$(_build_dir)/demo/image.pdf: $(_build_dir)/bin/cairo-pdf
	$< "Hello, cairo!" $@

_demo_static += $(_build_dir)/demo/image.pdf

$(_build_dir)/bin/cairo-pdf: $(_build_dir)/object/cairo-pdf.o
	$(CC) -o $@ $(_cairo_libs) $<

_bin += $(_build_dir)/bin/cairo-pdf

$(_build_dir)/object/cairo-pdf.o: src/cairo-pdf.c
	$(CC) -o $@ $(_cairo_cflags) -O2 -c $<

_object += $(_build_dir)/object/cairo-pdf.o

# animation
# $(_build_dir)/demo/animation.pdf.mkv: \
# 	     $(_build_dir)/log/cairo-pdf-animation.log
# 	   ffmpeg -f image2 -i $(_build_dir)/demo/animation_%3d.pdf -vcodec copy $@

# _demo_static += $(_build_dir)/demo/animation.pdf.mkv

$(_build_dir)/log/cairo-pdf-animation.log: $(_build_dir)/bin/cairo-pdf-animation
	$< $(_build_dir)/demo/animation
	printf "This file was created after running %s\n" \
	  $(word 2, $^) > $@
	printf "Creation time: " >> $@
	echo $(shell date -u) >> $@

_log += $(_build_dir)/log/cairo-pdf-animation.log

$(_build_dir)/bin/cairo-pdf-animation: $(_build_dir)/object/cairo-pdf-animation.o
	$(CC) -o $@ $(_cairo_libs) $<

_bin += $(_build_dir)/bin/cairo-pdf-animation

$(_build_dir)/object/cairo-pdf-animation.o: src/cairo-pdf-animation.c
	$(CC) -o $@ $(_cairo_cflags) -O2 -c $<

_object += $(_build_dir)/object/cairo-pdf-animation.o

##################################### PNG ######################################
$(_build_dir)/bin/cairo-png: $(_build_dir)/object/cairo-png.o
	$(CC) -o $@ $(_cairo_libs) $<

_bin += $(_build_dir)/bin/cairo-png

$(_build_dir)/object/cairo-png.o: src/cairo-png.c
	$(CC) -o $@ $(_cairo_cflags) -O2 -c $<

_object += $(_build_dir)/object/cairo-png.o

$(_build_dir)/demo/image.png: $(_build_dir)/bin/cairo-png
	$< "Hello, cairo!" $@

_demo_static += $(_build_dir)/demo/image.png


# animation
$(_build_dir)/demo/animation.gif: \
	     $(_build_dir)/log/cairo-png-animation.log
	   ffmpeg -i build/demo/animation_%3d.png $@

_demo_static += $(_build_dir)/demo/animation.gif

$(_build_dir)/log/cairo-png-animation.log: $(_build_dir)/bin/cairo-png-animation
	$< $(_build_dir)/demo/animation
	printf "This file was created after running %s\n" \
	  $(_build_dir)/bin/cairo-png-animation > $@
	printf "Creation time: " >> $@
	echo $(shell date -u) >> $@

_log += $(_build_dir)/log/cairo-png-animation.log

$(_build_dir)/bin/cairo-png-animation: $(_build_dir)/object/cairo-png-animation.o
	$(CC) -o $@ $(_cairo_libs) $<

_bin += $(_build_dir)/bin/cairo-png-animation

$(_build_dir)/object/cairo-png-animation.o: src/cairo-png-animation.c
	$(CC) -o $@ $(_cairo_cflags) -O2 -c $<

_object += $(_build_dir)/object/cairo-png-animation.o

##################################### SVG ######################################
$(_build_dir)/bin/cairo-svg: $(_build_dir)/object/cairo-svg.o
	$(CC) -o $@ $(_cairo_libs) $<

_bin += $(_build_dir)/bin/cairo-svg

$(_build_dir)/object/cairo-svg.o: src/cairo-svg.c
	$(CC) -o $@ $(_cairo_cflags) -O2 -c $<

_object += $(_build_dir)/object/cairo-svg.o

$(_build_dir)/demo/image.svg: $(_build_dir)/bin/cairo-svg
	$< "Hello, cairo!" $@

_demo_static += $(_build_dir)/demo/image.svg

# animation
# $(_build_dir)/demo/animation.svg.mkv: \
# 	     $(_build_dir)/log/cairo-svg-animation.log
# 	   ffmpeg -f image2 -i $(_build_dir)/demo/animation_%3d.svg -vcodec copy $@
#
# _demo_static += $(_build_dir)/demo/animation.svg.mkv

$(_build_dir)/log/cairo-svg-animation.log: $(_build_dir)/bin/cairo-svg-animation
	$< $(_build_dir)/demo/animation
	printf "This file was created after running %s\n" \
	  $(word 2, $^) > $@
	printf "Creation time: " >> $@
	echo $(shell date -u) >> $@

_log += $(_build_dir)/log/cairo-svg-animation.log

$(_build_dir)/bin/cairo-svg-animation: $(_build_dir)/object/cairo-svg-animation.o
	$(CC) -o $@ $(_cairo_libs) $<

_bin += $(_build_dir)/bin/cairo-svg-animation

$(_build_dir)/object/cairo-svg-animation.o: src/cairo-svg-animation.c
	$(CC) -o $@ $(_cairo_cflags) -O2 -c $<

_object += $(_build_dir)/object/cairo-svg-animation.o

################################### BUILDING ###################################
.PHONY: link
link: $(_bin)

.PHONY: compile
compile: $(_object)

.PHONY: demo-static
demo-static: $(_demo_static)

.PHONY: log
log : $(_log)

.PHONY: demo
demo: demo-static log

################################### CLEANING ###################################
.PHONY: clean
clean:
	-$(RM) $(_object)

.PHONY: distclean
distclean: clean
	-$(RM) $(_bin) $(_demo_static) $(_log) $(_build_dir)/demo/animation*

.PHONY: uninitialize
uninitialize: distclean
	-$(RM) -r $(_build_dir)
