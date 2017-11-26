import remixlab.proscene.*;
import remixlab.dandelion.core.*;
import remixlab.dandelion.geom.*;
import remixlab.dandelion.constraint.*;
import remixlab.dandelion.ik.Solver;

MyScene scene;
Spider spider;

void setup() {
  size(1000, 800, P3D);
    scene = new MyScene(this);
    scene.setRadius(90);
    scene.setPickingVisualHint(false);
    scene.setAxesVisualHint(false);
    scene.setDottedGrid(false);
    scene.showAll();
    scene.setGridVisualHint(false);
    spider = new Spider(scene);
}

void draw() {
  background(255);    
}

class MyScene extends Scene {
  

  // We need to call super(p) to instantiate the base class
  public MyScene(PApplet p) {
    super(p);
    lights(); 
  }
  
  public void init() {
    startAnimation();
  }
  
  // Define here what is actually going to be drawn.
  public void proscenium() {
    spider.draw();
  }
  
  public void animate() {
    spider.animate();
  }
}