/* modification of https://zetcode.com/gfx/cairo/basicdrawing/ */

#include <cairo.h>
#include <gtk/gtk.h>

typedef struct
{
  int count;
  double coordx[100];
  double coordy[100];
} points;

static void do_drawing(cairo_t * cr, points * p)
{
  int i, j;
  
  cairo_set_source_rgb(cr, 0, 0, 0);
  cairo_set_line_width(cr, 0.5);
  for (i = 0; i < p->count; i++)
  {
    for (j = i + 1; j < p->count; j++)
    {
      cairo_move_to(cr, p->coordx[i], p->coordy[i]);
      cairo_line_to(cr, p->coordx[j], p->coordy[j]);
    }
  }
  p->count = 0;
  cairo_stroke(cr);    
}

static int on_draw_event(GtkWidget * widget, cairo_t * cr, void * user_data)
{
  do_drawing(cr, (points *) user_data);
  return FALSE;
}

static int clicked(GtkWidget * widget, GdkEventButton * event, void * user_data)
{
  points * p = (points *) user_data;
  
  if (event->button == 1)
  {
    p->coordx[p->count] = event->x;
    p->coordy[p->count] = event->y;
    p->count++;
  }

  if (event->button == 3)
    gtk_widget_queue_draw(widget);

  return TRUE;
}


int main(int argc, char * argv[])
{
  GtkWidget * window;
  GtkWidget * drawing_area;
  
  points p;
  p.count = 0;

  gtk_init(&argc, &argv);

  window = gtk_window_new(GTK_WINDOW_TOPLEVEL);

  drawing_area = gtk_drawing_area_new();
  gtk_container_add(GTK_CONTAINER(window), drawing_area);
 
  gtk_widget_add_events(window, GDK_BUTTON_PRESS_MASK);

  g_signal_connect(G_OBJECT(drawing_area), "draw",
                   G_CALLBACK(on_draw_event), &p); 
  g_signal_connect(window, "destroy", G_CALLBACK(gtk_main_quit), NULL);  
    
  g_signal_connect(window, "button-press-event", G_CALLBACK(clicked), &p);
 
  gtk_window_set_position(GTK_WINDOW(window), GTK_WIN_POS_CENTER);
  gtk_window_set_default_size(GTK_WINDOW(window), 400, 300); 
  gtk_window_set_title(GTK_WINDOW(window), "Lines");

  gtk_widget_show_all(window);

  gtk_main();

  return 0;
}
