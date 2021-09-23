class Rain{
  float x = random(width);
  float y = random(-600,-10);
  float ySpeed = random(4,10);
  float ranLength = random (1,5);
  float dimensions = random(2,20);
  float curviture = random(20,50);
  float xSize = random(10,20);
  

  float xSpeed;
  
  void force(){
  y=y+ySpeed;
  x = x+xSpeed;
  ySpeed = ySpeed + 0.02;

  
  if (y > height){
    y = random(-200,-100);
    ySpeed= random(4,10);

    rainSound();
    
    }
  }
  
  void show(){
    float perspective = map(dimensions, 0 ,20, 1, 3);
    stroke(0);
    strokeWeight(perspective);
    line(x,y,x,  y+ranLength);
  }
  
}
