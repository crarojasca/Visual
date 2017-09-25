int illusions = 7;
int current = 1;
//toggle illusion activation
boolean active = true;

color black = color(0,0,0);
color white = color(255,255,255);
color blue = color(0,0,150);
color yellow = color(150,150,0);
color red = color(200,0,0);
color pink = color(255, 43, 206);
color gray = color(242,242,242);

float angle = 0;
float radius;
float step = 0;
boolean enable = false;
boolean square = false;
int x;
int y;
//Example 5
void setup() {
  size(800, 800);
}

void draw() {
  pushStyle();
  switch(current) {
  case 1:
    scintillating();
    break;
    // implement from here. Don't forget to add break for each case
  case 2:
    curveChess();
    break;
  case 3:
    circlesIllusion();
    break;
  case 4:
    spiralBlowing();
    break;
  case 5:
    circlesMovement();
    break;
  case 6:
    race();
    break;
  case 7:
    pinkCircle();
    break;
    //println("implementation is missed!");
  }
  popStyle();
}

// switch illusion using the spacebar
void keyPressed() {
  if (key == ' '){
    current = current < illusions ? current+1 : 1;
    background(255);
    step = 0;
    if(current == 4){
      angle = 0;
      radius = 600;
    } else if(current == 5){
      angle = 0;
      radius = 0;
      enable = false;
      x = 200;
      y = 200;
    } else if(current == 6){
      x = 0;
      y = 0;
    } else if(current == 7){
      x = 0;
      y = 0;
    }
  }
  if (key == 'a')
    active = !active;
}

// Complete info for each illusion
 
/*
 Scintillating Grid
 Author: E. Lingelbach, 1994
 Code adapted from Rupert Russell implementation
 Tags: Physiological illusion, Hermann grid illusion
*/
void scintillating() {
  background(0);          // black background

  //style
  strokeWeight(3);        // medium weight lines 
  smooth();               // antialias lines
  stroke(100, 100, 100);  // dark grey colour for lines

  int step = 25;          // grid spacing

  //vertical lines
  for (int x = step; x < width; x = x + step) {
    line(x, 0, x, height);
  }

  //horizontal lines
  for (int y = step; y < height; y = y + step) {
    line(0, y, width, y);
  }

  // Circles
  if (active) {
    ellipseMode(CENTER);
    stroke(255, 255, 255);  // white circles
    for (int i = step; i < width -5; i = i + step) {
      for (int j = step; j < height -15; j = j + step) {
        strokeWeight(6); 
        point(i, j);
        strokeWeight(3);
      }
    }
  }
}

void curveChess() {
  background(white);          // black background
  fill(black);
  

  for (int y = 0; y < height; y = y + 100) {   
     line(0,y,800,y);
     if(mousePressed == false){
        int x= 0;
        if (y%200 == 0){
          for (x = 0; x < width; x = x + 100) {
            rect(x, y, 50, 100);
          }
        }else{
          for (x = 20; x < width; x = x + 100) {
            rect(x, y, 50, 100);
          }
        }  
     }
  
  } 

 
}

void circlesIllusion() {
  background(255);          // white background  
  
  //Central Circles
  for (int x = 267; x < width; x = x + 267){
    ellipse(x, 400, 50, 50);
  }  
  if(mousePressed == false){
    //Big Circles
    fill(black);    
    //BIG
    ellipse(267, 325, 75, 75);
    ellipse(267, 475, 75, 75);
    
    ellipse(192, 360, 75, 75);
    ellipse(342, 360, 75, 75);
    
    ellipse(192, 440, 75, 75);
    ellipse(342, 440, 75, 75);
    
    //SMALL
    ellipse(534, 350, 25, 25);
    ellipse(534, 450, 25, 25);
    
    ellipse(484, 370, 25, 25);
    ellipse(584, 370, 25, 25);
    
    ellipse(484, 430, 25, 25);
    ellipse(584, 430, 25, 25);
  }  
}

void spiralBlowing(){ 

  angle += PI/150;  
  radius = radius/1.00049;
  step += 1;
  
  noStroke();
  if(step%16 == 0){
    fill(255, 255, 255);
    enable = true;
  }else if(step%8 == 0){
    fill(black); 
    enable = false;
  }else
    if(enable == false)
     fill(0, 200, 0); 
    else
     fill(200, 0, 0);   
  translate(400,400);
  rotate(angle);    
  ellipse(radius, 0, radius / 7, radius / 3); 
}

void circlesMovement(){ 
  translate(x,y);  
  noStroke(); 
  float h = radius / 8;
  float w = radius / 5; 
  rotate(angle);  
  
  if(angle <= 2*PI + PI/32){    
    fill(black);
    rect(0 - h/2, radius - w/2, h , w);
        
    rotate(-PI/40);
    fill(blue);
    ellipse(0, radius, h, w);
     
    rotate(2*PI/40);
    fill(yellow);
    ellipse(0, radius, h, w); 
    
    rotate(-PI/40);
    angle += PI/10;
    rotate(angle);
  }else{
    step += 1;
    angle = 0;
    if(radius >= 0)
      radius = 5*radius/6;
    if(step%2 != 0)
      angle += 2*PI/40;   
    if (step > 25){
      step = 0;
      radius = 100;
      angle = 0;

      if(x < 600)
        x+=200;
      else{
        x = 200;
        if(y < 600)
          y+=200;
      }        
    }
  }
}

void race(){
  step++;
  frameRate(8);
  background(white);          // black background
  
  //if(step%2==0){
  //  x += 1;
  //}else{
  //  y += 1;
  //}
  
  x+=2;
  y+=2;
  
  
   
  
  if(mousePressed == false){       
    for(int i = 0; i < 40; i=i+2){
      noStroke();
      fill(black);
      rect(i*width/40,0,20, 800);
      rect(i*width/40,0,20, 800);
    }
  }  
  fill(blue);
  rect(x,300,90,45); 
  
  fill(yellow);
  rect(y,500,90,45);
}

void pinkCircle(){
  frameRate(30);
  background(gray);
  step++;
  strokeWeight(4); 
  line(400,390,400,410);
  line(390,400,410,400);
  if (step == 120){
    step = 0;
  }
  noStroke();  
  int circle = 0;
  for (float angle = 0; angle < 2*PI; angle = angle + PI/6){
    if(circle != round(step/10)){
      drawGradient(300*cos(angle) + 400, 300*sin(angle) + 400); 
    }
    circle++;
  }
}
 
void drawGradient(float x, float y) {
  int radius = 100;
  float h = 0;
  color cCircle = white;
  for (int r = radius; r > 50; r = r - 2) {
    fill(cCircle);
    ellipse(x, y, r, r);   
    cCircle = lerpColor(gray, pink, h) ;
    h = h + 0.04;
  }
}