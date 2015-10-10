////////////////
// Color Math //
////////////////

float[] RGBtoHSL(int[] rgb) {
  float var_R = float(rgb[0])/255;
  float var_G = float(rgb[1])/255;
  float var_B = float(rgb[2])/255;
  float var_Min = min(var_R, var_G, var_B);
  float var_Max = max(var_R, var_G, var_B);
  float del_Max = var_Max - var_Min;
  
  //println("var_R="+var_R);
  //println("var_G="+var_G);
  //println("var_B="+var_B);
  //println("var_Min="+var_Min);
  //println("var_Max="+var_Max);
  //println("del_Max="+del_Max);
  
  float H = 0;
  float S = 0;
  float L = (var_Max + var_Min) / 2;
  
  if (del_Max != 0) {
     if (L < 0.5) {
       S = del_Max / (var_Max + var_Min);
     }
     else {
       S = del_Max / (2 - var_Max - var_Min);
     }
  
     float del_R = (((var_Max - var_R) / 6) + (del_Max / 2)) / del_Max;
     //println("del_R="+del_R);
     float del_G = (((var_Max - var_G) / 6) + (del_Max / 2)) / del_Max;
     //println("del_G="+del_G);
     float del_B = (((var_Max - var_B) / 6) + (del_Max / 2)) / del_Max;
     //println("del_B="+del_B);
  
     if (var_R == var_Max) {
       H = del_B - del_G;
     }
     else if (var_G == var_Max) {
       H = ( 1 / 3 ) + del_R - del_B;
     }
     else if (var_B == var_Max) {
       H = ( 2 / 3 ) + del_G - del_R;
     }
  
     if (H < 0) {
       H += 1;
     }
     if (H > 1) {
       H -= 1;
    }
  }
  
  return new float[] {H, S, L};
}

int[] HSLtoRGB(float[] hsl) {
  float R = 0;
  float G = 0;
  float B = 0;
  float var_1 = 0;
  float var_2 = 0;
  if (hsl[1] == 0)
  {
    R = hsl[2] * 255;
    G = hsl[2] * 255;
    B = hsl[2] * 255;
  }
  else
  {
    if (hsl[2] < 0.5) {
      var_2 = hsl[2] * (1 + hsl[1]);
    }
    else {
      var_2 = (hsl[2] + hsl[1]) - (hsl[1] * hsl[2]);
    }

    var_1 = 2 * hsl[2] - var_2;
    
    
    //println("var_1="+var_1);
    //println("var_2="+var_2);

    R = 255 * Hue_2_RGB(var_1, var_2, hsl[0] + (1 / 3)); 
    G = 255 * Hue_2_RGB(var_1, var_2, hsl[0]);
    B = 255 * Hue_2_RGB(var_1, var_2, hsl[0] - (1 / 3));
  }
  
  //println("R="+R);
  //println("G="+G);
  //println("B="+B);
  
  return new int[] {int(R), int(G), int(B)};
}

float Hue_2_RGB(float v1, float v2, float vH) {
  if (vH < 0) {
    vH += 1;
  }
  if (vH > 1) {
    vH -= 1;
  }
  if ((6 * vH) < 1) {
    return v1 + (v2 - v1) * 6 * vH;
  }
  if ((2 * vH) < 1) {
    return v2;
  }
  if ((3 * vH) < 2) {
    return v1 + (v2 - v1) * ((2 / 3) - vH) * 6;
  }
  return v1;
}