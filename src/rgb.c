#include "rgb.h"

static void rgb_red_to_yellow(rgb * color, int i, int n)
{
  color->red = 1.;
  color->green = (double) i / (double) n;
  color->blue = 0.;
}

static void rgb_yellow_to_green(rgb * color, int i, int n)
{
  color->red = 1. - (double) i / (double) n;
  color->green = 1.;
  color->blue = 0.;
}

static void rgb_green_to_light_blue(rgb * color, int i, int n)
{
  color->red = 0.;
  color->green = 1.;
  color->blue = (double) i / (double) n;
}

static void rgb_light_blue_to_dark_blue(rgb * color, int i, int n)
{
  color->red = 0.;
  color->green = 1. - (double) i / (double) n;
  color->blue = 1.;
}

typedef void (*rgb_nuance_t)(rgb *, int, int);

rgb_nuance_t rgb_nuances[4] =
{
  rgb_red_to_yellow,
  rgb_yellow_to_green,
  rgb_green_to_light_blue,
  rgb_light_blue_to_dark_blue
};

void rgb_color(rgb * color, int i, int n)
{
  int k_n = n / 4;
  int k_i = i % k_n;
  int k = i / k_n;
  rgb_nuances[k](color, k_i, k_n);
}
