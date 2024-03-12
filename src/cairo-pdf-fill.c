/* Drawing a collection of points orbiting around a circle on PDF files. */

/* system headers */
#include <math.h>
#include <stdio.h>
#include <string.h>

/* external headers */
#include <cairo.h>
#include <cairo-pdf.h>

#include "context_fill.h"

/* Actual drawing of a text on an in-memory cairo context. */
static void pdf_draw_circle(cairo_t * cr, int width, int height, int i, int n)
{
  cairo_save(cr);
  cairo_set_source_rgb(cr, 1, 1, 1);
  cairo_paint(cr);
  cairo_restore(cr);
  context_fill(cr, width, height, i, n);
  cairo_show_page(cr);
}

static void surface_draw_circles(
  cairo_surface_t * surface,
  double width,
  double height,
  int n)
{
  cairo_t * cr;
  int i;
  
  for (i = 0; i < n; ++i)
  {
    cr = cairo_create(surface);
    pdf_draw_circle(cr, width, height, i, n);
    cairo_destroy(cr);
  }
}

static void
pdf_draw_circles(const char * filename, double width, double height, int n)
{
  cairo_surface_t * surface;
  
  surface = cairo_pdf_surface_create(filename, width, height);
  surface_draw_circles(surface, width, height, n);
  cairo_surface_destroy(surface);
}

int main(int argc, char * argv[])
{
  double width = 595.;
  double height = 842.;
  int n = 100;
  
  if (argc != 2)
  {
    fprintf(stderr, "Usage: %s <animation>\n", argv[0]);
    return 1;
  }
  pdf_draw_circles(argv[1], width, height, n);
  return 0;
}
