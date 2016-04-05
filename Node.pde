class Node extends PVector {
  
  int diameter = 15;
  color c = 0xFFFFFFFF;
  
  boolean visited = false;
  
  Node from;
  
  
  Node(float x, float y) {
    this.x = x;
    this.y = y;  
  }
  
  void display () {
    pushMatrix();
    translate (x, y);
    
    if (visited) {
      fill (color (0, 127, 0));
    }
    else {
      fill (c);
    }
    ellipse (0, 0, diameter, diameter);
    popMatrix();
  }
  
  String toString() {
    String output = "";
    
    output += "x : " + x + ", y : " + y;
    
    if (from != null) {
      output += "\tfrom --> x : " + from.x + ", y : " + from.y;
    }
    
    return output;
  }
  
  Boolean isTouched(int x, int y) {
    Boolean result = false;
    
    int radius = diameter / 2;
    if (x >= this.x - radius && x <= this.x + radius &&
        y >= this.y - radius && y <= this.y + radius) {
      result = true;  
    }
    
    return result;
  }
}