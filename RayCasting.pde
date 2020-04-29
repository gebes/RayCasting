import java.util.*;

List<Wall> walls = new ArrayList();

void setup(){
  size(1280, 720);
  walls.add(new Wall(new Vector(100,150), new Vector(200,250)));
  
  
}

void draw(){
  background(0);
  for(Wall wall : walls)
    wall.draw();
    
  for(int i = 0; i < 360; i++){
    Ray ray = new Ray(new Vector(mouseX, mouseY), i);
    ray.draw();
  }
    
}

class Ray{
  Vector start;
  float angle;
  Vector dir;
  Ray(Vector start, float angle){
   this.start = start; 
   this.angle = angle;
   this.dir = new Vector(
     (int)((float) start.x + 100000f * cos(angle)),
     (int)((float) start.y + 100000f * sin(angle))
   );
   cast();
  }
  
  void cast(){
    
  }
  
  void draw(){
    stroke(255);
    line(start.x, start.y, dir.x, dir.y);
  }
  
}

class Wall{
  Vector a, b;
  Wall(Vector a, Vector b){
   this.a = a;
   this.b = b;
  }
  
  void draw(){
    stroke(255);
    line(a.x, a.y, b.x, b.y);
  }
  
}



class Vector{
 int x, y;
 Vector(int x, int y){
  this.x = x;
  this.y = y;
 }
}
