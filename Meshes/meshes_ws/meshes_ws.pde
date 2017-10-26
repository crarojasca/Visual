Mesh mesh;
int RenderMode;
String tileRender;
VertexVertex vertexVertex;
FaceVertex faceVertex;
WingedEdge wingedEdge;

void setup() {
  size(600, 600, P3D);
  vertexVertex = new VertexVertex();
  faceVertex = new FaceVertex();
  wingedEdge = new WingedEdge();
  RenderMode = 1;
  tileRender = "VertexVertex";
}

void draw() {
  background(0);
  text("Mode: " + tileRender + ". Mesh mode: " + vertexVertex.mode + ". Rendering mode: " + (vertexVertex.retained ? "retained" : "immediate") + ". FPS: " + frameRate, 10 ,10);
  lights();
  // draw the mesh at the canvas center
  // while performing a little animation
  
  translate(width/2, height/2 + 150, 0);
  rotateX(radians(180));
  //rotateX(frameCount*radians(90) / 50);
  rotateY(frameCount*radians(90) / 50);
  scale(0.4);
  // mesh draw method
  switch(RenderMode) {
    case 1:
      tileRender = "VertexVertex";
      vertexVertex.draw();
      break;
    case 2:
      tileRender = "FaseVertex";
      faceVertex.draw();
      break;
    case 3:
      tileRender = "WingedVertex";
      wingedEdge.draw();
      break;
  }
  
}

void keyPressed() {
  if (key == ' '){
    vertexVertex.mode = vertexVertex.mode < 3 ? vertexVertex.mode+1 : 1;
    faceVertex.mode = faceVertex.mode < 3 ? faceVertex.mode+1 : 1;
    wingedEdge.mode = wingedEdge.mode < 3 ? wingedEdge.mode+1 : 1;
  }
  if (key == 'm'){
    RenderMode = RenderMode < 3 ? RenderMode+1 : 1;
  }
  if (key == 'r'){
    vertexVertex.retained = !vertexVertex.retained;
    faceVertex.retained = !faceVertex.retained;
    wingedEdge.retained = !wingedEdge.retained;
  }
  if (key == 'b')
    vertexVertex.boundingSphere = !vertexVertex.boundingSphere;
}