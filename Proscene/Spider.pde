public class Spider {
  Scene scene;
  public InteractiveFrame iBodyFrame;
  Paw [] paws;
  PShape bodyShape;

  Spider(Scene scn) {
    scene = scn;
    iBodyFrame = new InteractiveFrame(scn);
    bodyShape = loadShape("images/body.obj");
    paws = new Paw[7];
    paws[0] = new Paw(scene, iBodyFrame, new Vec(3.277, 3.983, 0), new Quat(new Vec(0.0f, 0.0f, .0f), radians(0)));
    paws[1] = new Paw(scene, iBodyFrame, new Vec(-3.27, 3.983, 0), new Quat(new Vec(0.0f, 0.0f, 1.0f), radians(66.076)));
  }

  public void draw( ) {
    pushMatrix();
      pushMatrix();
        iBodyFrame.applyWorldTransformation();
        shape(bodyShape);
      popMatrix();      
      paws[0].draw();
      paws[1].draw();
    popMatrix();
  }
}