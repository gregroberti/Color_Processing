//////////////////
// RGB Sliders  //
//////////////////

/* 
Slider Class - www.guilhermemartins.net
based on www.anthonymattox.com slider class
*/
class sliderV {
  int x, y, w, h, p, id;
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
    fill(color(55, 55, 55));
    rect(x-1, y+h+4, w, 15);
    
    fill(255);
    text("MIN", x+30, y+h+17);
  }
  
  void render_max() {
    fill(color(55, 55, 55));
    rect(x-1, y-19, w, 15);
    
    fill(255);
    text("MAX", x+30, y-7);
  }
  
  void render_bar() {
    fill(cor);
    rect(x-1, y-4, w, h+10);
  }
  
  void render_slider() {
    fill(0);
    rect(x, h-p+y-5, w-2, 13);
    
    fill(255);
    text(p + " " + name, x+2, h-p+y+6);
  }

  void render() {
    noStroke();
    
    // MIN AREA
    render_min();
    render_max();
    render_bar();
    render_slider();
    
    if (mouseX<x+w && mouseX>x && (mouseY<=y+h+20) && (mouseY>=y-20)) {
      if(mousePressed==true) {
        p = h-(mouseY-y);
      }
      
      if (p<0) {
        p=0;
      }
      else if (p>h) {
        p=h;
      }
    }
  }
  
  boolean isOver() {
    if ((mouseX>x) && (mouseX<x+w) &&
        (mouseY>=y-150) && (mouseY<=y+h+150)) {
      return true;
    }
    return false;
  }
}