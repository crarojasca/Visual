public class Paw {
  
  Scene scene;
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
    
    iFrame = new InteractiveFrame[4];    
    for (int i = 0; i < 4; ++i) {
      iFrame[i] = new InteractiveFrame(scene, i>0 ? iFrame[i-1] : body);
    }    
  }
  
  public void draw( ) {
    pushMatrix();     
      iFrame[0].setTranslation(position);
      iFrame[0].setRotation(rotation);
      pushMatrix();
        pushMatrix(); 
          iFrame[0].applyWorldTransformation();    
          shape(upperLeg);
        popMatrix();
        
        pushMatrix(); 
          iFrame[1].setTranslation(13.543, 22.093, 22.87);
          iFrame[1].setRotation(new Quat(new Vec(0.0f, 0.0f, 1.0f), radians(20)));
          pushMatrix(); 
            
            pushMatrix(); 
              iFrame[1].applyWorldTransformation(); 
              shape(mediumLeg);
            popMatrix();
            
            pushMatrix(); 
              iFrame[2].setTranslation(16.1, 11.243, -18.425);
              iFrame[2].setRotation(new Quat(new Vec(0.0f, 0.0f, 1.0f), radians(-22.528)));
              pushMatrix(); 
                
                pushMatrix(); 
                  iFrame[2].applyWorldTransformation(); 
                  shape(lowLeg);
                popMatrix();
              popMatrix();
            popMatrix();
          popMatrix();
        popMatrix();
      popMatrix();

    popMatrix();
  }
  
}