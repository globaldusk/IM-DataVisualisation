//main file

Planet sun;
Planet moon;

void setup(){
  size(700,500);
  
  sun = new Planet(color(249, 215, 28),width/2,height/2-50,25,1);
  moon = new Planet(color(244, 246, 240),width/2,height/2+50,15,1);
}

void draw(){
  background(0);
  
  sun.display();
  moon.display();
}





class Planet{
  color c;
  float x;
  float y;
  float size;
  float speed;
  
  Planet(color tempC, float tempX, float tempY, float tempSize, float tempSpeed){
    c = tempC;
    x = tempX;
    y = tempY;
    size = tempSize;
    speed = tempSpeed;
  }
  
  void display(){
    fill(c);
    circle(x,y,size);
  }
  
  void move(){
    
  }
}
