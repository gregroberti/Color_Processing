/////////////////
// Color Wheel //
/////////////////

public class ColorWheel {
  int x, y, w, h;
  int alpha = 0;
  color cor = BLACK;
  boolean redraw = true;
  
  //float[] primary_ratios = { 1.0, 0.0, 0.0,
  //                           1.0, 0.5, 0.0,
  //                           1.0, 1.0, 0.0,
  //                           0.5, 1.0, 0.0,
  //                           0.0, 1.0, 0.0,
  //                           0.0, 1.0, 0.5,
  //                           0.0, 1.0, 1.0,
  //                           0.0, 0.5, 1.0,
  //                           0.0, 0.0, 1.0,
  //                           0.5, 0.0, 1.0,
  //                           1.0, 0.0, 1.0,
  //                           1.0, 0.0, 0.5
  //                         };
  
  public ColorWheel (int _x, int _y, int _w, int _h) {
    x = _x;
    y = _y;
    w = _w;
    h = _h;
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
    cor = main_cor;
  }
  
  void update_alpha() {
    if (use_wheel && alpha < 255) {
      alpha += ALPHA_MODIFIER;
    }
    else if (!use_wheel && alpha > 0) {
      alpha -= ALPHA_MODIFIER*2;
    }
  }
  
  void render_circle_border(int _x, int _y, int _w, int _h) {
    fill(WHITE, alpha);
    ellipse(_x, _y, _w+2, _h+2);
  }
  
  void render_circle_fill(int _x, int _y, int _w, int _h, color _cor) {
    fill(_cor, alpha);
    ellipse(_x, _y, _w, _h);
  }
  
  void render_circle(int _x, int _y, int _w, int _h, color _cor) {
    render_circle_border(_x, _y, _w, _h);
    render_circle_fill(_x, _y, _w, _h, _cor);
  }
  
  void render_segment(int x1, int y1, int x2, int y2, int x3, int y3, int x4, int y4, color _cor) {
    fill(_cor, alpha);
    quad(x1, y1, x2, y2, x3, y3, x4, y4);
  }
  
  void render_wheel_segments() {
    
    
    
    //int[] rgb_stp = {3, 11, 7};
    
    //float[] rgb_pct = new float[NUM_CIRCLES];
    //for (int i = 0; i < NUM_CIRCLES; i++) {
    //  if (i < NUM_CIRCLES/2) {
    //    rgb_pct[i] = float(i*2)/NUM_CIRCLES;
    //  }
    //  else {
    //    rgb_pct[i] = rgb_pct[NUM_CIRCLES-i];
    //  }
    //}
    
    int[] radius = {60, 90, 120};
    int[] rgb = getRGB(cor);
    //int phase = (int)random(0,1200);
    //double frequency = Math.PI*2/NUM_CIRCLES;
    for (int j = 0; j < 3; j++) {
      int increment = 360/NUM_CIRCLES;
      for (int i = 0; i < NUM_CIRCLES; i++) {
        //int r = int(rgb[0]*primary_ratios[i+0]);
        //int g = int(rgb[1]*primary_ratios[i+1]);
        //int b = int(rgb[2]*primary_ratios[i+2]);
        
        //for (int j = 0; j < 3; j++) {
        // rgb_stp[j]++;
        // if (rgb_stp[j] >= num_circles) {
        //   rgb_stp[j] = 0;
        // }
        //}
        //int[] new_rgb = { (int)Math.floor(Math.sin(frequency*i+2+phase) * RAINBOW_PALETTE_CONTRAST + RAINBOW_PALETTE_BRIGHTNESS),
        //                 (int)Math.floor(Math.sin(frequency*i+0+phase) * RAINBOW_PALETTE_CONTRAST + RAINBOW_PALETTE_BRIGHTNESS),
        //                 (int)Math.floor(Math.sin(frequency*i+4+phase) * RAINBOW_PALETTE_CONTRAST + RAINBOW_PALETTE_BRIGHTNESS)
        //               };
        
        float[] hsl = RGBtoHSL(rgb);
        
        int[] new_rgb = HSLtoRGB(hsl);
        
        //println("i/num_circles="+float(i)/num_circles);
        //println("rgb["+j+"]="+rgb[j]);
        //println("rgb["+j+"]="+rgb[j]);
        int px = (int)Math.floor(radius[j] * Math.cos((increment * i) * (Math.PI / 180)));
        int py = (int)Math.floor(radius[j] * Math.sin((increment * i) * (Math.PI / 180)));
        render_circle(px+w/2, py+h/2, WHEEL_SEG_SZ, WHEEL_SEG_SZ, color(new_rgb[0], new_rgb[1], new_rgb[2]));
      }
    }
  }
  
  void render() {
    update_alpha();
    render_circle(w/2, h/2, WHEEL_SEG_SZ*3, WHEEL_SEG_SZ*3, cor);
    render_wheel_segments();
    if (use_wheel) {
      check_for_clicks();
    }
  }
}