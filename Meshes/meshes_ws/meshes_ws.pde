Mesh mesh;
VertexVertex vertexVertex;

void setup() {
  size(600, 600, P3D);
  vertexVertex = new VertexVertex();
}

void draw() {
  background(0);
  text("Mesh mode: " + vertexVertex.mode + ". Rendering mode: " + (vertexVertex.retained ? "retained" : "immediate") + ". FPS: " + frameRate, 10 ,10);
  lights();
  // draw the mesh at the canvas center
  // while performing a little animation
  
  translate(width/2, height/2 + 150, 0);
  rotateX(radians(180));
  //rotateX(frameCount*radians(90) / 50);
  rotateY(frameCount*radians(90) / 50);
  scale(0.4);
  // mesh draw method
  vertexVertex.draw();
}

void keyPressed() {
  if (key == ' '){
    vertexVertex.mode = vertexVertex.mode < 3 ? vertexVertex.mode+1 : 1;
    vertexVertex.change = 0;
    vertexVertex.refreshShape();
  }
  if (key == 'r')
    vertexVertex.retained = !vertexVertex.retained;
  if (key == 'b')
    vertexVertex.boundingSphere = !vertexVertex.boundingSphere;
}