public class Spider {
  public Scene scene;
  private InteractiveFrame iBodyFrame;
  private Paw [] paws;
  private PShape bodyShape;
  private Integer frame;
  
  Spider(Scene scn) {
    scene = scn;
    iBodyFrame = new InteractiveFrame(scn);    
    bodyShape = loadShape("images/body.obj");
    this.init();
  }

  public void draw( ) {
    pushMatrix();
      if (scene.motionAgent().isInputGrabber(iBodyFrame))
            scale(1.2);  
            
      pushMatrix();
        iBodyFrame.applyWorldTransformation();        
        shape(bodyShape);
      popMatrix(); 
      
      for(Paw paw : paws){
        paw.draw();
      }
    popMatrix();
  } 
  
  public void init(){
    frame = 0;
    iBodyFrame.setPosition(0,0,18); 
    paws = new Paw[8];
    paws[0] = new Paw(scene, iBodyFrame, new Vec( 3.27,  3.983, 18), new Quat(new Vec(0.0f, 0.0f, 0.0f), radians( 0  )), radians( 270 ));
    paws[1] = new Paw(scene, iBodyFrame, new Vec(-3.27,  3.983, 18), new Quat(new Vec(0.0f, 0.0f, 1.0f), radians( 66 )), radians( 270 ));
    paws[2] = new Paw(scene, iBodyFrame, new Vec( 4.05, -0.103, 18), new Quat(new Vec(0.0f, 0.0f, 1.0f), radians(-36 )), radians( 180 ));
    paws[3] = new Paw(scene, iBodyFrame, new Vec(-4.05, -0.103, 18), new Quat(new Vec(0.0f, 0.0f, 1.0f), radians( 102)), radians( 180 ));
    paws[4] = new Paw(scene, iBodyFrame, new Vec( 3.40, -1.747, 18), new Quat(new Vec(0.0f, 0.0f, 1.0f), radians(-66 )), radians( 90 ));
    paws[5] = new Paw(scene, iBodyFrame, new Vec(-3.40, -1.747, 18), new Quat(new Vec(0.0f, 0.0f, 1.0f), radians( 138)), radians( 90 ));
    paws[6] = new Paw(scene, iBodyFrame, new Vec( 3.26, -4.101, 18), new Quat(new Vec(0.0f, 0.0f, 1.0f), radians(-102)), radians( 0 ));
    paws[7] = new Paw(scene, iBodyFrame, new Vec(-3.26, -4.101, 18), new Quat(new Vec(0.0f, 0.0f, 1.0f), radians( 174)), radians( 0 ));
  }
  
  public void animate(Boolean walk){
    frame++;
    if(walk)
      walk();
    else
      breath();
  }
  
  public void breath(){
    pushMatrix();
      Integer amplitude = 1;
      float change = amplitude*sin(radians(10*frame));
      iBodyFrame.setTranslation(0,0,18+change);
      for(Paw paw : paws){
        paw.breath(change);
      }
    popMatrix();   
  }
  
  public void walk() {
    pushMatrix();
      iBodyFrame.setTranslation(0,-frame,18);
      for(Paw paw : paws){
        paw.walk();
      }  
    popMatrix();    
  }
}