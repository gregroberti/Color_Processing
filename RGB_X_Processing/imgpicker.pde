//////////////////
// Image Picker //
//////////////////

public class ImagePicker {
  int x, imgx, y, imgy, w, imgw, h, imgh;
  int alpha = 0;
  PImage ipImage;
  
  public ImagePicker (int _x, int _y, int _w, int _h) {
    x = imgx = _x;
    y = imgy = _y;
    w = imgw = _w;
    h = imgh = _h;
  }
  
  void zoom(float amnt) {
    if (ipImage == null) {
      return;
    }
    
    // Zoom by height
    int new_height = int(ipImage.height-ZOOM_AMOUNT*amnt);
    int new_width = int((float)ipImage.width/ipImage.height*new_height);
    
    // Zoom by width
    //int new_width = int(ipImage.width-ZOOM_AMOUNT*amnt);
    //int new_height = int((float)ipImage.height/ipImage.width * new_width);
    
    if (new_height < h || new_width < w) {
      return;
    }
    else if ((new_width > 0) && (new_height > 0)) {
      int new_imgx = imgx - (new_width - imgw)/2;
      int new_imgy = imgy - (new_height - imgh)/2;
      imgw = new_width;
      imgh = new_height;
      update_imgx_imgy(new_imgx, new_imgy);
      ipImage.resize(imgw, imgh);
    }
  }
  
  void shift_img(int _x, int _y) {
    if ( _x == 0 && _y == 0) {
      println("imgx="+imgx);
      imgx = x/w - imgx/imgw + x;
      println("imgx="+imgx);
      
      println("imgy="+imgy);
      imgy = y/h - imgy/imgh + y;
      println("imgy="+imgy);
    }
    else {
      int new_imgx = imgx + _x;
      int new_imgy = imgy + _y;
      
      update_imgx_imgy(new_imgx, new_imgy);
    }
  }
  
  void update_imgx_imgy(int new_imgx, int new_imgy) {
    if (new_imgx + imgw < x + w) {
        new_imgx = x + w - imgw;
      }
      if (new_imgx > x) {
        new_imgx = x;
      }
      if (new_imgy + imgh < y + h) {
        new_imgy = y + h - imgh;
      }
      if (new_imgy > y) {
        new_imgy = y;
      }
      
      imgx = new_imgx;
      imgy = new_imgy;
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
        mousePressed = false;
        File image_file = new File(IMAGES_DIR + "\\*.jpg");
        selectInput("Select an image file", "load_image_callback", image_file);
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
  
  void render_perimeter_mask(int _x, int _y, int _w, int _h) {
    fill(BLACK);
    rect(_x, _y, _w, _h);
  }
  
  void render_border() {
    fill(WHITE, alpha);
    rect(x-1, y-1, w+2, h+2);
  }
  
  void load(File selection) {
    imgx = x;
    imgy = y;
    imgw = w;
    imgh = h;
    
    ipImage = loadImage(selection.getAbsolutePath());
    ipImage.resize(imgw, imgh);
  }
  
  void render() {
    update_alpha();
    render_border();
    if (ipImage != null) {
      image(ipImage, imgx, imgy);
    }
    else {
      fill(BLACK, alpha);
      text("Right-click to select an image", x+(w/2)-80, y+(h/2));
    }
    render_alpha_cover();
    if (use_image) {
      check_for_clicks();
    }
    
    render_perimeter_mask(0, 0, width, y-1);
    render_perimeter_mask(0, y+h+1, width, height-y+h);
    render_perimeter_mask(0, 0, x-1, height);
    render_perimeter_mask(x+w+1, 0, width-y-h, height);
  }
}