/* modification of https://zetcode.com/gfx/cairo/cairobackends/ */

#include <stdio.h>

#include <cairo.h>
#include <cairo-svg.h>

/*
Drawing a text on a SVG file.
Work is done unlike in-memory writing for the PNG case.
After a SVG surface is created, a context for that surface is created.
The context then knows about the source.
Hence, the surface is immediately destroyed.
*/

/* Actual drawing of a text on an SVG cairo context. */
static void context_draw_text(cairo_t * cr, const char * text)
{
  cairo_set_source_rgb(cr, 0, 0, 0);
  cairo_select_font_face(cr, "Sans", CAIRO_FONT_SLANT_NORMAL,
                                     CAIRO_FONT_WEIGHT_NORMAL);
  cairo_set_font_size(cr, 40.0);

  cairo_move_to(cr, 10.0, 50.0);
  cairo_show_text(cr, text);
}

/*
Creating an SVG context.
An SVG surface is created,
A context for that surface is created.
The surface is no longer neccessary and it is destroyed.
The resulting context is returned ready for drawing.
*/
static cairo_t * svg_context_create(const char * filename)
{
  cairo_surface_t * surface;
  cairo_t * cr;
  
  surface = cairo_svg_surface_create(filename, 390, 60);
  cr = cairo_create(surface);
  cairo_surface_destroy(surface);
  return cr;
}

/*
Drawing a text on an SVG file.
An SVG context is created.
Text is drawn on that context.
The context is no longer required and destroyed as a result.
*/
static void svg_draw_text(const char * text, const char * filename)
{
  cairo_t * cr;
  
  cr = svg_context_create(filename);
  context_draw_text(cr, text);
  cairo_destroy(cr);
}

int main(int argc, char * argv[]) 
{
  if (argc != 3)
  {
    fprintf(stderr, "Usage: %s <text> <output>.svg\n", argv[0]);
    return 1;
  }
  svg_draw_text(argv[1], argv[2]);
  return 0;
}

