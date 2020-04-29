/*
 RayCasting Test
 
 
 Build Walls: 
   Select two Points wiht LeftClick
   
 RayCast:
   Move your mouse around, when not placing a wall
 
 Change FOV
   Press Arrow Up or Down



*/

// SETTINGs

/**
  How many Rays per degree?
*/
float fov = 90;



import java.util.*;

List < Wall > walls = new ArrayList();

void setup() {
 size(1280, 720);
 walls.add(new Wall(new PVector(100, 150), new PVector(200, 250)));
}

PVector lineStart = null, lineEnd = null;

PVector lastMousePosition = new PVector(0, 0);

float rotation = 0, targetRotation = rotation;

void draw() {
 background(0);
 

 if(keyPressed){
  if(keyCode == UP) fov++; 
  if(keyCode == DOWN) fov--;
 }
 
 if(mousePressed){
  mousePressed = false;
  
  if(lineStart == null){
   lineStart = new PVector(mouseX, mouseY); 
  }else if(lineEnd == null){
   lineEnd = new PVector(mouseX, mouseY); 
  }
  
   
 }
 
  
 for (Wall wall: walls)
  wall.draw();

 
 if(lineStart != null){
   
   line(lineStart.x, lineStart.y, mouseX, mouseY);
   
   
   if(lineEnd != null){
     walls.add(new Wall(lineStart, lineEnd));
     lineStart = null;
     lineEnd = null;  
   }
   
   return;
 }

 PVector mousePos = new PVector(mouseX, mouseY);
 
 if(mousePos.x != lastMousePosition.x && mousePos.y != lastMousePosition.y){
 PVector dv = lastMousePosition.sub(new PVector(mousePos.x, mousePos.y));
   targetRotation =  degrees((float)(-Math.atan2(dv.x, dv.y) - Math.PI / 2));
 lastMousePosition = mousePos;
 }
 
   rotation+= (targetRotation-rotation)*0.1;
  
  println(targetRotation + "; " +rotation);

  
 for (float i = targetRotation-(fov/2); i < targetRotation + (fov/2); i++) {
  Ray ray = new Ray(mousePos, i);
  ray.draw();
 }

}

class Ray {
 PVector start, end;
 PVector dir;
 float angle;
 Ray(PVector start, float angle) {
  this.start = start;
  this.angle = angle;
  this.dir = PVector.fromAngle(radians(angle));
  castAll();
 }

 private void castAll() {
  float record = 2100000000;
  PVector closest = null;
  for (Wall wall: walls) {
   PVector vec = cast(wall);
   if (vec == null) continue;

   float dis = lineLength(start.x, start.y, vec.x, vec.y);
   if (dis < record) {
    record = dis;
    closest = vec;
   }

  }
  end = closest != null ? closest : dir.mult(2100000);
 }

 PVector cast(Wall wall) {
  float x1 = wall.a.x;
  float y1 = wall.a.y;
  float x2 = wall.b.x;
  float y2 = wall.b.y;

  float x3 = this.start.x;
  float y3 = this.start.y;
  float x4 = this.start.x + this.dir.x;
  float y4 = this.start.y + this.dir.y;

  float den = (x1 - x2) * (y3 - y4) - (y1 - y2) * (x3 - x4);
  if (den == 0) {
   return null;
  }

  float t = ((x1 - x3) * (y3 - y4) - (y1 - y3) * (x3 - x4)) / den;
  float u = -((x1 - x2) * (y1 - y3) - (y1 - y2) * (x1 - x3)) / den;
  if (t > 0 && t < 1 && u > 0) {
   PVector pt = new PVector();
   pt.x = x1 + t * (x2 - x1);
   pt.y = y1 + t * (y2 - y1);
   return pt;
  } else {
   return null;
  }
 }

 float lineLength(float x1, float y1, float x2, float y2) {
  return (float) Math.sqrt(((x2 - x1) * (x2 - x1)) + ((y2 - y1) * (y2 - y1)));
 }

 void draw() {
  end = end.sub(start);
  stroke(255);
  pushMatrix();
  translate(start.x, start.y);
  line(0, 0, end.x, end.y);
  popMatrix();
 }

}

class Wall {
 PVector a, b;
 Wall(PVector a, PVector b) {
  this.a = a;
  this.b = b;
 }

 void draw() {
  stroke(255);
  line(a.x, a.y, b.x, b.y);
 }

}
