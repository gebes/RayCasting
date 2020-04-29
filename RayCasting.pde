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
