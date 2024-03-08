BUILD := build
BIN :=
OBJECT :=
DEMO :=
DEMO-GTK :=

################################### DEFAULT ####################################
.PHONY: all
all: link

################################## INITIALIZE ##################################
.PHONY: initialize
initialize:
	mkdir -p $(BUILD)
	mkdir -p $(BUILD)/bin
	mkdir -p $(BUILD)/object
	mkdir -p $(BUILD)/demo

##################################### GTK ######################################
$(BUILD)/bin/cairo-gtk: $(BUILD)/object/cairo-gtk.o
	$(CC) -o $@ $(shell pkg-config --libs gtk+-3.0) $<

BIN += $(BUILD)/bin/cairo-gtk

$(BUILD)/object/cairo-gtk.o: src/cairo-gtk.c
	$(CC) -o $@ $(shell pkg-config --cflags gtk+-3.0) -O2 -c $<

OBJECT += $(BUILD)/object/cairo-gtk.o

demo-gtk: $(BUILD)/bin/cairo-gtk
	$<

DEMO-GTK += demo-gtk

$(BUILD)/bin/cairo-gtk-shapes: $(BUILD)/object/cairo-gtk-shapes.o
	$(CC) -o $@ $(shell pkg-config --libs gtk+-3.0) $<

BIN += $(BUILD)/bin/cairo-gtk-shapes

$(BUILD)/object/cairo-gtk-shapes.o: src/cairo-gtk-shapes.c
	$(CC) -o $@ $(shell pkg-config --cflags gtk+-3.0) -O2 -c $<

OBJECT += $(BUILD)/object/cairo-gtk-shapes.o

demo-gtk-shapes: $(BUILD)/bin/cairo-gtk-shapes
	$<

DEMO-GTK += demo-gtk-shapes

##################################### PDF ######################################
$(BUILD)/bin/cairo-pdf: $(BUILD)/object/cairo-pdf.o
	$(CC) -o $@ $(shell pkg-config --libs cairo) $<

BIN += $(BUILD)/bin/cairo-pdf

$(BUILD)/object/cairo-pdf.o: src/cairo-pdf.c
	$(CC) -o $@ $(shell pkg-config --cflags cairo) -O2 -c $<

OBJECT += $(BUILD)/object/cairo-pdf.o

$(BUILD)/demo/image.pdf: $(BUILD)/bin/cairo-pdf
	$< "Hello, cairo!" $@

DEMO += $(BUILD)/demo/image.pdf

##################################### PNG ######################################
$(BUILD)/bin/cairo-png: $(BUILD)/object/cairo-png.o
	$(CC) -o $@ $(shell pkg-config --libs cairo) $<

BIN += $(BUILD)/bin/cairo-png

$(BUILD)/object/cairo-png.o: src/cairo-png.c
	$(CC) -o $@ $(shell pkg-config --cflags cairo) -O2 -c $<

OBJECT += $(BUILD)/object/cairo-png.o

$(BUILD)/demo/image.png: $(BUILD)/bin/cairo-png
	$< "Hello, cairo!" $@

DEMO += $(BUILD)/demo/image.png

##################################### SVG ######################################
$(BUILD)/bin/cairo-svg: $(BUILD)/object/cairo-svg.o
	$(CC) -o $@ $(shell pkg-config --libs cairo) $<

BIN += $(BUILD)/bin/cairo-svg

$(BUILD)/object/cairo-svg.o: src/cairo-svg.c
	$(CC) -o $@ $(shell pkg-config --cflags cairo) -O2 -c $<

OBJECT += $(BUILD)/object/cairo-svg.o

$(BUILD)/demo/image.svg: $(BUILD)/bin/cairo-svg
	$< "Hello, cairo!" $@

DEMO += $(BUILD)/demo/image.svg

################################### BUILDING ###################################
.PHONY: link
link: $(BIN)

.PHONY: compile
compile: $(OBJECT)

.PHONY: demo
demo: $(DEMO) $(DEMO-GTK)

################################### CLEANING ###################################
.PHONY: clean
clean:
	-$(RM) $(OBJECT)

.PHONY: distclean
distclean: clean
	-$(RM) $(BIN) $(DEMO)

.PHONY: uninitialize
uninitialize: distclean
	-$(RM) -r $(BUILD)
