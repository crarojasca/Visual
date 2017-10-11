class Mesh {
  // radius refers to the mesh 'bounding sphere' redius.
  // see: https://en.wikipedia.org/wiki/Bounding_sphere
  float radius = 200;
  PShape shape;
  PShape VVshape;
  PShape VFshape;
  PShape EWshape;
  ArrayList<PVector> vertices;
  ArrayList<PVector> vertex;
  ArrayList<ArrayList<Integer>> faces;
  ArrayList<ArrayList<Integer>> edges;
  ArrayList<ArrayList<Integer>> vertexVertex;
  int kind = TRIANGLES;
  
  // rendering
  boolean retained;

  // visual modes
  // 0. Faces and edges
  // 1. Wireframe (only edges)
  // 2. Only faces
  // 3. Only points
  int mode;

  // visual hints
  boolean boundingSphere;

  Mesh() {
    build();
    //use processing style instead of pshape's, see https://processing.org/reference/PShape.html
    shape.disableStyle();
    VFshape.disableStyle();
    VVshape.disableStyle();
    EWshape.disableStyle();
  }

  // compute both mesh vertices and pshape
  // TODO: implement me
  void build() {
    shape = loadShape("wolf.obj");
    vertex = new ArrayList<PVector>();
    faces = new ArrayList<ArrayList<Integer>>();
    edges = new ArrayList<ArrayList<Integer>>();
    vertexVertex = new ArrayList<ArrayList<Integer>>();

    for(int i=0; i<shape.getChildCount(); i++){
      PShape child = shape.getChild(i);
      ArrayList<Integer> face = new ArrayList<Integer>();      
      for(int j=0; j<child.getVertexCount();j++){
        PVector vert = child.getVertex(j);
        if(!vertex.contains(vert)){
          vertex.add(vert);
          face.add(vertex.size()-1);          
        }else{
          face.add(vertex.indexOf(vert));
        }        
      }    
      faces.add(face);
      
      for(int j=0; j<face.size(); j++){
        int k = j == face.size() - 1 ? 0 : j + 1; 
        ArrayList<Integer> edge = new ArrayList<Integer>(); 
        edge.add(face.get(j));
        edge.add(face.get(k));
        if(!edge.contains(edge)){
          edges.add(edge);
        } 
        addVertexVertex(j, k, face);
        addVertexVertex(k, j, face);
      }       
    } 

    vertices = new ArrayList<PVector>();
    for(int i = 0; i<vertexVertex.size(); i++){
      for(Integer vert : vertexVertex.get(i)){
        vertices.add(vertex.get(i));
        vertices.add(vertex.get(vert));
      }
    }
    
    VVshape = createShape();
    VVshape.beginShape(LINES);
    for(PVector v : vertices)
      VVshape.vertex(v.x, v.y ,v.z);
    VVshape.endShape();
    
    vertices = new ArrayList<PVector>();
    for(ArrayList<Integer> edge : edges){
      for(Integer vert : edge){
        vertices.add(vertex.get(vert));
      }
    }
    
    EWshape = createShape();
    EWshape.beginShape(LINES);
    for(PVector v : vertices)
      EWshape.vertex(v.x, v.y ,v.z);
    EWshape.endShape();   
    
    vertices = new ArrayList<PVector>();
    for(ArrayList<Integer> face : faces){
      for(Integer vert : face){
        vertices.add(vertex.get(vert));
      }
    }
    
    VFshape = createShape();
    VFshape.beginShape(TRIANGLES);
    for(PVector v : vertices)
      VFshape.vertex(v.x, v.y ,v.z);
    VFshape.endShape();
    
  }
  // transfer geometry every frame
  // TODO: current implementation targets a quad.
  // Adapt me, as necessary
  void drawImmediate() {
    beginShape(kind);
    for(PVector v : vertices)
      vertex(v.x, v.y ,v.z);
    endShape();
  }

  void draw() {
    pushStyle();
    
    // mesh visual attributes
    // manipuate me as you wish
    int strokeWeight = 3;
    color lineColor = color(255, retained ? 0 : 255, 0);
    color faceColor = color(0, retained ? 0 : 255, 255, 100);
    
    strokeWeight(strokeWeight);
    stroke(lineColor);
    fill(faceColor);    
    // visual modes
    switch(mode) {
    case 1:
      noFill();
      kind = TRIANGLES;
      break;
    case 2:
      noStroke();
      kind = TRIANGLES;
      break;
    case 3:
      kind = POINTS;
      break;
    }
    
    pushMatrix();
      translate(0,800,400);
      scale(0.5);
      shape(VVshape);
    popMatrix();
    
    pushMatrix();
      translate(0,800,-400);
      scale(0.5);
      shape(EWshape);
    popMatrix();

    // rendering modes
    if (retained){ 
      shape(VFshape);
      
    }else
      drawImmediate();
    popStyle();

    // visual hint
    if (boundingSphere) {
      pushStyle();
      noStroke();
      fill(0, 255, 255, 125);
      sphere(radius);
      popStyle();
    }
  }
  
  void addVertexVertex(int v1, int v2, ArrayList<Integer> face){
    if(vertexVertex.size() <= face.get(v1)){
      ArrayList<Integer> vertexList = new ArrayList<Integer>();
      vertexList.add(face.get(v2));
      vertexVertex.add(face.get(v1), vertexList);
    }else{
      if(!vertexVertex.get(face.get(v1)).contains(face.get(v2))){
        vertexVertex.get(face.get(v1)).add(face.get(v2));
      }          
    }
  }
  
}