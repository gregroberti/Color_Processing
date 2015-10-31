////////////////////////
// Element Base Class //
////////////////////////

abstract class elembase {
  int x = 0;
  int y = 0;
  int w = 0;
  int h = 0;
  int bor_thk = 1;
  color bor_cor = WHITE;
  color cor = BLACK;
  
  void render_border(int alpha) {
    fill(bor_cor, alpha);
    rect(x-1*bor_thk, y-1*bor_thk, w+2*bor_thk, h+2*bor_thk);
  }
  
  void render_fill(int alpha) {
    fill(cor, alpha);
    rect(x, y, w, h);
  }
  
  boolean isOver() {
    if ((mouseX<x+w) && (mouseX>x) && (mouseY<=y+h) && (mouseY>=y)) {
      return true;
    }
    return false;
  }
  
  // abstract void click();
  // abstract void render(int alpha);
}