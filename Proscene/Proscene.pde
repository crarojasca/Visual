import remixlab.proscene.*;
import remixlab.dandelion.core.*;
import remixlab.dandelion.geom.*;
import remixlab.dandelion.constraint.*;
import remixlab.dandelion.ik.Solver;

Scene scene;
Spider spider;

void setup() {
  size(1000, 800, P3D);
  scene = new Scene(this);  
  scene.setRadius(90);
  scene.setPickingVisualHint(false);
  scene.setAxesVisualHint(false);
  scene.setDottedGrid(false);
  scene.showAll();
  scene.setGridVisualHint(false);
  spider = new Spider(scene);
}

void draw() {
  background(0);
  lights(); 
  spider.draw();  
}