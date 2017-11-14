
  
PShape spider;

void setup() {
  size(1000, 800);
  // The file "bot.svg" must be in the data folder
  // of the current sketch to load successfully
  spider = loadShape("CELSPDER.OBJ");
  
}

void draw() {
  //shape(spider, 10, 10, 80, 80);
}