import controlP5.*;
import java.util.Collection;
import java.util.Map;
import java.util.List;

ControlP5 cp5;
int n = 1;
int len = 100;
float factor = 1;
float alpha = 0;
String init;
boolean recursiveFlag = false;
int x = 800;
int y = 600;
float angle = 0;
Map<String, String> rules;


void setup() {
  size(1200,700); 
  PFont font = createFont("TrajanProRegular.ttf",14);
  cp5 = new ControlP5(this);
  cp5.begin(cp5.addBackground("abc"));
  
  Group parameters = cp5.addGroup("Parameters")
                .setPosition(10,100)
                .setWidth(280)
                .setBackgroundHeight(170)
                .setBackgroundColor(color(255,50))
                ;
  
  cp5.addTextfield("n")
     .setFont(font)
     .setPosition(20,20)
     .setSize(100,20)
     .setGroup(parameters)
     .setFocus(true)
     ;
     
  cp5.addTextfield("alpha")
     .setFont(font)
     .setPosition(170,20)
     .setGroup(parameters)
     .setSize(100,20)
     ; 
     
  cp5.addTextfield("len")
     .setFont(font)
     .setPosition(20,70)
     .setGroup(parameters)
     .setSize(100,20)
     ;
  
  cp5.addTextfield("x")
     .setFont(font)
     .setPosition(20,120)
     .setGroup(parameters)
     .setSize(100,20)
     ;
     
  cp5.addTextfield("y")
     .setFont(font)
     .setPosition(170,120)
     .setGroup(parameters)
     .setSize(100,20)
     ;
     
  Group rparameters = cp5.addGroup("Recursive Parameters")
                .setPosition(10,300)
                .setWidth(280)
                .setBackgroundHeight(80)
                .setBackgroundColor(color(255,50))
                ;
                
  cp5.addToggle("recursive")
     .setPosition(20,20)
     .setSize(100,20)
     .setGroup(rparameters)
     .setMode(ControlP5.SWITCH)
     .setFont(font)
     .setValue(false)
     ;
  
  
  cp5.addTextfield("factor")
     .setFont(font)
     .setPosition(170,20)
     .setGroup(rparameters)
     .setSize(100,20)
     ;
     
  Group rules = cp5.addGroup("Rules")
                .setPosition(10,410)
                .setWidth(280)
                .setBackgroundHeight(230)
                .setBackgroundColor(color(255,50))
                ;
     
     
  cp5.addTextfield("init")
     .setFont(font)
     .setPosition(20,20)
     .setSize(50,20)
     .setGroup(rules)
     ;  
     
  cp5.addTextfield("s1")
     .setFont(font)
     .setPosition(20,70)
     .setSize(50,20)
     .setGroup(rules)
     ;  
     
  cp5.addTextfield("r1")
     .setFont(font)
     .setPosition(90,70)
     .setSize(180,20)
     .setGroup(rules)
     ; 

  cp5.addTextfield("s2")
     .setFont(font)
     .setPosition(20,120)
     .setSize(50,20)
     .setGroup(rules)
     ;  
     
  cp5.addTextfield("r2")
     .setFont(font)
     .setPosition(90,120)
     .setSize(180,20)
     .setGroup(rules)
     ; 
  
  cp5.addTextfield("s3")
     .setFont(font)
     .setPosition(20,170)
     .setSize(50,20)
     .setGroup(rules)
     ;  
     
  cp5.addTextfield("r3")
     .setFont(font)
     .setPosition(90,170)
     .setSize(180,20)
     .setGroup(rules)
     ; 


}

void draw() {
    n = 1;
    x = 800;
    y = 400;
    alpha = 0;
    len = 100;
  
    
    background(255);
    
    try{
      getParams();    
    }catch(Exception e){
    } 
    
    int end = n;
    if(recursiveFlag == true){
      n = 1; 
    }
   
    while(n <= end){
      List<String> chain = process();    
      //System.out.println("Cadena Final" + chain.toString());    
      pushMatrix();
      translate(x,y);
      rotate(angle);
      for(String command:chain){
        if(command != null)
          turtleImprint(command);
      }
      popMatrix(); 
      len *= 0.5;
      n++;
    }
  
}

void getParams() {
  try{
    n = Integer.parseInt(cp5.get(Textfield.class,"n").getText());
  }catch(Exception e){
  } 
  try{
    alpha = Float.parseFloat(cp5.get(Textfield.class,"alpha").getText())*PI/180;
  }catch(Exception e){
  }   
  init = cp5.get(Textfield.class,"init").getText();  
  try{
    len = Integer.parseInt(cp5.get(Textfield.class,"len").getText());
  }catch(Exception e){
  }     
  try{
    factor = Float.parseFloat(cp5.get(Textfield.class,"factor").getText());
  }catch(Exception e){
  }   
  try{
    x = Integer.parseInt(cp5.get(Textfield.class,"x").getText());
  }catch(Exception e){
  } 
  try{
    y = Integer.parseInt(cp5.get(Textfield.class,"y").getText());
  }catch(Exception e){
  } 
  
  rules = new HashMap<String, String>();
  if (cp5.get(Textfield.class,"s1").getText() != null){
    rules.put(cp5.get(Textfield.class,"s1").getText(),cp5.get(Textfield.class,"r1").getText());
  }
  if (cp5.get(Textfield.class,"s2").getText() != null){
    rules.put(cp5.get(Textfield.class,"s2").getText(),cp5.get(Textfield.class,"r2").getText());
  }
  if (cp5.get(Textfield.class,"s3").getText() != null){
    rules.put(cp5.get(Textfield.class,"s3").getText(),cp5.get(Textfield.class,"r3").getText());
  }
}



public List<String> process() {   
  
  List<String> chain = new ArrayList();
  chain.add(init);
  for(int i = 0; i < n; i++){  
    boolean undone = true;
    int index = 0;
    String element;
    while(undone){
      element = chain.get(index);
      if(element != null && rules.get(element)!=null){
        String subchain = rules.get(element);
        chain.remove(index);
        for(int j = 0; j < subchain.length(); j++ ){
          chain.add(index, Character.toString(subchain.charAt(j)));
          index++;
        }        
      }else{
        index++;
      }
      if(index >= chain.size()){
        undone = false;
      }
    } 
  }
  return chain;
}

void turtleImprint(String command){
  switch(command) {
   case "f" :
      line(0, 0, 0, -len);
      translate(0, -len);
      break; 
   case "+" :
      rotate(alpha);
      break; 
   case "-" :
      rotate(-alpha);
      break;
   case "[" :
      pushMatrix();
      break;
   case "]" :
      popMatrix();
      break;
   default : 
      break;
  }
}

void recursive(boolean theFlag) {
  if(theFlag==true) {
    recursiveFlag = true;
  } else {
    recursiveFlag = false;
  }
}