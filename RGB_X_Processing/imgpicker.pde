//////////////////
// Image Picker //
//////////////////

public class ImagePicker {
  int x, y, w, h;
  int alpha = 0;
  PImage ipImage;
  
  public ImagePicker (int _x, int _y, int _w, int _h) {
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
    if (use_image) {
      if (mouseButton == LEFT) { 
        new_cor = get(mouseX, mouseY);
      }
      else if (mouseButton == RIGHT) {
        File save_file = new File("C:\\galaxy.jpg");
        selectInput("Select an image file:", "load_image_callback", save_file);
        mousePressed = false;
      }
    }
  }
  
  void update_alpha() {
    if (use_image && alpha < 255) {
      alpha += ALPHA_MODIFIER;
    }
    else if (!use_image && alpha > 0) {
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
  
  void load(File selection) {
    ipImage = loadImage(selection.getAbsolutePath());
    ipImage.resize(w, h);
  }
  
  void render() {
    update_alpha();
    render_border();
    if (ipImage != null) {
      image(ipImage, x, y);
    }
    render_alpha_cover();
    if (use_image) {
      check_for_clicks();
    }
  }
}