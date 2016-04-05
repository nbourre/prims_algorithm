int currentTime;
int previousTime;
int deltaTime;

int displayInterval = 1000;
int displayAcc = 0;

int resetInterval = 9;
int resetAcc = 0;

ArrayList <Node> vertices;
ArrayList <Line> edges;

Boolean refresh = false;

Boolean debugMode = false;

Boolean demoMode = true;


int nbNodes = 50;


void setup () {
  fullScreen();
  
  currentTime = millis();
  previousTime = millis();
  
  vertices = new ArrayList<Node>();
  edges = new ArrayList<Line>();
  
  randomize();
 
}

void draw () {
  currentTime = millis();
  deltaTime = currentTime - previousTime;
  
  update(deltaTime);
  display();
  
  previousTime = currentTime;
}

void update(int delta) {
  
  if (demoMode) {
    displayAcc += delta;
    
    if (displayAcc > displayInterval) {
      displayAcc = 0;
      
      if (resetAcc > resetInterval) {
        resetAcc = 0;
        reset();
      } else {
        randomize();
      }
      
      resetAcc++;
    }
  }
  
  if (refresh) {
    
    ArrayList<Node> reached = new ArrayList<Node>();
    ArrayList<Node> unreached = new ArrayList<Node>();
    edges = new ArrayList<Line>();
    
    for (Node n: vertices) {
      n.visited = false;
      n.from = null;
      unreached.add (n);
    }
    
    unreached.get(0).visited = true;
    reached.add(unreached.get(0));
    unreached.remove(0);
        
    while (unreached.size() > 0) {
       float minDist = width * height;
       int rIndex = 0;
       int uIndex = 0;
       
       for (int i = 0; i < reached.size(); i++) {
         Node n1 = reached.get(i);
         
         for (int j = 0; j < unreached.size(); j++) {
           Node n2 = unreached.get(j);
          
           float d = Node.dist(n1, n2);
          
           if (d < minDist) {
             minDist = d;
             rIndex = i;
             uIndex = j;          
           }
         }
       }
     
       Node n = unreached.get(uIndex);
       n.visited = true;
       n.from = reached.get(rIndex);

       reached.add (n);
        
       unreached.remove(uIndex);
       
       Line l = new Line(n.from, n);
       
       if (debugMode) {
         l.showLength = true;
       }
       
       edges.add(l);
       
       
    }
    
    refresh = false;
  }
}

void display () {
  background (0);
  
  for (int i = 0; i < edges.size(); i++) {

    edges.get(i).display();
  }
  
  for (int i = 0; i < vertices.size(); i++) {

    vertices.get(i).display();
  }
}

void mousePressed() {
  if (mouseButton == LEFT) {
    Node n = new Node(mouseX, mouseY);
    vertices.add(n);
    
    refresh = true;
  }
  
  if (mouseButton == RIGHT) {
    for (int i = 0 ; i < vertices.size(); i++) {
      Node n = vertices.get(i);
      
      if (n.isTouched(mouseX, mouseY)) {
        int idx = vertices.indexOf(n);
        vertices.remove(idx);
        refresh = true;
      }
    }
  }
}

void keyPressed() {
  if (key == 'd') {
    for (Node n : vertices) {
      System.out.println (n.toString());
    }
    
    debugMode = !debugMode;
    for (Line l : edges) {
      
      l.showLength = debugMode;
    }
  }
  
  if (key == ' ') {
    randomize();
  }
  
  if (key == 'r') {
    reset();
  }

}

void randomize() {
  for (int i = 0; i < nbNodes; i++) {
    vertices.add(new Node (random(width), random (height)));
    refresh = true;
  }
}

void reset () {
  vertices.clear();
  
  randomize();   
}