PGraphics canvas1, canvas2;
boolean showMiniMap = false;
boolean guides = false;
PVector eyePosition = new PVector();
float eyeOrientation = 0;
float eyeScaling = 1;
String renderer = P2D;

PImage universe;
PImage sun;
PImage mercury;
PImage venus;
PImage earth;
PImage moon;

float angle;

void setup(){
  size(1600, 1000, renderer);
  canvas1 = createGraphics(width, height, renderer);
  canvas2 = createGraphics(width/4, height/4, renderer);
  
  angle = 0;
  universe = loadImage("universe.jpeg");
  sun = loadImage("Sun.png");
  mercury = loadImage("Mercurio.png");
  venus = loadImage("venus.png");
  earth = loadImage("Earth.png");
  moon = loadImage("moon.png");
}

void draw(){
  
  canvas1.beginDraw();
  canvas1.background(50);
  scene(canvas1);
  if (showMiniMap) {
    eyePosition.x = mouseX-canvas2.width/2*eyeScaling;
    eyePosition.y = mouseY-canvas2.height/2*eyeScaling;
    drawEye();
  }
  canvas1.endDraw();
  image(canvas1, 0, 0);
  if (showMiniMap) {
    canvas2.beginDraw();
    canvas2.background(255, 100);
    canvas2.translate(-eyePosition.x, -eyePosition.y);
    canvas2.scale(1/eyeScaling);
    canvas2.rotate(-eyeOrientation);    
    scene(canvas2);
    canvas2.endDraw();
    image(canvas2, 0, 0);
  }
}

void scene(PGraphics pg) {
  pg.image(universe, 0, 0);
  
  
  pg.pushMatrix();   
    pg.translate(width/2, height/2);
    
    //Sun
    pg.pushMatrix();
      pg.pushMatrix();
        pg.rotate(radians(3*angle));
        pg.scale(0.2);
        pg.image(sun,-sun.width/2,-sun.height/2);
      pg.popMatrix();
      pg.pushMatrix();
        pg.scale(2);
        pg.fill(255);        
        pg.text("Sun", -10, -20);        
      pg.popMatrix();
    pg.popMatrix();
    
    //Mercury
    pushStyle();
    pg.stroke(255);
    pg.noFill();
    if(guides)
      pg.ellipse(0, 0, 2*100, 2*100);
    popStyle();
    
    pg.pushMatrix();      
      pg.rotate(radians(10*angle));
      pg.translate(0, -100);       
      pg.pushMatrix();
        pg.scale(0.2);
        pg.rotate(radians(10*angle));
        pg.image(mercury, -mercury.width/2, -mercury.width/2);
      pg.popMatrix();
      pg.pushMatrix();
        pg.fill(255);
        pg.text("Mercury", -20, -30);
      pg.popMatrix();
    pg.popMatrix();
    
    //Venus
    pushStyle();
    pg.stroke(255);
    pg.noFill();
    if(guides)
      pg.ellipse(0, 0, 2*250, 2*250);
    popStyle();
    
    pg.pushMatrix();
      pg.rotate(radians(-5*angle));
      pg.translate(0, -250); 
      pg.pushMatrix();
        pg.scale(0.05);
        pg.rotate(radians(7*angle));
        pg.image(venus, -venus.width/2, -venus.width/2);
      pg.popMatrix();
      pg.pushMatrix();
        pg.scale(1);
        pg.fill(255);
        pg.text("Venus", -20, -30);
      pg.popMatrix();
    pg.popMatrix();
    
    //Earth
    pushStyle();
    pg.stroke(255);
    pg.noFill();
    if(guides)
      pg.ellipse(0, 0, 2*350, 2*350);
    popStyle();
    
    pg.pushMatrix();
      pg.rotate(radians(3*angle));
      pg.translate(0, -350); 
      pg.pushMatrix();
        pg.scale(0.025);
        pg.rotate(radians(20*angle));
        pg.image(earth, -earth.width/2, -earth.width/2);
      pg.popMatrix();
      pg.pushMatrix();
        pg.scale(1);
        pg.fill(255);
        pg.text("Earth", -20, -30);
      pg.popMatrix();
      //Moon
      pushStyle();
      pg.stroke(255);
      pg.noFill();
      if(guides)
        pg.ellipse(0, 0, 2*50, 2*50);
      popStyle();
      
      pg.pushMatrix();
        pg.rotate(radians(20*angle));
        pg.translate(0, -50); 
        pg.pushMatrix();
          pg.scale(0.025);
          pg.rotate(radians(20*angle));
          pg.image(moon, -moon.width/2, -moon.width/2);
        pg.popMatrix();
        pg.pushMatrix();
          pg.scale(1);
          pg.fill(255);
          pg.text("Moon", -20, -15);
        pg.popMatrix();
      pg.popMatrix();
    pg.popMatrix();
  pg.popMatrix();
  
  

}

void drawEye() {
  canvas1.pushStyle();
  canvas1.pushMatrix();
  canvas1.translate(eyePosition.x, eyePosition.y);
  canvas1.rotate(eyeOrientation);
  canvas1.scale(eyeScaling);
  canvas1.stroke(0, 255, 0);
  canvas1.strokeWeight(8);
  canvas1.noFill();
  canvas1.rect(0, 0, canvas2.width, canvas2.height);
  canvas1.popMatrix();
  canvas1.popStyle();
}


void keyPressed() {
  if (key == ' ')
    showMiniMap = !showMiniMap;
  if (key == CODED)
    if (keyCode == UP)
      eyeScaling *= 1.1;
    else if (keyCode == DOWN)
      eyeScaling /= 1.1;
    else if (keyCode == LEFT)
      eyeOrientation += .1;
    else if (keyCode == RIGHT)
      eyeOrientation -= .1;
  if (key == 'w')
    angle += 1;
  if (key == 's')
    angle -= 1;
  if (key == 'g')
    guides = !guides;
}