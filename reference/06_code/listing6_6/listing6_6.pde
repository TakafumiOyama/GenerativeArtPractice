int _num = 10;
Circle[] _circleArr = {};   

void setup() {
  size(500,300); 
  background(255);
  smooth();
  strokeWeight(1);
  fill(150, 50);
  drawCircles();
}

void draw() {
  background(255);
  for (int i=0; i<_circleArr.length; i++) {
    Circle thisCirc = _circleArr[i];
    thisCirc.updateMe();
  }
}

void mouseReleased() {
  drawCircles();
}

void drawCircles() {
  for (int i=0; i<_num; i++) { 
    Circle thisCirc = new Circle();
    thisCirc.drawMe();
    _circleArr = (Circle[])append(_circleArr, thisCirc);
  }
}


//================================= objects

class Circle {

  // properties
  float x, y;
  float radius; 
  color linecol, fillcol; 
  float alph;
  float xmove, ymove;
  
  // constructor
  Circle () {
    x = random(width);
    y = random(height);
    radius = random(100) + 10; 
    linecol = color(random(255), random(255), random(255));
    fillcol = color(random(255), random(255), random(255));
    alph = random(255);
    xmove = random(10) - 5; 	
    ymove = random(10) - 5;	
  }
  
  // method - render me to screen
  void drawMe() { 
    noStroke(); 
    fill(fillcol, alph);
    ellipse(x, y, radius*2, radius*2);
    stroke(linecol, 150);
    noFill();
    ellipse(x, y, 10, 10);
  }
  
  // method - called on the frameloop
  void updateMe() {
    x += xmove;
    y += ymove;
    if (x > (width+radius)) { x = 0 - radius; }
    if (x < (0-radius)) { x = width+radius; }
    if (y > (height+radius)) { y = 0 - radius; }
    if (y < (0-radius)) { y = height+radius; }
    
   for (int i=0; i<_circleArr.length; i++) {
      Circle otherCirc = _circleArr[i];
      if (otherCirc != this) {  
        float dis = dist(x, y, otherCirc.x, otherCirc.y); 
        float overlap = dis - radius - otherCirc.radius; 
        if (overlap < 0) { 
          float midx, midy;
          if (x < otherCirc.x) {
            midx = x + (otherCirc.x - x)/2;
          } else {
            midx = otherCirc.x + (x - otherCirc.x)/2;
          }
          if (y < otherCirc.y) {
            midy = y + (otherCirc.y - y)/2;
          } else {
            midy = otherCirc.y + (y - otherCirc.y)/2;
          }
          stroke(0, 100);
          noFill();
          overlap *= -1; 
          ellipse(midx, midy, overlap, overlap);
        }
      }
    }
    
    drawMe();
  }


}

