import controlP5.*;
import processing.video.*;

PImage label;
PShape can;
float angle;
String current;
float zoom = 0;

String[] cameras;

Capture cam;

PFont font;
PGraphics canvas1, canvas2;
PGraphics matrix;
//eye params
PVector eyePosition = new PVector();
float eyeOrientation = 0;
float eyeScaling = 0.5;

PShader currentShader;
PShader convolutionMatrix;

boolean useLight;
boolean useTexture;
int convolution;
float[] values;
float coeff;
boolean lum;

boolean canvas2Active;
boolean cameraActive;


ControlP5 cp5;

void setup() {
  size(800, 500, P3D);
  canvas1 = createGraphics(width, height, P3D);
  canvas2 = createGraphics(width/2-150, height/2-50, P3D);
  matrix = createGraphics(width/2-150, height/2-50, P3D);
  font = createFont("Arial", 12);
  textFont(font, 12);
  
  cameras = Capture.list();
  
  label = loadImage("flores.jpg");
  values = new float[] {0.0,0.0,0.0,0.0,1.0,0.0,0.0,0.0,0.0};
  coeff = 1.0;
  lum = false;
  canvas2Active = false;
  cameraActive = false;
  //can = createCan(100, 200, 32, label);
  
  //Shaders
  convolutionMatrix = loadShader("convolutionMatrix.glsl");
  
  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) {
      println(cameras[i]);
    }
  }
  cam = new Capture(this, cameras[0]); 
  cam.start(); 
  
  current = "Identity";
  currentShader = convolutionMatrix;
  useLight = true;
  useTexture = true;
  
 
  drawMatrix();
    
  //identity.set("valor", 1);
  //bwShader = loadShader("blur.glsl");

}

void draw() {
  canvas1.beginDraw();
  canvas1.background(0);
  scene(canvas1);
  if(canvas2Active){
    eyePosition.x = mouseX;
    eyePosition.y = mouseY;
    drawEye();
  }
  //drawMatrix();
  canvas1.endDraw();
  
  image(canvas1,0,0);
    if (canvas2Active) {
    canvas2.beginDraw();
    canvas2.background(255, 100);
    
    // the eye matrix is defined as the inverted matrix
    // used to set the drawEye() for canvas1:
    // inv(T(eyePosition)*R(eyeOrientation)*S(eyeScaling)) =
    // inv(S(eyeScaling)) * inv(R(eyeOrientation)) * inv(T(eyePosition)) =
    // S(1/eyeScaling) * R(-eyeOrientation) * T(-eyePosition)
    //canvas2.scale(1/eyeScaling);
    canvas2.rotate(-eyeOrientation);
    canvas2.translate(-eyePosition.x, -eyePosition.y);
    
    sceneCanvas2(canvas2);
    canvas2.endDraw();
    // draw canvas onto screen
    image(canvas2, eyePosition.x, eyePosition.y);
    }
    //matrix.beginDraw();
    //matrix.background(255, 100);
    //sceneMatrix(matrix);
    //matrix.endDraw();
    
}

void drawLandscape(PGraphics pg){
  if(cameraActive){
    if (cam.available() == true) 
      cam.read();
    pg.image(cam, 0, 0, width, height);
  }
  else{
    //cam.stop();
  
  pg.image(label, 0, 0, width, height); 
  }
  //pg.filter(currentShader); 
  if (cam.available() == true) {
    cam.read();
  }
  image(cam, 0, 0);
  filter(convolutionMatrix);

}

void drawMatrix(){
  String[][] textfieldNames = {{"1", "2", "3"}, {"4", "5", "6"} ,{"7", "8", "9"}};
  PFont font = createFont("arial",20);
  
  cp5 = new ControlP5(this);
  int k, y;
  y = 340;
  for(int i=0; i<3; i++){
    k = 20;
    for(int j=0; j<3; j++){
      //println(textfieldNames[i][j]);
      cp5.addTextfield(textfieldNames[i][j])
       .setPosition(k,y)
       .setSize(40,40)
       .setFont(font)
       .setFocus(true)
       .setColor(color(255,255,255))
       ;
     k += 40;
    }
    y += 40;
  }
  
  cp5.addBang("clear")
     .setPosition(20,460)
     .setSize(120,30)
     .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
     ;  
}

void sceneCanvas2(PGraphics pg){
  if(cameraActive)
    pg.image(cam, 0, 0, width, height);
  else
    pg.image(label, 0, 0, width, height); 
  convolutionMatrix.set("values", values);
  convolutionMatrix.set("coeff", coeff);
  convolutionMatrix.set("lum", lum);
  pg.filter(convolutionMatrix);
}
void scene(PGraphics pg) {
  pg.pushMatrix(); 
  
  
  drawLandscape(pg);
   
  pg.text("Convolution type: " + current , 20, 50);
  pg.popMatrix();
  
}

void drawEye() {
  canvas1.pushStyle();
  // define an eye frame L1 (respect to the world)
  canvas1.pushMatrix();
  // the position of the minimap rect is defined according to eye parameters as:
  // T(eyePosition)*R(eyeOrientation)*S(eyeScaling)
  canvas1.translate(eyePosition.x, eyePosition.y);
  canvas1.rotate(eyeOrientation);
  canvas1.scale(eyeScaling);
  canvas1.stroke(0, 0, 0);
  canvas1.strokeWeight(8);
  //canvas1.noFill();
  canvas1.rect(0, 0, canvas2.width, canvas2.height);
  // return to World
  canvas1.popMatrix();
  canvas1.popStyle();
}

void keyPressed() {
  useTexture = true;
  coeff = 1.0;
  lum = false;
  if(key == 'q' || key == 'Q'){
   canvas2Active =  !canvas2Active;
  }
  
  if(canvas2Active){
  switch(key){
    case('a'):
      current = "Identity";
      values = new float[] {0.0,0.0,0.0,0.0,1.0,0.0,0.0,0.0,0.0};
      //currentShader = identity;
      break;
    case('s'):
      current = "Edge Detection 0";
      values = new float[] {1.0,0.0,-1.0,0.0,0.0,0.0,-1.0,0.0,1.0};
      break;
    case('d'):
      current = "Edge Detection -4";
      values = new float[] {0.0,1.0,0.0,1.0,-4.0,1.0,0.0,1.0,0.0};
      //currentShader = edgeDetection4;
      break;
    case('f'):
      current = "Edge Detection 8";
      values = new float[] {-1.0,-1.0,-1.0,-1.0,8.0,-1.0,-1.0,-1.0,-1.0};
      //currentShader = edgeDetection8;
      break;
    case('g'):
      current = "Sharpen";
      values = new float[] {0.0,-1.0,0.0,-1.0,5.0,-1.0,0.0,-1.0,0.0};
      break;
   case('h'):
      current = "blur";
      values = new float[] {1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0};
      coeff = 1.0/9.0;
      break;
   case('i'):
     current = "Gaussian blur";
     values = new float[] {1.0,2.0,1.0,2.0,4.0,2.0,1.0,2.0,1.0};
     coeff = 1.0/16.0;
     break;
   case('j'):
     current = "Emboss";
     values = new float[] {-1.0,-1.0,0.0,-1.0,0.0,1.0,0.0,1.0,1.0};
     lum = true;
     break;
   case('k'):
     current = "Sharpen2";
     //currentShader = sharpen2;
     break;
    default:
      break;
    
  }

    for(int i=0; i<9; i++){
      println("i: " + i + " , "+ str(values[i]));
      cp5.get(Textfield.class,str(i+1)).setValue(str(values[i]));
    }
  }else
    current = " ";
  //println(current);
  //pg.filter(currentShader);
  int r = 0;
  float n[] = new float[9];
  if (key == ' '){
    
    for(int i=0; i<9; i++){
      String k = str(i+1);
      //println(k);
      n[r] = int(cp5.get(Textfield.class,k).getText());
      
      println(i + " " + n[r]);
      r++;
    }
    values = n;
    canvas2Active = true;
}

   if(key == 'c' || key == 'C'){
     cameraActive =  !cameraActive;
  }
}

void activarCamera(){
  if (cam.available() == true) {
    cam.read();
  }
  image(cam, 0, 0);
  filter(convolutionMatrix);
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  if(e < 0){
     eyeScaling += .03;
  }else{
     eyeScaling -= .03;
  }
  println(e);
}

public void clear() {
  for(int i=0; i<9; i++)
    cp5.get(Textfield.class,str(i+1)).clear();
}