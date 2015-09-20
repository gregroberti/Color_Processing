//////////////////
// Color Picker //
//////////////////

public class ColorPicker {
  int x, y, w, h;
  int alpha = 0;
  PImage cpImage;
  
  public ColorPicker (int _x, int _y, int _w, int _h) {
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    
    cpImage = createImage(w, h, RGB);
    initialize();
  }
  
  private void initialize() {
    for (int i=0; i<w; i++) {
      float nColorPercent = i / (float)w;
      float rad = (-360 * nColorPercent) * (PI / 180);
      int nR = (int)(cos(rad) * 127 + 128) << 16;
      int nG = (int)(cos(rad + 2 * PI / 3) * 127 + 128) << 8;
      int nB = (int)(Math.cos(rad + 4 * PI / 3) * 127 + 128);
      int nColor = nR | nG | nB;
      
      setGradient( i, 0, 1, h/2, 0xFFFFFF, nColor);
      setGradient( i, (h/2), 1, h/2, nColor, 0x000000);
    }
  }

  private void setGradient(int _x, int _y, float _w, float _h, color _c1, color _c2) {
    int[] rgb1 = getRGB(_c1);
    int[] rgb2 = getRGB(_c2);
    float deltaR = rgb2[0] - rgb1[0];
    float deltaG = rgb2[1] - rgb1[1];
    float deltaB = rgb2[2] - rgb1[2];

    for (int j=_y; j<(_y+_h); j++) {
      int c = color(rgb1[0]+(j-_y)*(deltaR/_h), rgb1[1]+(j-_y)*(deltaG/_h), rgb1[2]+(j-_y)*(deltaB/_h));
      cpImage.set(_x, j, c);
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
    if (use_picker) {
      new_cor = get(mouseX, mouseY);
    }
  }
  
  void update_alpha() {
    if (use_picker && alpha < 255) {
      alpha += ALPHA_MODIFIER;
    }
    else if (!use_picker && alpha > 0) {
      alpha -= ALPHA_MODIFIER*2;
    }
  }
  
  void render_alpha_cover() {
    fill(BLACK, 255-alpha);
    rect(x, y, w, h);
  }
  
  void render_border() {
    fill(WHITE, alpha);
    rect(x-1, y-1, w+2, h+2);
  }
  
  void render() {
    update_alpha();
    render_border();
    image(cpImage, x, y);
    render_alpha_cover();
    if (use_picker) {
      check_for_clicks();
    }
  }
}