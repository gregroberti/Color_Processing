//////////////////
// Color Picker //
//////////////////

public class ColorPicker 
{
  int x, y, w, h, c;
  PImage cpImage;
  
  public ColorPicker (int _x, int _y, int _w, int _h, color _c)
  {
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    c = _c;
    
    cpImage = new PImage(w, h);
    
    initialize();
  }
  
  private void initialize()
  {
    // draw color.
    int cw = w - 60;
    for( int i=0; i<cw; i++ ) 
    {
      float nColorPercent = i / (float)cw;
      float rad = (-360 * nColorPercent) * (PI / 180);
      int nR = (int)(cos(rad) * 127 + 128) << 16;
      int nG = (int)(cos(rad + 2 * PI / 3) * 127 + 128) << 8;
      int nB = (int)(Math.cos(rad + 4 * PI / 3) * 127 + 128);
      int nColor = nR | nG | nB;
      
      setGradient( i, 0, 1, h/2, 0xFFFFFF, nColor);
      setGradient( i, (h/2), 1, h/2, nColor, 0x000000);
    }
  }

  private void setGradient(int _x, int _y, float _w, float _h, color _c1, color _c2)
  {
   int[] rgb1 = getRGB(_c1);
   int[] rgb2 = getRGB(_c2);
   float deltaR = rgb2[0] - rgb1[0];
   float deltaG = rgb2[1] - rgb1[1];
   float deltaB = rgb2[2] - rgb1[2];

   for (int j = _y; j<(_y+_h); j++)
   {
     int c = color(rgb1[0]+(j-_y)*(deltaR/_h), rgb1[1]+(j-_y)*(deltaG/_h), rgb1[2]+(j-_y)*(deltaB/_h));
     cpImage.set(_x, j, c);
   }
  }
  
  boolean isOver() {
    if (mouseX >= x && mouseX < x + w && mouseY >= y && mouseY < y + h) {
      return true;
    }
    return false;
  }
  
  void click() {
    c = get( mouseX, mouseY );
    new_cor = c;
  }
  
  void render() {
    image(cpImage, x, y);
    
    if(mousePressed && isOver()) {
      click();
    }
  }
}