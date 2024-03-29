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

##################################### RGB ######################################
$(_build_dir)/object/rgb.o: src/rgb.c include/rgb.h
	$(CC) -o $@ -iquote include -O2 -c $<

_object += $(_build_dir)/object/rgb.o

################################### CONTEXT ####################################
$(_build_dir)/object/context_draw_circle.o: src/context_draw_circle.c \
	  include/context_draw_circle.h
	$(CC) -o $@ $(_cairo_cflags) -iquote include -O2 -c $<

_object += $(_build_dir)/object/context_draw_circle.o

$(_build_dir)/object/context_fill.o: src/context_fill.c \
	  include/context_fill.h
	$(CC) -o $@ $(_cairo_cflags) -iquote include -O2 -c $<

_object += $(_build_dir)/object/context_fill.o

##################################### GTK ######################################
# cairo-gtk
$(_build_dir)/log/cairo-gtk.log: $(_build_dir)/bin/cairo-gtk
	$<
	printf "This file was created after running %s\n" \
	  ../bin/cairo-gtk > $@
	printf "Creation time: " >> $@
	echo $(shell date -u) >> $@

_log += $(_build_dir)/log/cairo-gtk.log

$(_build_dir)/bin/cairo-gtk: $(_build_dir)/object/cairo-gtk.o
	$(CC) -o $@ $(_gtk_libs) $<

_bin += $(_build_dir)/bin/cairo-gtk

$(_build_dir)/object/cairo-gtk.o: src/cairo-gtk.c
	$(CC) -o $@ $(_gtk_cflags) -O2 -c $<

_object += $(_build_dir)/object/cairo-gtk.o

# cairo-gtk-shapes
$(_build_dir)/log/cairo-gtk-shapes.log: $(_build_dir)/bin/cairo-gtk-shapes
	$<
	printf "This file was created after running %s\n" \
	  ../bin/cairo-gtk-shapes > $@
	printf "Creation time: " >> $@
	echo $(shell date -u) >> $@

_log += $(_build_dir)/log/cairo-gtk-shapes.log

$(_build_dir)/bin/cairo-gtk-shapes: $(_build_dir)/object/cairo-gtk-shapes.o
	$(CC) -o $@ $(_gtk_libs) $<

_bin += $(_build_dir)/bin/cairo-gtk-shapes

$(_build_dir)/object/cairo-gtk-shapes.o: src/cairo-gtk-shapes.c
	$(CC) -o $@ $(_gtk_cflags) -O2 -c $<

_object += $(_build_dir)/object/cairo-gtk-shapes.o

# cairo-gtk-click
$(_build_dir)/log/cairo-gtk-click.log: $(_build_dir)/bin/cairo-gtk-click
	$<
	printf "This file was created after running %s\n" \
	  ../bin/cairo-gtk-click > $@
	printf "Creation time: " >> $@
	echo $(shell date -u) >> $@

_log += $(_build_dir)/log/cairo-gtk-click.log

$(_build_dir)/bin/cairo-gtk-click: $(_build_dir)/object/cairo-gtk-click.o
	$(CC) -o $@ $(_gtk_libs) $<

_bin += $(_build_dir)/bin/cairo-gtk-click

$(_build_dir)/object/cairo-gtk-click.o: src/cairo-gtk-click.c
	$(CC) -o $@ $(_gtk_cflags) -O2 -c $<

_object += $(_build_dir)/object/cairo-gtk-click.o

# cairo-gtk-donut
$(_build_dir)/log/cairo-gtk-donut.log: $(_build_dir)/bin/cairo-gtk-donut
	$<
	printf "This file was created after running %s\n" \
	  ../bin/cairo-gtk-donut > $@
	printf "Creation time: " >> $@
	echo $(shell date -u) >> $@

_log += $(_build_dir)/log/cairo-gtk-donut.log

$(_build_dir)/bin/cairo-gtk-donut: $(_build_dir)/object/cairo-gtk-donut.o
	$(CC) -o $@ $(_gtk_libs) $<

_bin += $(_build_dir)/bin/cairo-gtk-donut

$(_build_dir)/object/cairo-gtk-donut.o: src/cairo-gtk-donut.c
	$(CC) -o $@ $(_gtk_cflags) -O2 -c $<

_object += $(_build_dir)/object/cairo-gtk-donut.o

# cairo-gtk-fill
$(_build_dir)/log/cairo-gtk-fill.log: $(_build_dir)/bin/cairo-gtk-fill
	$<
	printf "This file was created after running %s\n" \
	  ../bin/cairo-gtk-fill > $@
	printf "Creation time: " >> $@
	echo $(shell date -u) >> $@

_log += $(_build_dir)/log/cairo-gtk-fill.log

$(_build_dir)/bin/cairo-gtk-fill: \
	  $(_build_dir)/object/cairo-gtk-fill.o \
	  $(_build_dir)/object/context_fill.o \
	  $(_build_dir)/object/rgb.o
	$(CC) -o $@ $(_gtk_libs) $^

_bin += $(_build_dir)/bin/cairo-gtk-fill

$(_build_dir)/object/cairo-gtk-fill.o: src/cairo-gtk-fill.c \
	  include/context_fill.h include/rgb.h
	$(CC) -o $@ $(_gtk_cflags) -iquote include -O2 -c $<

_object += $(_build_dir)/object/cairo-gtk-fill.o

# cairo-gtk-moving-star
$(_build_dir)/log/cairo-gtk-moving-star.log: $(_build_dir)/bin/cairo-gtk-moving-star
	$<
	printf "This file was created after running %s\n" \
	  ../bin/cairo-gtk-moving-star > $@
	printf "Creation time: " >> $@
	echo $(shell date -u) >> $@

_log += $(_build_dir)/log/cairo-gtk-moving-star.log

$(_build_dir)/bin/cairo-gtk-moving-star: $(_build_dir)/object/cairo-gtk-moving-star.o
	$(CC) -o $@ $(_gtk_libs) $<

_bin += $(_build_dir)/bin/cairo-gtk-moving-star

$(_build_dir)/object/cairo-gtk-moving-star.o: src/cairo-gtk-moving-star.c
	$(CC) -o $@ $(_gtk_cflags) -O2 -c $<

_object += $(_build_dir)/object/cairo-gtk-moving-star.o

# cairo-gtk-moving-point
$(_build_dir)/log/cairo-gtk-moving-point.log: $(_build_dir)/bin/cairo-gtk-moving-point
	$<
	printf "This file was created after running %s\n" \
	  ../bin/cairo-gtk-moving-point > $@
	printf "Creation time: " >> $@
	echo $(shell date -u) >> $@

_log += $(_build_dir)/log/cairo-gtk-moving-point.log

$(_build_dir)/bin/cairo-gtk-moving-point: \
	  $(_build_dir)/object/cairo-gtk-moving-point.o \
	  $(_build_dir)/object/context_draw_circle.o
	$(CC) -o $@ $(_gtk_libs) $^

_bin += $(_build_dir)/bin/cairo-gtk-moving-point

$(_build_dir)/object/cairo-gtk-moving-point.o: src/cairo-gtk-moving-point.c \
	  include/context_draw_circle.h
	$(CC) -o $@ $(_gtk_cflags) -iquote include -O2 -c $<

_object += $(_build_dir)/object/cairo-gtk-moving-point.o

# cairo-gtk-button
$(_build_dir)/log/cairo-gtk-button.log: $(_build_dir)/bin/cairo-gtk-button
	$<
	printf "This file was created after running %s\n" \
	  ../bin/cairo-gtk-button > $@
	printf "Creation time: " >> $@
	echo $(shell date -u) >> $@

_log += $(_build_dir)/log/cairo-gtk-button.log

$(_build_dir)/bin/cairo-gtk-button: $(_build_dir)/object/cairo-gtk-button.o
	$(CC) -o $@ $(_gtk_libs) $<

_bin += $(_build_dir)/bin/cairo-gtk-button

$(_build_dir)/object/cairo-gtk-button.o: src/cairo-gtk-button.c
	$(CC) -o $@ $(_gtk_cflags) -O2 -c $<

_object += $(_build_dir)/object/cairo-gtk-button.o

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

$(_build_dir)/demo/animation.pdf: $(_build_dir)/bin/cairo-pdf-animation
	$< $@

_demo_static += $(_build_dir)/demo/animation.pdf

$(_build_dir)/bin/cairo-pdf-animation: \
	   $(_build_dir)/object/cairo-pdf-animation.o \
	   $(_build_dir)/object/context_draw_circle.o
	$(CC) -o $@ $(_cairo_libs) $^

_bin += $(_build_dir)/bin/cairo-pdf-animation

$(_build_dir)/object/cairo-pdf-animation.o: src/cairo-pdf-animation.c \
	  include/context_draw_circle.h
	$(CC) -o $@ $(_cairo_cflags) -iquote include -O2 -c $<

_object += $(_build_dir)/object/cairo-pdf-animation.o

# cairo-pdf-fill
$(_build_dir)/demo/fill.pdf: $(_build_dir)/bin/cairo-pdf-fill
	$< $@

_demo_static += $(_build_dir)/demo/fill.pdf

$(_build_dir)/bin/cairo-pdf-fill: \
	   $(_build_dir)/object/cairo-pdf-fill.o \
	   $(_build_dir)/object/context_fill.o \
	   $(_build_dir)/object/rgb.o
	$(CC) -o $@ $(_cairo_libs) $^

_bin += $(_build_dir)/bin/cairo-pdf-fill

$(_build_dir)/object/cairo-pdf-fill.o: src/cairo-pdf-fill.c \
	  include/context_fill.h include/rgb.h
	$(CC) -o $@ $(_cairo_cflags) -iquote include -O2 -c $<

_object += $(_build_dir)/object/cairo-pdf-fill.o

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


# cairo-svg-animation -> unable to produce gif without temporary pgn files

$(_build_dir)/demo/animation.png: $(_build_dir)/log/cairo-png-animation.log
	   apngasm build/demo/animation_*.png -o $@

_demo_static += $(_build_dir)/demo/animation.png

$(_build_dir)/demo/animation.gif: \
	     $(_build_dir)/log/cairo-png-animation.log
	   ffmpeg -i build/demo/animation_%3d.png $@

_demo_static += $(_build_dir)/demo/animation.gif

$(_build_dir)/log/cairo-png-animation.log: $(_build_dir)/bin/cairo-png-animation
	$< $(_build_dir)/demo/animation
	printf "This file was created after running %s\n" \
	  ../bin/cairo-png-animation > $@
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

# cairo-svg-animation -> unable to produce a single file animation

# $(_build_dir)/demo/animation.svg.mkv: \
# 	     $(_build_dir)/log/cairo-svg-animation.log
# 	   ffmpeg -f image2 -i $(_build_dir)/demo/animation_%3d.svg -vcodec copy $@
#
# _demo_static += $(_build_dir)/demo/animation.svg.mkv

# $(_build_dir)/log/cairo-svg-animation.log: $(_build_dir)/bin/cairo-svg-animation
# 	$< $(_build_dir)/demo/animation
# 	printf "This file was created after running %s\n" \
# 	  $(word 2, $^) > $@
# 	printf "Creation time: " >> $@
# 	echo $(shell date -u) >> $@
#
# _log += $(_build_dir)/log/cairo-svg-animation.log

# $(_build_dir)/demo/animation.svg: $(_build_dir)/bin/cairo-svg-animation
# 	$< $@
#
# _demo_static += $(_build_dir)/demo/animation.svg

$(_build_dir)/bin/cairo-svg-animation: $(_build_dir)/object/cairo-svg-animation.o
	$(CC) -o $@ $(_cairo_libs) $<

_bin += $(_build_dir)/bin/cairo-svg-animation

$(_build_dir)/object/cairo-svg-animation.o: src/cairo-svg-animation.c
	$(CC) -o $@ $(_cairo_cflags) -O2 -c $<

_object += $(_build_dir)/object/cairo-svg-animation.o

################################### BUILDING ###################################
.PHONY: link
link: compile $(_bin)

.PHONY: compile
compile: $(_object)

.PHONY: demo-static
demo-static: link $(_demo_static)

.PHONY: log
log : link $(_log)

.PHONY: demo
demo: link demo-static log

################################### CLEANING ###################################
.PHONY: clean
clean:
	-$(RM) $(_object) $(_log)

.PHONY: distclean
distclean: clean
	-$(RM) $(_bin) $(_demo_static) $(_build_dir)/demo/animation_*.png

.PHONY: uninitialize
uninitialize: distclean
	-$(RM) -r $(_build_dir)
