///////////////////////
// Button Base Class //
///////////////////////

class btnbase extends elembase {
  int lclk = -1;
  String btn_txt = "";
  int btn_txt_x = 0;
  int btn_txt_y = 0;
  
  void render_text(int alpha) {
    fill(WHITE, alpha);
    text(btn_txt, btn_txt_x, btn_txt_y);
  }
  
  void render(int alpha) {
    noStroke();
    render_border(alpha);
    render_fill(alpha);
    render_text(alpha);
  }
}