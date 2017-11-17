
import remixlab.proscene.*;
import remixlab.dandelion.core.*;
import remixlab.dandelion.geom.*;
import remixlab.dandelion.constraint.*;

Scene scene;

ArrayList<PVector> vertex;
PShape model;
PShape spider;
public InteractiveFrame frame;
PShader pixelator;
PImage tex;
void setup() {
  size(1000, 800, P3D);
  scene = new Scene(this);  
  scene.setRadius(90);
  scene.setPickingVisualHint(false);
  scene.setAxesVisualHint(false);
  scene.setDottedGrid(false);
  scene.showAll();
  scene.setGridVisualHint(false);
  frame = new InteractiveFrame(scene);
  pixelator = loadShader("pixel.glsl");
  tex = loadImage("spider.jpg");
  model = loadShape("Spider.obj");
  vertex = new ArrayList<PVector>();
  
  for(int i=0; i<model.getChildCount(); i++){
    PShape child = model.getChild(i);
    for(int j=0; j<child.getVertexCount(); j++){
      vertex.add(child.getVertex(j));
    }
  } 
  
  spider = createShape();
  spider.beginShape(TRIANGLES);
  spider.texture(tex);
  for(PVector v : vertex)
    spider.vertex(v.x, v.y ,v.z);    
  spider.endShape();
  
}

void draw() {
  background(255);
  lights(); 
  pushMatrix();
      frame.applyWorldTransformation(); 
      //shader(pixelator);
      shape(spider);
  popMatrix();
}