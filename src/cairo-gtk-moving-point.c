#include <math.h>

#include <cairo.h>
#include <gtk/gtk.h>

/* draw a point centered at ($x, $y) of size $r to context $cr */
static void point_draw(cairo_t * cr, double x, double y, double r)
{
  cairo_arc(cr, x, y, r, 0, 2 * M_PI);
}

/* Actual drawing of a text on a cairo context. */
static void context_draw_circle(cairo_t * cr, int width, int height, int i)
{
  double x, y;
  
  x = width / 2 + 3 * width / 10 * cos(M_PI / 180. * (double) i);
  y = height / 2 + 3 * width / 10 * sin(M_PI / 180. * (double) i);
  point_draw(cr, x, y, (width + height) / 100);
  cairo_fill(cr);
}

static void context_snapshot(cairo_t * cr, int * i, int width, int height)
{
  cairo_set_source_rgb(cr, 1, 0, 1);
  cairo_set_line_width(cr, 1);
  context_draw_circle(cr, width, height, *i);
  *i += 1; 
}

static void do_drawing(GtkWidget * widget, cairo_t * cr, int * i)
{
  int height, width;
  GtkWidget * win;
  
  win = gtk_widget_get_toplevel(widget);
  gtk_window_get_size(GTK_WINDOW(win), &width, &height);
  context_snapshot(cr, i, width, height);
}

static int on_draw_event(GtkWidget * widget, cairo_t * cr, void * user_data)
{
  do_drawing(widget, cr, (int *) user_data);
  return FALSE;
}

static int time_handler(GtkWidget * widget)
{
  gtk_widget_queue_draw(widget);
  return TRUE;
}

int main(int argc, char * argv[])
{
  int i = 0;
  GtkWidget * window;
  GtkWidget * darea;

  gtk_init(&argc, &argv);

  window = gtk_window_new(GTK_WINDOW_TOPLEVEL);
  
  darea = gtk_drawing_area_new();
  gtk_container_add(GTK_CONTAINER (window), darea);  

  g_signal_connect(G_OBJECT(darea), "draw", G_CALLBACK(on_draw_event), &i); 
  g_signal_connect(window, "destroy", G_CALLBACK(gtk_main_quit), NULL);
 
  gtk_window_set_position(GTK_WINDOW(window), GTK_WIN_POS_CENTER);
  gtk_window_set_default_size(GTK_WINDOW(window), 500, 500); 
  gtk_window_set_title(GTK_WINDOW(window), "Point moving in a circle");

  g_timeout_add(20, (GSourceFunc) time_handler, (void *) window);

  gtk_widget_show_all(window);

  gtk_main();

  return 0;
}
