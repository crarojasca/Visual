import controlP5.*;
import processing.video.*;

  
import processing.video.*;

Capture cam;
PShader filter;
String currentFilter;
float[] values;
float coeff;
boolean lum;

void setup() {
  size(640, 480, P3D);
  currentFilter = "No filter";
  filter = loadShader("filters.glsl");
  values = new float[] {0.0,0.0,0.0,0.0,1.0,0.0,0.0,0.0,0.0};
  coeff = 1.0;
  lum = false;

  String[] cameras = Capture.list();
  
  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) {
      println(cameras[i]);
    }
    
    cam = new Capture(this, cameras[0]);
    cam.start();     
  }      
}

void draw() {  
  filter.set("values", values);
  filter.set("coeff", coeff);
  filter.set("lum", lum);
  
  if (cam.available() == true) {
    cam.read();
  }
  image(cam, 0, 0);
  filter(filter);
}

void keyPressed() {
  switch(key){
    case('1'):
      currentFilter = "No filter";
      values = new float[] {0.0,0.0,0.0,0.0,1.0,0.0,0.0,0.0,0.0};
      coeff = 1.0;
      lum = false;
      break;
    case('2'):
      currentFilter = "Edge Detection 0";
      values = new float[] {1.0,0.0,-1.0,0.0,0.0,0.0,-1.0,0.0,1.0};
      coeff = 1.0;
      lum = false;
    case('3'):
      currentFilter = "Edge Detection -4";
      values = new float[] {0.0,1.0,0.0,1.0,-4.0,1.0,0.0,1.0,0.0};
      coeff = 1.0;
      lum = false;
      break;
    case('4'):
      currentFilter = "Edge Detection 8";
      values = new float[] {-1.0,-1.0,-1.0,-1.0,8.0,-1.0,-1.0,-1.0,-1.0};
      coeff = 1.0;
      lum = false;
      break;
    case('5'):
      currentFilter = "Sharpen";
      values = new float[] {0.0,-1.0,0.0,-1.0,5.0,-1.0,0.0,-1.0,0.0};
      coeff = 1.0;
      lum = false;
      break;
   case('6'):
      currentFilter = "blur";
      values = new float[] {1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0};
      coeff = 1.0/9.0;
      lum = false;
      break;
   case('7'):
     currentFilter = "Gaussian blur";
     values = new float[] {1.0,2.0,1.0,2.0,4.0,2.0,1.0,2.0,1.0};
     coeff = 1.0/16.0;
     lum = true;
     break;
   case('8'):
     currentFilter = "Emboss";
     values = new float[] {-1.0,-1.0,0.0,-1.0,0.0,1.0,0.0,1.0,1.0};
     coeff = 1.0;
     lum = true;
     break;
   case('9'):
     currentFilter = "Sharpen2";
     //currentShader = sharpen2;
     break;
    default:
      break;    
  }
}