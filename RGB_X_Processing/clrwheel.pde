/////////////////
// Color Wheel //
/////////////////

public class ColorWheel {
  int x, y, w, h;
  int alpha = 0;
  color cor = BLACK;
  ColorVariant center;
  ColorVariant[] ring;
  boolean redraw = true;
  
  public ColorWheel (int _x, int _y, int _w, int _h) {
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    center = new ColorVariant(w/2, h/2, WHEEL_SEG_SZ*3, WHEEL_SEG_SZ*3, cor);
    ring = new ColorVariant[NUM_CIRCLES];
    initialize_color_variant_ring();
  }
  
  void initialize_color_variant_ring() {
    int radius = 68;
    int increment = 360/NUM_CIRCLES;
    for (int i = 0; i < ring.length; i++) {
      int px = (int)Math.floor(radius * Math.cos((increment * i) * (Math.PI / 180)));
      int py = (int)Math.floor(radius * Math.sin((increment * i) * (Math.PI / 180)));
      ring[i] = new ColorVariant(px+w/2, py+h/2, WHEEL_SEG_SZ, WHEEL_SEG_SZ, BLACK);
    }
  }
    
  boolean isOver() {
    if ((mouseX>=x) && (mouseX<x+w) && (mouseY >=y) && (mouseY<y+h)) {
      return true;
    }
    return false;
  }
  
  void check_for_clicks() {
    if(mousePressed && isOver()) {
      click();
    }
  }
  
  void click() {
    if (use_wheel) {
      redraw = true;
      if (mouseButton == RIGHT) {
        update_color();
      }
      else {
        new_cor = get(mouseX, mouseY);
      }
    }
  }
  
  void update_color() {
    center.cor = main_cor;
    int[] rgb = getRGB(main_cor);
    float tint_increment = float(1)/ring.length;
    for (int i = 0; i < ring.length; i++) {
      int[] new_rgb = {int(rgb[0]*tint_increment*i), int(rgb[1]*tint_increment*i), int(rgb[2]*tint_increment*i)};
      ring[i].cor = RGBtoColor(new_rgb);
    }
  }
  
  void update_alpha() {
    if (use_wheel && alpha < 255) {
      alpha += ALPHA_MODIFIER;
    }
    else if (!use_wheel && alpha > 0) {
      alpha -= ALPHA_MODIFIER*2;
    }
  }
  
  void render_ring() {
    for (int i = 0; i < ring.length; i++) {
      ring[i].render(alpha);
    }
  }
  
  void render() {
    update_alpha();
    center.render(alpha);
    render_ring();
    if (use_wheel) {
      check_for_clicks();
    }
  }
}