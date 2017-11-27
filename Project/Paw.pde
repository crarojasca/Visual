public class Paw {
  
  Scene scene;
  public InteractiveFrame iTarget;
  public InteractiveFrame [] iFrame;  
  public Vec position; 
  public Quat rotation;
  
  public Vec longPosition;
  public Rotation longRotation;
  
  public Vec midPosition;
  public Rotation midRotation;
  
  public Vec lowPosition;
  public Rotation lowRotation;
  

  public KeyFrameInterpolator kfi;
  
  public Vec framePosition;
  public Vec origin;
  
  public Solver solver;
  PShape upperLeg;
  PShape mediumLeg;
  PShape lowLeg;
  float angle;
  
  
  Paw(Scene scene, InteractiveFrame body, Vec position, Quat rotation, float angle){
    this.angle = angle;
    this.scene = scene;
    this.position = position;
    this.rotation = rotation;
    upperLeg = loadShape("images/upperLeg.obj");
    mediumLeg = loadShape("images/mediumLeg.obj");
    lowLeg = loadShape("images/downLeg.obj");
    
    iTarget = new InteractiveFrame(scene);
    
    iFrame = new InteractiveFrame[3];    
    for (int i = 0; i < 3; ++i) {
      iFrame[i] = new InteractiveFrame(scene, i>0 ? iFrame[i-1] : body);
    }      
    
    iFrame[0].setPosition(position);
    iFrame[0].setRotation(rotation);
    
    longPosition = iFrame[1].position();
    longRotation = iFrame[0].orientation();
    
    iFrame[1].setTranslation(13.543, 22.093, 22.87);
    iFrame[1].setRotation(new Quat(new Vec(0.0f, 0.0f, 1.0f), radians(20))); 
    midPosition = iFrame[1].position();
    midRotation = iFrame[1].orientation();
    
    iFrame[2].setTranslation(16.1, 11.243, -18.425);
    iFrame[2].setRotation(new Quat(new Vec(0.0f, 0.0f, 1.0f), radians(-22.528)));
    lowPosition = iFrame[2].position();
    lowRotation = iFrame[2].orientation();
    
    solver = scene.setIKStructure(iFrame[0]);
    scene.addIKTarget(iFrame[2], iTarget);
    solver.setTIMESPERFRAME(1);
    
    framePosition = iFrame[2].position();
    iTarget.setTranslation(framePosition);
  }
  
  public void init(){
    iFrame[0].setPosition(longPosition);
    iFrame[0].setOrientation(longRotation);
    
    iFrame[1].setPosition(midPosition);
    iFrame[1].setOrientation(midRotation); 
    
    iFrame[2].setPosition(lowPosition);
    iFrame[2].setOrientation(lowRotation);
    
    framePosition = iFrame[2].get().position();
  }
  
  public void draw(  ) {
    pushMatrix();     
    
      if (scene.motionAgent().isInputGrabber(iFrame[0]))
          scale(1.2); 

      pushMatrix(); 
        iFrame[0].applyWorldTransformation();
        shape(upperLeg);
      popMatrix();             
    
      pushMatrix();         
        iFrame[1].applyWorldTransformation(); 
        shape(mediumLeg);
      popMatrix();     
      
      pushMatrix();         
        iFrame[2].applyWorldTransformation(); 
        shape(lowLeg);
      popMatrix();  
            
      popMatrix();
  }
  
  public void breath(float change){  
    pushMatrix();
          iTarget.setTranslation(framePosition.x(),framePosition.y(),framePosition.z()-change);
    popMatrix();
  }  
  
  public void walk(){  
    pushMatrix();
          origin = iFrame[2].position();
          angle += 10;
          float A = 1;
          iTarget.setTranslation(origin.x(), origin.y()+A*cos(radians(angle)), origin.z()+A*sin(radians(angle)));
    popMatrix();
  }  

}