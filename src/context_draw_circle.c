#include <math.h>

#include "context_draw_circle.h"

/* draw a point centered at ($x, $y) of size $r to context $cr */
static void point_draw(cairo_t * cr, double x, double y, double r)
{
  cairo_arc(cr, x, y, r, 0, 2 * M_PI);
}

/* Actual drawing of a text on a cairo context. */
void context_draw_circle(cairo_t * cr, int width, int height, int i, int n)
{
  double x, y;
  double theta = 2. * M_PI * (double) i / (double) n;
  
  cairo_set_source_rgb(cr, 1, 0, 1); /* magenta */
  cairo_set_line_width(cr, 1);
  x = width / 2 + 3 * width / 10 * cos(theta);
  y = height / 2 + 3 * width / 10 * sin(theta);
  point_draw(cr, x, y, (width + height) / 100);
  cairo_fill(cr);
  cairo_arc(cr, width / 2, height / 2, 3 * width / 10, 0, theta);
  cairo_stroke(cr);
}
