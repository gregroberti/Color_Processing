//////////////////
// RGB Sliders  //
//////////////////

/* 
Slider Class - www.guilhermemartins.net
based on www.anthonymattox.com slider class
*/
class sliderV {
  int x, y, w, h, p, id;
  int alpha = 255;
  color cor;
  String name;

  sliderV (int _x, int _y, int _w, int _h, int _p, color _cor, int _id, String _name) {
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    p = _p;
    cor = _cor;
    id = _id;
    name = _name;
  }
  
  void render_min() {
    fill(GREY, alpha);
    rect(x-1, y+h+4, w, 15);
    
    fill(WHITE, alpha);
    text("MIN", x+30, y+h+17);
  }
  
  void render_max() {
    fill(GREY, alpha);
    rect(x-1, y-19, w, 15);
    
    fill(WHITE, alpha);
    text("MAX", x+30, y-7);
  }
  
  void render_bar() {
    fill(cor, alpha);
    rect(x-1, y-4, w, h+10);
  }
  
  void render_slider() {
    fill(BLACK, alpha);
    rect(x, h-p+y-5, w-2, 13);
    
    fill(WHITE, alpha);
    text(p + " " + name, x+2, h-p+y+6);
  }
  
  void check_out_of_range() {
    if (p<0) {
      p=0;
    }
    else if (p>h) {
      p=h;
    }
  }
  
  void update_alpha() {
    if (use_sliders && alpha < 255) {
      alpha += ALPHA_MODIFIER;
    }
    else if (!use_sliders && alpha > 0) {
      alpha -= ALPHA_MODIFIER*2;
    }
  }

  void render() {
    update_alpha();
    noStroke();
    render_min();
    render_max();
    render_bar();
    render_slider();
    
    if(mousePressed && isOver()) {
      click();
    }
  }
  
  void click() {
    p = h-(mouseY-y);
    update_main_color();
  }
  
  boolean isOver() {
    if ((mouseX>x) && (mouseX<x+w) &&
        (mouseY>=y-20) && (mouseY<=y+h+20)) {
      return true;
    }
    return false;
  }
  
  void update_main_color() {
    check_out_of_range();
    int[] rgb = getRGB(main_cor);
    rgb[id] = p;
    new_cor = color(rgb[0], rgb[1], rgb[2]);
  }
}