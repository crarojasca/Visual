public class Spider {
  Scene scene;
  public InteractiveFrame iBodyFrame;
  Paw [] paws;
  PShape bodyShape;

  Spider(Scene scn) {
    scene = scn;
    iBodyFrame = new InteractiveFrame(scn);
    bodyShape = loadShape("images/body.obj");
    paws = new Paw[8];
    paws[0] = new Paw(scene, iBodyFrame, new Vec( 3.27,  3.983, 0), new Quat(new Vec(0.0f, 0.0f, 0.0f), radians( 0 )));
    paws[1] = new Paw(scene, iBodyFrame, new Vec(-3.27,  3.983, 0), new Quat(new Vec(0.0f, 0.0f, 1.0f), radians( 66)));
    paws[2] = new Paw(scene, iBodyFrame, new Vec( 4.05, -0.103, 0), new Quat(new Vec(0.0f, 0.0f, 1.0f), radians(-36)));
    paws[3] = new Paw(scene, iBodyFrame, new Vec(-4.05, -0.103, 0), new Quat(new Vec(0.0f, 0.0f, 1.0f), radians( 102)));
    paws[4] = new Paw(scene, iBodyFrame, new Vec( 3.40, -1.747, 0), new Quat(new Vec(0.0f, 0.0f, 1.0f), radians(-66)));
    paws[5] = new Paw(scene, iBodyFrame, new Vec(-3.40, -1.747, 0), new Quat(new Vec(0.0f, 0.0f, 1.0f), radians(138)));
    paws[6] = new Paw(scene, iBodyFrame, new Vec( 3.26, -4.101, 0), new Quat(new Vec(0.0f, 0.0f, 1.0f), radians(-102)));
    paws[7] = new Paw(scene, iBodyFrame, new Vec(-3.26, -4.101, 0), new Quat(new Vec(0.0f, 0.0f, 1.0f), radians(174)));
  }

  public void draw( ) {
    pushMatrix();
      pushMatrix();
        iBodyFrame.applyWorldTransformation();        
        if (scene.motionAgent().isInputGrabber(iBodyFrame))
          fill(255, 0, 0);
        shape(bodyShape);
      popMatrix();   
      for(Paw paw : paws){
        paw.draw();
      }
    popMatrix();
  }
}