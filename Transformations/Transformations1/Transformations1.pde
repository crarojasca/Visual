
color lineColor = color(255, 255, 0);
color faceColor = color(0, 255, 255, 100);
VertexVertex vertexVertex;
int x;
int y;
int z;
float xAngle;
float yAngle;
float zAngle;
float xShair;
float yShair;
float zShair;
float scale;
int xPoint;
int yPoint;
int zPoint;

void setup() {
  size(600, 600, P3D);
  vertexVertex = new VertexVertex();
  x = 0;
  y = 0;
  z = 0;
  xAngle = 0;
  yAngle = 0;
  zAngle = 0;
  xShair = 0;
  yShair = 0;
  zShair = 0;
  scale = 1;
  xPoint = 0;
  yPoint = 0;
  zPoint = 0;
}

void draw() {
  background(255);
  
  pushMatrix();
  fill(0);
  scale(2);
  text("X: " + x, 10 ,10);
  text("Y: " + y, 10 ,20);
  text("Z: " + z, 10 ,30);
  text("xAngle: " + xAngle, 50 , 10);
  text("yAngle: " + yAngle, 50 , 20);
  text("zAngle: " + zAngle, 50 , 30);
  text("Scale: " + scale, 140 , 10);
  text("xShair: " + xShair, 210 , 10);
  text("yShair: " + yShair, 210 , 20);
  popMatrix();
  
  translate(width/2, height/2 + 150, 0);
  rotateX(radians(180 + xAngle));
  rotateY(radians(yAngle));
  rotateZ(radians(zAngle));
  scale(0.4);
  
  pushMatrix();
  translate(xPoint, yPoint, zPoint);
  stroke(lineColor);
  fill(faceColor);
  lights();
  sphere(28);
  pushMatrix();
    translate(x, y, z);
    scale(scale);
    shearX(radians(xShair));
    shearY(radians(yShair));
    vertexVertex.draw(); 
  popMatrix();
  popMatrix();
  
 
  
}

void keyPressed() {
  switch(key) {
    case 'd':
      x+=100;
      break;
    case 'a':
      x-=100;
      break;
    case 'r':
      y+=100;
      break;
    case 'f':
      y-=100;
      break;
    case 'w':
      z+=100;
      break;
    case 's':
      z-=100;
      break;
    case 't':
      xAngle+=10;
      break;
    case 'g':
      xAngle-=10;
      break;
    case 'y':
      yAngle+=10;
      break;
    case 'h':
      yAngle-=10;
      break;
    case 'u':
      zAngle+=10;
      break;
    case 'j':
      zAngle-=10;
      break;
    case 'i':
      scale+=0.1;
      break;
    case 'k':
      scale-=0.1;
      break;
    case 'z':
      xShair+=10;
      break;
    case 'x':
      xShair-=10;
      break;
    case 'c':
      yShair+=10;
      break;
    case 'v':
      yShair-=10;
      break;
    case '8':
      yPoint+=10;
      break;
    case '2':
      yPoint-=10;
      break;
    case '6':
      xPoint+=10;
      break;
    case '4':
      xPoint-=10;
      break;
    }
    
}