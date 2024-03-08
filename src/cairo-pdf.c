/* modification of https://zetcode.com/gfx/cairo/cairobackends/ */
#include <cairo.h>
#include <cairo-pdf.h>
#include <stdio.h>

int main(int argc, char * argv[]) 
{
  cairo_surface_t *surface;
  cairo_t *cr;
  
  if (argc != 3)
  {
    fprintf(stderr, "Usage: %s <text> <output>.pdf\n", argv[0]);
    return 1;
  }

  surface = cairo_pdf_surface_create(argv[2], 504, 648);
  cr = cairo_create(surface);

  cairo_set_source_rgb(cr, 0, 0, 0);
  cairo_select_font_face (cr, "Sans", CAIRO_FONT_SLANT_NORMAL,
      CAIRO_FONT_WEIGHT_NORMAL);
  cairo_set_font_size (cr, 40.0);

  cairo_move_to(cr, 10.0, 50.0);
  cairo_show_text(cr, argv[1]);

  cairo_show_page(cr);

  cairo_surface_destroy(surface);
  cairo_destroy(cr);

  return 0;
}
