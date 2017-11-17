public class Paw {
  
  Scene scene;
  public InteractiveFrame iTarget;
  public InteractiveFrame [] iFrame;  
  public Vec position; 
  public Quat rotation;
  PShape upperLeg;
  PShape mediumLeg;
  PShape lowLeg;
  
  Paw(Scene scene, InteractiveFrame body, Vec position, Quat rotation){
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
    
    iFrame[0].setTranslation(position);
    iFrame[0].setRotation(rotation);
    
    iFrame[1].setTranslation(13.543, 22.093, 22.87);
    iFrame[1].setRotation(new Quat(new Vec(0.0f, 0.0f, 1.0f), radians(20))); 
    
    iFrame[2].setTranslation(16.1, 11.243, -18.425);
    iFrame[2].setRotation(new Quat(new Vec(0.0f, 0.0f, 1.0f), radians(-22.528)));
  
    Solver solver = scene.setIKStructure(iFrame[0]);
    scene.addIKTarget(iFrame[2], iTarget);
    solver.setTIMESPERFRAME(1);
    iTarget.setTranslation(iFrame[2].get().position());
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
  
}