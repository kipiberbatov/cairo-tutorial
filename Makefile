BUILD := build

OBJECT := \
  $(BUILD)/object/cairo-pdf.o \
  $(BUILD)/object/cairo-png.o \
  $(BUILD)/object/cairo-svg.o \

BIN := \
  $(BUILD)/bin/cairo-pdf \
  $(BUILD)/bin/cairo-png \
  $(BUILD)/bin/cairo-svg \

DEMO := \
  $(BUILD)/demo/image.pdf \
  $(BUILD)/demo/image.png \
  $(BUILD)/demo/image.svg

.PHONY: all
all: setup $(BIN)

.PHONY: setup
setup: 
	mkdir -p $(BUILD)
	mkdir -p $(BUILD)/bin
	mkdir -p $(BUILD)/object
	

$(BUILD)/bin/cairo-pdf: $(BUILD)/object/cairo-pdf.o
	$(CC) -o $@ $(shell pkg-config --libs cairo) $<

$(BUILD)/object/cairo-pdf.o: src/cairo-pdf.c
	$(CC) -o $@ $(shell pkg-config --cflags cairo) -O2 -c $<

$(BUILD)/bin/cairo-png: $(BUILD)/object/cairo-png.o
	$(CC) -o $@ $(shell pkg-config --libs cairo) $<

$(BUILD)/object/cairo-png.o: src/cairo-png.c
	$(CC) -o $@ $(shell pkg-config --cflags cairo) -O2 -c $<

$(BUILD)/bin/cairo-svg: $(BUILD)/object/cairo-svg.o
	$(CC) -o $@ $(shell pkg-config --libs cairo) $<

$(BUILD)/object/cairo-svg.o: src/cairo-svg.c
	$(CC) -o $@ $(shell pkg-config --cflags cairo) -O2 -c $<

.PHONY: demo
demo: demo-setup $(DEMO)

.PHONY: demo-setup
demo-setup:
	mkdir -p $(BUILD)/demo

$(BUILD)/demo/image.pdf: $(BUILD)/bin/cairo-pdf
	$< "Hello, cairo!" $@

$(BUILD)/demo/image.png: $(BUILD)/bin/cairo-png
	$< "Hello, cairo!" $@

$(BUILD)/demo/image.svg: $(BUILD)/bin/cairo-svg
	$< "Hello, cairo!" $@

.PHONY: clean
clean:
	-$(RM) $(OBJECT)

.PHONY: distclean
distclean: clean
	-$(RM) $(BIN) $(DEMO)

.PHONY: default-repo
default-repo: distclean
	-$(RM) -r $(BUILD)
