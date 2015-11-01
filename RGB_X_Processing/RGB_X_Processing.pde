import processing.serial.*;
Serial port;

///////////////////////
// Set your COM Port //
///////////////////////
String com_port = "COM5";

int[] get_default_palette() {
  return new int[] {
    
    //////////////////////////////////////////////
    // PASTE YOUR COLOR PALETTE BELOW THIS LINE //
    //////////////////////////////////////////////
    
    0, 0, 0,     //  Color #0 Blank
    100, 0, 0,   //  Color #1 Red
    100, 25, 0,  //  Color #2 Sunset
    100, 50, 0,  //  Color #3 Orange
    100, 75, 0,  //  Color #4 Canary
    100, 100, 0, //  Color #5 Yellow
    20, 100, 0,  //  Color #6 Lime
    0, 100, 0,   //  Color #7 Green
    0, 100, 10,  //  Color #8 Sea Foam
    13, 100, 13, //  Color #9 Mint 
    0, 100, 40,  //  Color #10 Aqua
    0, 121, 73,  //  Color #11 Turquoise
    0, 100, 108, //  Color #12 Cyan
    0, 65, 100,  //  Color #13 Frostbolt
    0 , 42, 100, //  Color #14 Frozen  
    0, 22, 100,  //  Color #15 Azure
    0, 0, 100,   //  Color #16 Blue
    3, 0, 100,   //  Color #17 Cobalt
    13, 0, 100,  //  Color #18 Mothafuckin Purple
    26, 0, 100,  //  Color #19 Purple Drank
    30, 14, 100, //  Color #20 Lavender
    47, 26, 100, //  Color #21 Mauve 
    100, 25, 25, //  Color #22 Lemonade
    50, 0, 100,  //  Color #23 Bubblegum  
    75, 0, 100,  //  Color #24 Magenta  
    100, 0, 100, //  Color #25 Pink    
    100, 0, 75,  //  Color #26 Hot Pink
    100, 0, 50,  //  Color #27 Deep Pink    
    100, 0, 25,  //  Color #28 Fuscia
    100, 0, 10,  //  Color #29 Panther Pink
    35, 67, 120, //  Color #30 Lilac  
    13, 120, 100,//  Color #31 Polar   
    34, 99, 120  //  Color #32 Moonstone
    
    //////////////////////////////////////////////
    // PASTE YOUR COLOR PALETTE ABOVE THIS LINE //
    //////////////////////////////////////////////
  };
}





























///////////////////////////////////////
// BEWARE: DRAGONS BEYOND THIS POINT //
///////////////////////////////////////

















////////////////////////////////
// LAST CHANCE, TURN BACK NOW //
////////////////////////////////


























///////////////////////////////////////////
// OK, BUT DON'T SAY I DIDN'T WARN YOU.. //
///////////////////////////////////////////

color RED = color(200, 0, 0);
color WHITE = color(255, 255, 255);
color BLACK = color(0, 0, 0);
color GREY = color(55, 55, 55);

int ZOOM_AMOUNT = 15;
int IMAGE_SHIFT = 15;
int ALPHA_MODIFIER = 5;
int BRIGHTNESS_MODIFIER = 1;
int MOUSE_WHEEL_INC = 1;
int DOUBLE_CLICK_SPEED = 150;
int RAINBOW_PALETTE_BRIGHTNESS = 75;
int RAINBOW_PALETTE_CONTRAST = 127;

int SLIDER_TOP = 65;
int SLIDER_SPACE = 10;
int SLIDER_WIDTH = 90;
int SLIDER_HEIGHT = 255;

int MAX_RATIO_LENGTH = 8;
int NUM_CIRCLES = 12;
int WHEEL_SEG_SZ = 30;
int PALETTE_SIZE = 33;
int COLOR_BTN_WIDTH = 25;
int COLOR_BTN_HEIGHT = 25;
int COLOR_BTN_SPACE_X = 10;
int COLOR_BTN_SPACE_Y = 10;
int NUM_BUTTONS_ACROSS = 13;
int PALETTE_TOP = SLIDER_TOP + SLIDER_HEIGHT + 10;
int[] PRESET_PALETTE = get_default_palette();
boolean PRESET_HORIZONTAL = false;

// Look, I took the time to add these dumb variables so you'd know what everything should do.. also so I don't forget either
palette preset_palette = new palette(PRESET_PALETTE, PALETTE_TOP, PALETTE_SIZE, COLOR_BTN_WIDTH, COLOR_BTN_HEIGHT, COLOR_BTN_SPACE_X, COLOR_BTN_SPACE_Y, NUM_BUTTONS_ACROSS, PRESET_HORIZONTAL);

float[] rgb_ratio = {0.0, 0.0, 0.0};
boolean connected = false;
boolean clearpalette = false;
boolean fillpalette = false;
boolean use_clrmodes = false;
boolean use_wheel = false;
boolean use_imgpicker = false;
boolean use_sliders = true;
boolean use_clrpicker = false;
color new_cor = BLACK;
color main_cor = BLACK;
clrmodes color_modes;
ColorWheel color_wheel;
ColorPicker color_picker;
ImagePicker image_picker;
sliderV sV1, sV2, sV3, sInc;
importpalette import_cp;
exportpalette export_cp;
btn_view btn_view_btns;

String IMAGES_DIR;
String COLOR_MODE_DIR;
String COLOR_PALETTE_DIR;

void setup() {
  size(500, 570);
  //surface.setResizable(true);
  surface.setTitle("Slider Pro for the OSM by Greg Roberti");
  
  try {
    // check on the output monitor wich port is available on your machine
    port = new Serial(this, com_port, 115200);
    connected = true;
    println("Connected on " + com_port);
  }
  catch (Exception e) {
    println("ERROR: Unable to connect on " + com_port);
    print("Your available serial ports are: ");
    println(String.join(",", Serial.list()));
  }
  
  IMAGES_DIR = sketchPath("") + "images";
  COLOR_MODE_DIR = sketchPath("") + "color_modes";
  COLOR_PALETTE_DIR = sketchPath("") + "color_palettes";
  
  import_cp = new importpalette(10, height-30);
  export_cp = new exportpalette(width-90, height-30);
  
  btn_view_btns = new btn_view(width/2 - 100, height-30, 120);
  
  color_modes = new clrmodes(10, 40, width - 20, 300, 8);
  color_wheel = new ColorWheel(0, 0, width, height/3*2);
  color_picker = new ColorPicker(10, 40, width - 20, 300);
  image_picker = new ImagePicker(10, 40, width - 20, 300);

  // create 3 instances of the sliderV class
  sV1 = new sliderV(((width-((SLIDER_WIDTH+SLIDER_SPACE)*3))/2) + (SLIDER_WIDTH+SLIDER_SPACE)*0,
                      SLIDER_TOP, SLIDER_WIDTH, SLIDER_HEIGHT, 0, #FF0000, 0, "R: ");
  sV2 = new sliderV(((width-((SLIDER_WIDTH+SLIDER_SPACE)*3))/2) + (SLIDER_WIDTH+SLIDER_SPACE)*1,
                      SLIDER_TOP, SLIDER_WIDTH, SLIDER_HEIGHT, 0, #03FF00, 1, "G: ");
  sV3 = new sliderV(((width-((SLIDER_WIDTH+SLIDER_SPACE)*3))/2) + (SLIDER_WIDTH+SLIDER_SPACE)*2,
                      SLIDER_TOP, SLIDER_WIDTH, SLIDER_HEIGHT, 0, #009BFF, 2, "B: ");
  
  preset_palette.initialize_color_buttons();
}

void render_everything() {
  background(BLACK);
  
  if (use_clrpicker) {
    color_picker.render();
  }
  
  if (use_imgpicker) {
    image_picker.render();
  }
  
  sV1.render();
  sV2.render();
  sV3.render();
  render_ratio_txt();
  color_wheel.render();
  
  render_help_txt();
  import_cp.render(255);
  export_cp.render(255);
  btn_view_btns.render(255);
  
  color_modes.render();
  preset_palette.render();
}

void draw() {
  render_everything();

  if(new_cor != main_cor) {
    main_cor = new_cor;
    
    int[] rgb = getRGB(main_cor);
    update_sliders(rgb);
    
    if (connected) {
      port.write('R');
      port.write(rgb[0]);
      port.write('G');
      port.write(rgb[1]);
      port.write('B');
      port.write(rgb[2]);
    }
  }
}