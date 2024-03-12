#include <gtk/gtk.h>

void on_button_clicked(GtkButton * button, void * user_data)
{
  int * pn = (int *) user_data; 
  *pn = 1;
}

int main (int argc, char * argv[])
{
  int n = 0;
  GtkWidget * window;
  GtkWidget * button;

  gtk_init (&argc, &argv);

  window = gtk_window_new (GTK_WINDOW_TOPLEVEL);
  button = gtk_button_new_with_label ("Osss");

  gtk_container_add (GTK_CONTAINER(window), button);
  gtk_widget_show_all(window);

  g_signal_connect(G_OBJECT(window), "destroy",
                   G_CALLBACK(gtk_main_quit), NULL);
  g_signal_connect(G_OBJECT(button), "clicked",
                   G_CALLBACK(on_button_clicked), &n);

  gtk_main();

  return 0;
}
