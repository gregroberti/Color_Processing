///////////////////
// Color Variant //
///////////////////

public class ColorVariant {
  int x, y, w, h;
  color cor;
  
  public ColorVariant(int _x, int _y, int _w, int _h, color _cor) {
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    cor = _cor;
  }
  
  void render_circle_border(int alpha) {
    fill(WHITE, alpha);
    ellipse(x, y, w+2, h+2);
  }
  
  void render_circle_fill(int alpha) {
    fill(cor, alpha);
    ellipse(x, y, w, h);
  }
  
  void render(int alpha) {
    render_circle_border(alpha);
    render_circle_fill(alpha);
  }
}