/* modification of https://zetcode.com/gfx/cairo/shapesfills/ */
#include <cairo.h>
#include <gtk/gtk.h>

static void decagon_star_draw(cairo_t * cr)
{
  int i;
  const int points[10][2] =
  { 
    { 0, 85 }, 
    { 75, 75 }, 
    { 100, 10 }, 
    { 125, 75 }, 
    { 200, 85 },
    { 150, 125 }, 
    { 160, 190 },
    { 100, 150 }, 
    { 40, 190 },
    { 50, 125 }
  };
  
  for (i = 0; i < 10; i++)
    cairo_line_to(cr, points[i][0], points[i][1]);
  cairo_close_path(cr);
  
  cairo_stroke_preserve(cr);
  cairo_fill(cr);
}

static void triangle_draw(cairo_t * cr)
{
  cairo_move_to(cr, 240, 40);
  cairo_line_to(cr, 240, 160);
  cairo_line_to(cr, 350, 160);
  cairo_close_path(cr);

  cairo_stroke_preserve(cr);
  cairo_fill(cr);
}

static void triangle_curved_draw(cairo_t * cr)
{
  cairo_move_to(cr, 380, 40);
  cairo_line_to(cr, 380, 160);
  cairo_line_to(cr, 450, 160);
  cairo_curve_to(cr, 440, 155, 380, 145, 380, 40);

  cairo_stroke_preserve(cr);
  cairo_fill(cr); 
}

static void do_drawing(cairo_t *cr)
{
  cairo_set_line_width(cr, 1);
  
  cairo_set_source_rgb(cr, 1, 1, 0); /* yellow */
  decagon_star_draw(cr);
  
  cairo_set_source_rgb(cr, 1, 0, 1); /* magenta */
  triangle_draw(cr);
  
  cairo_set_source_rgb(cr, 0, 1, 1); /* cyan */
  triangle_curved_draw(cr);
}

static int on_draw_event(GtkWidget * widget, cairo_t * cr, void * user_data)
{
  do_drawing(cr);
  return FALSE;
}

int main(int argc, char * argv[])
{
  GtkWidget * window;
  GtkWidget * darea;

  gtk_init(&argc, &argv);

  window = gtk_window_new(GTK_WINDOW_TOPLEVEL);

  darea = gtk_drawing_area_new();
  gtk_container_add(GTK_CONTAINER(window), darea);

  g_signal_connect(G_OBJECT(darea), "draw", G_CALLBACK(on_draw_event), NULL);  
  g_signal_connect(window, "destroy", G_CALLBACK(gtk_main_quit), NULL);

  gtk_window_set_position(GTK_WINDOW(window), GTK_WIN_POS_CENTER);
  gtk_window_set_default_size(GTK_WINDOW(window), 460, 240); 
  gtk_window_set_title(GTK_WINDOW(window), "Other shapes");

  gtk_widget_show_all(window);

  gtk_main();

  return 0;
}
