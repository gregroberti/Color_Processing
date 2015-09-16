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

int MOUSE_WHEEL_INC = 1;
int DOUBLE_CLICK_SPEED = 150;

int FORM_WIDTH = 500;
int FORM_HEIGHT = 550;

int SLIDER_TOP = 65;
int SLIDER_SPACE = 10;
int SLIDER_WIDTH = 90;
int SLIDER_HEIGHT = 255;

int MAX_PREVIEW_SIZE = 255;
int PREVIEW_BTN_SPACE_X = 5;
int PREVIEW_BTN_SPACE_Y = 15;
int PREVIEW_TOP = SLIDER_TOP + SLIDER_HEIGHT;
int[] PREVIEW_PALETTE = {0,0,0,0,0,0,0,0,0};
int PREVIEW_SIZE = PREVIEW_PALETTE.length/3;
boolean PREVIEW_HORIZONTAL = true;

int PALETTE_SIZE = 33;
int COLOR_BTN_WIDTH = 25;
int COLOR_BTN_HEIGHT = 25;
int COLOR_BTN_SPACE_X = 10;
int COLOR_BTN_SPACE_Y = 10;
int NUM_BUTTONS_ACROSS = 13;
int PALETTE_TOP = PREVIEW_TOP + COLOR_BTN_HEIGHT + (COLOR_BTN_SPACE_Y*2);
int[] PRESET_PALETTE = get_default_palette();
boolean PRESET_HORIZONTAL = false;

// Look, I took the time to add these dumb variables so you'd know what everything should do.. also so I don't forget either
palette preview_palette = new palette(PREVIEW_PALETTE, PREVIEW_TOP, PREVIEW_SIZE, COLOR_BTN_WIDTH, COLOR_BTN_HEIGHT, PREVIEW_BTN_SPACE_X, PREVIEW_BTN_SPACE_Y, MAX_PREVIEW_SIZE, PREVIEW_HORIZONTAL);
palette preset_palette = new palette(PRESET_PALETTE, PALETTE_TOP, PALETTE_SIZE, COLOR_BTN_WIDTH, COLOR_BTN_HEIGHT, COLOR_BTN_SPACE_X, COLOR_BTN_SPACE_Y, NUM_BUTTONS_ACROSS, PRESET_HORIZONTAL);

float[] rgb_ratio = {0.0, 0.0, 0.0};
boolean clearpalette = false;
boolean live_preview = false;
color new_cor = color(0, 0, 0);
color main_cor = color(0, 0, 0);
sliderV sV1, sV2, sV3, sInc;
importbtn import_cp = new importbtn(10, 10);
exportbtn export_cp = new exportbtn(FORM_WIDTH - 50, 10);

void setup() {
  // Update FORM_WIDTH & FORM_HEIGHT
  size(500, 550);
  
  println("Available serial ports:");
  println(Serial.list());

  // check on the output monitor wich port is available on your machine
  port = new Serial(this, com_port, 115200);

  // create 3 instances of the sliderV class
  sV1 = new sliderV(((FORM_WIDTH-((SLIDER_WIDTH+SLIDER_SPACE)*3))/2) + (SLIDER_WIDTH+SLIDER_SPACE)*0,
                      SLIDER_TOP, SLIDER_WIDTH, SLIDER_HEIGHT, 0, #FF0000, 0, "Red");
  sV2 = new sliderV(((FORM_WIDTH-((SLIDER_WIDTH+SLIDER_SPACE)*3))/2) + (SLIDER_WIDTH+SLIDER_SPACE)*1,
                      SLIDER_TOP, SLIDER_WIDTH, SLIDER_HEIGHT, 0, #03FF00, 1, "Green");
  sV3 = new sliderV(((FORM_WIDTH-((SLIDER_WIDTH+SLIDER_SPACE)*3))/2) + (SLIDER_WIDTH+SLIDER_SPACE)*2,
                      SLIDER_TOP, SLIDER_WIDTH, SLIDER_HEIGHT, 0, #009BFF, 2, "Blue");
  
  preview_palette.initialize_color_buttons();
  preset_palette.initialize_color_buttons();
}

void render_everything() {
  background(0);

  sV1.render();
  sV2.render();
  sV3.render();
  
  render_help_txt();
  render_ratio_txt();
  
  import_cp.render();
  export_cp.render();
  
  preset_palette.render();
  preview_palette.render();
}

void draw() {
  if(!live_preview) {
    render_everything();
  
    if(new_cor != main_cor) {
      main_cor = new_cor;
      
      int rgb[] = getRGB(main_cor);
      update_sliders(rgb);
      
      port.write('R');
      port.write(rgb[0]);
      port.write('G');
      port.write(rgb[1]);
      port.write('B');
      port.write(rgb[2]);
    }
  }
}