/* Drawing a collection of points orbiting around a circle on PDF files. */

/* system headers */
#include <math.h>
#include <stdio.h>
#include <string.h>

/* external headers */
#include <cairo.h>
#include <cairo-pdf.h>

/* draw a point centered at ($x, $y) of size $r to context $cr */
static void point_draw(cairo_t * cr, double x, double y, double r)
{
  cairo_arc(cr, x, y, r, 0, 2 * M_PI);
}

/* Actual drawing of a text on an in-memory cairo context. */
static void context_draw_circle(cairo_t * cr, int i)
{
  double x, y;
  
  cairo_save(cr);
  cairo_set_source_rgb(cr, 1, 1, 1);
  cairo_paint(cr);
  cairo_restore(cr);
  cairo_set_source_rgb(cr, 1, 0, 1); /* magenta */
  x = 50 + 30 * cos(M_PI / 180. * (double) i);
  y = 50 + 30 * sin(M_PI / 180. * (double) i);
  point_draw(cr, x, y, 5);
  cairo_fill(cr);
}

static cairo_t * pdf_context_create(const char * filename)
{
  cairo_surface_t * surface;
  cairo_t * cr;
  
  surface = cairo_pdf_surface_create(filename, 100, 100);
  cr = cairo_create(surface);
  cairo_surface_destroy(surface);
  return cr;
}

static void pdf_draw_circle(int i, const char * filename)
{
  cairo_t * cr;
  
  cr = pdf_context_create(filename);
  context_draw_circle(cr, i);
  cairo_destroy(cr);
}

// static void surface_draw_circle(cairo_surface_t * surface, int i)
// {
//   cairo_t * cr;
//
//   cr = cairo_create(surface);
//   context_draw_circle(cr, i);
//   cairo_destroy(cr);
// }
//
// static void pdf_draw_circle(int i, const char * filename)
// {
//   cairo_surface_t * surface;
//
//   surface = cairo_pdf_surface_create(CAIRO_FORMAT_ARGB32, 100, 100);
//   surface_draw_circle(surface, i);
//   cairo_surface_write_to_png(surface, filename);
//   cairo_surface_destroy(surface);
// }

static void name_reset(char * name)
{
  int n;
  
  n = strlen(name);
  name[n - 8] = 0;
}

static void animation_append(char * name, int i)
{
  char tail[9];
  sprintf(tail, "_%03d.pdf", i);
  strcat(name, tail);
}

int main(int argc, char * argv[])
{
  int i;
  char name[256] = {0};
  
  if (argc != 2)
  {
    fprintf(stderr, "Usage: %s <animation>\n", argv[0]);
    return 1;
  }
  
  strcat(name, argv[1]);
  for (i = 0; i < 360; ++i)
  {
    animation_append(name, i);
    pdf_draw_circle(i, name);
    name_reset(name);
  }
  return 0;
}
