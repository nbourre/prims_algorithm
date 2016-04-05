class Line {
  PVector start;
  PVector end;
  
  color c = 0xFFFFFFFF;
  int weight = 2;
  float length = 0;
  
  Boolean showLength = false;
  
  Line (int x1, int y1, int x2, int y2) {
    start = new PVector (x1, y1);
    end = new PVector (x2, y2); 
    
    getLength();
  }
  
  Line (PVector start, PVector end) {
    this.start = start;
    this.end = end;
    
    getLength();
  }
  
  float getLength () {
    if (this.length == 0) {
      this.length = PVector.dist(start, end);
    }
    
    return this.length;
  }
  
  void display() {
    pushMatrix();
    translate (start.x, start.y);
    
    stroke (c);
    strokeWeight (weight);
    
    float dX = end.x - start.x;
    float dY = end.y - start.y;
    
    line (0, 0, dX, dY);
    
    if (showLength) {
      text (this.length, dX / 2, dY / 2);
    }
    
    popMatrix();
  }
  
  
  
}