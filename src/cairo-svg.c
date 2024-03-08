/* modification of https://zetcode.com/gfx/cairo/cairobackends/ */

#include <stdio.h>

#include <cairo.h>
#include <cairo-svg.h>

static void draw_text(cairo_t * cr, const char * text)
{
  cairo_set_source_rgb(cr, 0, 0, 0);
  cairo_select_font_face(cr, "Sans", CAIRO_FONT_SLANT_NORMAL,
                                     CAIRO_FONT_WEIGHT_NORMAL);
  cairo_set_font_size(cr, 40.0);

  cairo_move_to(cr, 10.0, 50.0);
  cairo_show_text(cr, text);
}

int main(int argc, char * argv[])
{
  cairo_surface_t * surface;
  cairo_t * cr;
  
  if (argc != 3)
  {
    fprintf(stderr, "Usage: %s <text> <output>.svg\n", argv[0]);
    return 1;
  }

  surface = cairo_svg_surface_create(argv[2], 390, 60);
  cr = cairo_create(surface);

  draw_text(cr, argv[1]);

  cairo_destroy(cr);
  cairo_surface_destroy(surface);

  return 0;
}
