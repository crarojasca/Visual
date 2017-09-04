int illusions = 7;
int current = 1;
//toggle illusion activation
boolean active = true;
color black = color(0,0,0);
color white = color(255,255,255);

void setup() {
  size(800, 800);
}

void draw() {
  background(255);
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
  case 4:
  case 5:
  case 6:
  case 7:
    //println("implementation is missed!");
  }
  popStyle();
}

// switch illusion using the spacebar
void keyPressed() {
  if (key == ' ')
    current = current < illusions ? current+1 : 1;
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