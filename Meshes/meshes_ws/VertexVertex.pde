class VertexVertex {
  // radius refers to the mesh 'bounding sphere' redius.
  // see: https://en.wikipedia.org/wiki/Bounding_sphere
  float radius = 200;
  PShape shape;
  PShape pshape;
  ArrayList<PVector> vertices;
  ArrayList<PVector> vertex;
  ArrayList<ArrayList<Integer>> faces;
  ArrayList<ArrayList<Integer>> edges;
  ArrayList<ArrayList<Integer>> vertexVertex;
  ArrayList<ArrayList<Integer>> vertexFace;
  int kind = LINES;
  
  // rendering
  boolean retained;
  int change;

  // visual modes
  // 0. Faces and edges
  // 1. Wireframe (only edges)
  // 2. Only faces
  // 3. Only points
  int mode;

  // visual hints
  boolean boundingSphere;

  VertexVertex() {
    build();
    //use processing style instead of pshape's, see https://processing.org/reference/PShape.html
    shape.disableStyle();
    pshape.disableStyle();
  }

  // compute both mesh vertices and pshape
  // TODO: implement me
  void build() {
    change = 0;
    mode = 1;
    shape = loadShape("wolf.obj");
    vertex = new ArrayList<PVector>();
    faces = new ArrayList<ArrayList<Integer>>();
    edges = new ArrayList<ArrayList<Integer>>();
    vertexVertex = new ArrayList<ArrayList<Integer>>();
    vertexFace = new ArrayList<ArrayList<Integer>>();

    for(int i=0; i<shape.getChildCount(); i++){
      PShape child = shape.getChild(i);
      ArrayList<Integer> face = new ArrayList<Integer>();      
      for(int j=0; j<child.getVertexCount();j++){
        PVector vert = child.getVertex(j);
        if(!vertex.contains(vert)){
          vertex.add(vert); 
          
          ArrayList<Integer> listVertexFaces = new ArrayList<Integer>();
          listVertexFaces.add(faces.size());
          vertexFace.add(listVertexFaces);
          
          face.add(vertex.size()-1);  
        }else{
          int index = vertex.indexOf(vert);
          vertexFace.get(index).add(faces.size());
          face.add(index);
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
    for(int i = 0; i<vertex.size(); i++){
      for(Integer face : vertexFace.get(i)){ 
        for(Integer vert : faces.get(face)){
          vertices.add(vertex.get(vert));
        }
      }
      
    }
    
    shape = createShape();
    shape.beginShape(TRIANGLES);
    for(PVector v : vertices)
      shape.vertex(v.x, v.y ,v.z);
    shape.endShape();
    
    pshape = createShape();
    pshape.beginShape(POINTS);
    for(PVector v : vertices)
      pshape.vertex(v.x, v.y ,v.z);
    pshape.endShape();
    
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
    

    

    // rendering modes
    if (retained){ 
        if(mode == 3)
          shape(pshape);
        else
          shape(shape);        
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