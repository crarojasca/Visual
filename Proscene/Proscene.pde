import remixlab.proscene.*;
import remixlab.dandelion.core.*;
import remixlab.dandelion.geom.*;
import remixlab.dandelion.constraint.*;

Scene scene;
Spider spider;

Boolean visualHint = false;

void setup() {
  size(1000, 800, P3D);
  scene = new Scene(this);  
  scene.setRadius(90);
  scene.setPickingVisualHint(visualHint);
  scene.setAxesVisualHint(false);
  scene.setDottedGrid(false);
  scene.showAll();
  scene.setGridVisualHint(false);
  spider = new Spider(scene);
}

void draw() {
  background(255);
  lights(); 
  spider.draw();  
}

void keyPressed(){
  if(key == ' ')
    spider.walk = !spider.walk;
  if(key == 'p'){
    visualHint = !visualHint;
    scene.setPickingVisualHint(visualHint);
  }
}