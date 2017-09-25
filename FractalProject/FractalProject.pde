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
Map<String, String> rules;


void setup() {
  size(1200,700);
  noStroke();
  PFont font = createFont("TrajanProRegular.ttf",14);
  cp5 = new ControlP5(this);
  
  cp5.begin(cp5.addBackground("abc"));
  
  cp5.addTextfield("n")
     .setFont(font)
     .setPosition(20,100)
     .setSize(100,20)
     .setFocus(true)
     ;
     
  cp5.addTextfield("alpha")
     .setFont(font)
     .setPosition(20,150)
     .setSize(100,20)
     ;   
     
  cp5.addTextfield("len")
     .setFont(font)
     .setPosition(20,200)
     .setSize(100,20)
     ;  
     
  cp5.addTextfield("factor")
     .setFont(font)
     .setPosition(170,200)
     .setSize(100,20)
     ;  
     
  cp5.addTextfield("init")
     .setFont(font)
     .setPosition(20,350)
     .setSize(50,20)
     ;  
     
  cp5.addTextfield("s1")
     .setFont(font)
     .setPosition(20,400)
     .setSize(50,20)
     ;  
     
  cp5.addTextfield("r1")
     .setFont(font)
     .setPosition(90,400)
     .setSize(180,20)
     ; 

  cp5.addTextfield("s2")
     .setFont(font)
     .setPosition(20,450)
     .setSize(50,20)
     ;  
     
  cp5.addTextfield("r2")
     .setFont(font)
     .setPosition(90,450)
     .setSize(180,20)
     ; 
  
  cp5.addTextfield("s3")
     .setFont(font)
     .setPosition(20,500)
     .setSize(50,20)
     ;  
     
  cp5.addTextfield("r3")
     .setFont(font)
     .setPosition(90,500)
     .setSize(180,20)
     ; 

  cp5.end();
}

void draw() {
  try{
    background(255);
    List<String> chain = process();
    System.out.println("Cadena Final" + chain.toString());    
    pushMatrix();
    translate(800,600);
    for(String command:chain){
      turtleImprint(command);
    }
    popMatrix();   
  }catch(Exception e){
    System.out.println(e);
  }    
  
}

public List<String> process() {
  
  n = Integer.parseInt(cp5.get(Textfield.class,"n").getText());
  alpha = Float.parseFloat(cp5.get(Textfield.class,"alpha").getText())*PI/180;
  init = cp5.get(Textfield.class,"init").getText();
  


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
  System.out.println(rules.toString());
  List<String> chain = new ArrayList();
  chain.add(init);
  System.out.println(chain.toString());
  for(int i = 0; i < n; i++){  
    boolean undone = true;
    int index = 0;
    String element;
    while(undone){
      element = chain.get(index);
      if(rules.get(element)!=null){
        String subchain = rules.get(element);
        chain.remove(index);
        System.out.println(index + " " +  chain.toString());
        for(int j = 0; j < subchain.length(); j++ ){
          chain.add(index, Character.toString(subchain.charAt(j)));
          System.out.println(index + " " +  chain.toString());
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
      line(0, 0, len*cos(alpha), -len*sin(alpha));
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
      pushMatrix();
      break;
   default : 
      break;
}
}