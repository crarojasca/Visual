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
    
    longPosition = iFrame[1].get().position();
    longRotation = iFrame[0].get().orientation();
    
    iFrame[1].setTranslation(13.543, 22.093, 22.87);
    iFrame[1].setRotation(new Quat(new Vec(0.0f, 0.0f, 1.0f), radians(20))); 
    midPosition = iFrame[1].get().position();
    midRotation = iFrame[1].get().orientation();
    
    iFrame[2].setTranslation(16.1, 11.243, -18.425);
    iFrame[2].setRotation(new Quat(new Vec(0.0f, 0.0f, 1.0f), radians(-22.528)));
    lowPosition = iFrame[2].get().position();
    lowRotation = iFrame[2].get().orientation();
    
    solver = scene.setIKStructure(iFrame[0]);
    scene.addIKTarget(iFrame[2], iTarget);
    solver.setTIMESPERFRAME(1);
    
    framePosition = iFrame[2].get().position();
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
      
      /*pushMatrix();
        //circle.applyWorldTransformation(); 
        for(angle = 0; angle <= 360; angle+= 40){
          pushMatrix();
          float A = 5;
          translate(framePosition.x(), framePosition.y()+A*cos(radians(angle)), framePosition.z()+A*sin(radians(angle)));
          fill(255,0,0);
          sphere(1);
          popMatrix();
        }
      popMatrix();*/
      
      popMatrix();
  }
  
  public void animate(){  
    pushMatrix();
          framePosition = iFrame[2].get().position();
          angle += 10;
          float A = 5;
          iTarget.setTranslation(framePosition.x(), framePosition.y()+A*cos(radians(angle)), framePosition.z()+A*sin(radians(angle)));
    popMatrix();

    if(angle > 3*360){
      angle = 0;
      //this.init();
    }
  }  
}