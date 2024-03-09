/* modification of https://zetcode.com/gfx/cairo/cairobackends/ */

#include <stdio.h>

#include <cairo.h>

/* Actual drawing of a text on an in-memory cairo context. */
static void context_draw_text(cairo_t * cr, const char * text)
{
  cairo_save(cr);
  cairo_set_source_rgb(cr, 1, 1, 1);
  cairo_paint(cr);
  cairo_restore(cr);
  
  cairo_set_source_rgb(cr, 0, 0, 0);
  cairo_select_font_face(cr, "Sans", CAIRO_FONT_SLANT_NORMAL,
                                     CAIRO_FONT_WEIGHT_NORMAL);
  cairo_set_font_size(cr, 40.0);

  cairo_move_to(cr, 10.0, 50.0);
  cairo_show_text(cr, text);
}

/*
Writing on a surface.
A context for that surface is created.
Text is drawn.
Context is destroyed.
You cannot destroy the surface since this is in-memory writing.
*/
static void surface_draw_text(cairo_surface_t * surface, const char * text)
{
  cairo_t * cr;
  
  cr = cairo_create(surface);
  context_draw_text(cr, text);
  cairo_destroy(cr);
}

/*
Writing to a PNG file.
A surface is created.
Text is drawn on that surface.
This in-memory data is then written to PNG.
Then the surface is destroyed.
*/
static void png_draw_text(const char * text, const char * filename)
{
  cairo_surface_t * surface;
  
  surface = cairo_image_surface_create(CAIRO_FORMAT_ARGB32, 390, 60);
  surface_draw_text(surface, text);
  cairo_surface_write_to_png(surface, filename);
  cairo_surface_destroy(surface);
}

int main(int argc, char * argv[])
{
  if (argc != 3)
  {
    fprintf(stderr, "Usage: %s <text> <output>.png\n", argv[0]);
    return 1;
  }
  png_draw_text(argv[1], argv[2]);
  return 0;
}
