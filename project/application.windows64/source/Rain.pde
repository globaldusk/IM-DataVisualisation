class Rain{
  float x = random((width/2 - width), (width/2 + width));
  float y = random(-600,-10);
  float ySpeed = random(4,10);
  float ranLength = random (1,5);
  float dimensions = random(2,20);
  float curviture = random(20,50);
  float xSize = random(10,20);
  float rainColor = random(256);
  

  float xSpeed;
  float randomRainNum;
  void force(){
    y=y+ySpeed;
    x = x+xSpeed;
    ySpeed = ySpeed + 0.02;

  
    if (y > height){
      y = random(-200,-100);
      ySpeed= random(4,10);
      
      
      randomRainNum = random(0, 5);
      
      if ((int)randomRainNum == 1){
        rainSound();
        
      }
      
      
      
    }
    if(x < (width/2 - width)){
      x = random(width/2 + width);
    }
    else if(x > (width/2 + width)){
      x = random(width/2 - width);
    }
  }
  
  void show(){
    float perspective = map(dimensions, 0 ,20, 1, 3);
    push();
    colorMode(HSB);
    //fill(random());
    stroke(0, 0, rainColor);
    strokeWeight(perspective);
    line(x,y,x,  y+ranLength);
    pop();
  }
  
}
