/*
 RayCasting Test
 
 
 Build Walls: 
   Select two Points wiht LeftClick
   
 RayCast:
   Move your mouse around, when not placing a wall
 
 Change RayCast by degrees
   Press Arrow Up or Down



*/

// SETTINGs

/**
  How many Rays per degree?
*/
float density = 1.0;



import java.util.*;

List < Wall > walls = new ArrayList();

void setup() {
 size(1280, 720);
 walls.add(new Wall(new PVector(100, 150), new PVector(200, 250)));
}

PVector start = null, end = null;

void draw() {
 background(0);
 
 
 if(keyPressed){
  keyPressed = false;
  if(keyCode == UP) density -= 0.1;
  if(keyCode == DOWN) density += 0.1;
 }
 
 
 if(mousePressed == true){
  mousePressed = false;
  
  if(start == null){
   start = new PVector(mouseX, mouseY); 
  }else if(end == null){
   end = new PVector(mouseX, mouseY); 
  }
  
   
 }
 
  
 for (Wall wall: walls)
  wall.draw();

 
 if(start != null){
   
   line(start.x, start.y, mouseX, mouseY);
   
   
   if(end != null){
     walls.add(new Wall(start, end));
     start = null;
     end = null;  
   }
   
   return;
 }

 for (float i = 0; i < 360 / density; i+= 1) {
  Ray ray = new Ray(new PVector(mouseX, mouseY), i);
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
  this.dir = PVector.fromAngle(angle);
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
