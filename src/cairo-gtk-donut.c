/* https://zetcode.com/gfx/cairo/transformations/ */

#include <math.h>

#include <cairo.h>
#include <gtk/gtk.h>

static void donut_boundary(cairo_t * cr, int width, int height)
{
  cairo_set_line_width(cr, 0.5);
  cairo_translate(cr, width/2, height/2);
  cairo_arc(cr, 0, 0, 120, 0, 2 * M_PI);
  cairo_stroke(cr);
}

static void donut_draw(cairo_t * cr)
{
  int i;
  
  for (i = 0; i < 36; i++)
  {
    cairo_save(cr);
    cairo_rotate(cr, (double) i * M_PI / 36.);
    cairo_scale(cr, 0.3, 1.);
    cairo_arc(cr, 0., 0., 120., 0., 2. * M_PI);
    cairo_restore(cr);
    cairo_stroke(cr);
  }
}

static void do_drawing(cairo_t *cr, GtkWidget *widget)
{
  int height, width;
  GtkWidget * win;

  win = gtk_widget_get_toplevel(widget);
  gtk_window_get_size(GTK_WINDOW(win), &width, &height);
  donut_boundary(cr, width, height);
  donut_draw(cr);
}

static int on_draw_event(GtkWidget * widget, cairo_t * cr, void * user_data)
{
  do_drawing(cr, widget);
  return FALSE;
}

int main(int argc, char * argv[])
{
  GtkWidget *window;
  GtkWidget *darea;

  gtk_init(&argc, &argv);

  window = gtk_window_new(GTK_WINDOW_TOPLEVEL);

  darea = gtk_drawing_area_new();
  gtk_container_add(GTK_CONTAINER (window), darea);

  g_signal_connect(G_OBJECT(darea), "draw", G_CALLBACK(on_draw_event), NULL);
  g_signal_connect(G_OBJECT(window), "destroy",
                   G_CALLBACK(gtk_main_quit), NULL);

  gtk_window_set_position(GTK_WINDOW(window), GTK_WIN_POS_CENTER);
  gtk_window_set_default_size(GTK_WINDOW(window), 350, 250);
  gtk_window_set_title(GTK_WINDOW(window), "Donut");

  gtk_widget_show_all(window);

  gtk_main();

  return 0;
}
