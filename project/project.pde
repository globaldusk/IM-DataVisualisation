//main file

import processing.sound.*;

SoundFile raindroplet;
int index = 0;

Rain[] r = new Rain[20];

Slider slider = new Slider();

Planet sun;
Planet moon;

void setup(){
  size(600,600);
  
  sun = new Planet(color(249, 215, 28),width/2,height/2-50,25,1);
  moon = new Planet(color(244, 246, 240),width/2,height/2+50,15,1);
  
  //table1 = loadTable("raindata.csv", "header");
  raindroplet = new SoundFile(this, "droplet.mp3");
  
  for(int i=0; i< r.length; i++){
    r[i] = new Rain();
  }
  //makes the slider
  slider.setupSlider();
}

void draw(){
  background(255);
  println(mouseX,mouseY);
  
  strokeWeight(5);
  sun.display();
  moon.display();
  
  drawSlider();
    //go through each rain object
    for(int i=0; i< r.length; i++){
     
    r[i].xSpeed = (slider.posx - (width/2))/(width/5);
    
    }
    
  environment();
  pushMatrix();
  buildings();
  popMatrix();
  road();
  rainDisplay();
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

void drawSlider() {
    slider.fundo = slider.posx;
    //buffer to variably change width of slide bar
    float leftBuffer = width/10;
    float rightBuffer = width-(width/10);
    
    //draw the slider line
    line (rightBuffer, slider.posy, leftBuffer, slider.posy);
    if (dist(mouseX, mouseY, slider.posx, slider.posy) < slider.slider_height) {
      fill(200);
      slider.over = true;
    }
    else {
      fill(255);
      slider.over = false;
    }
  
  //make sure slider cant leave the bar length on left side
  if (slider.posx < leftBuffer) {
  slider.posx = leftBuffer;
  }
  //make sure slider cant leave the bar length on right side
  if (slider.posx > rightBuffer) {
  slider.posx = rightBuffer;
  }
  
    //draw the slider box
    push();
    rect(slider.posx, slider.posy, slider.slider_width, slider.slider_height);
    pop();
  }


void mousePressed() {
  //check if slider has been clicked
  if (slider.over) {
    slider.locked = true;
    slider.xoff = mouseX-slider.posx;
  }
}
void mouseDragged() {
  //check if mouse is dragging slider
  if (slider.locked) {
    slider.posx = mouseX-slider.xoff;
  }
  
  
}
void mouseReleased() {
  slider.locked = false;
}


void rainDisplay(){
        for(int i=0; i< r.length; i++){
  r[i].force();
  r[i].show();
        }
  }
  void rainSound(){
    //raindroplet.play();
  
  }
  //    public int getData(){
  //  if (index < table1.getRowCount()) {
  //  // read the 2nd column (the 1), and read the row based on index which increments each draw()
  //  int y = table1.getInt(index, 1);
    
  //  index++;
  //  return(y);
  //}
  //return(0);
  //  }
  
  void road(){
    line(0,height/2 +50,width,height/2+50);
    line(0,height/2 +100,width,height/2+100);
  }
  
  /*void buildings(){
 
  noStroke();
  //rect();
      fill(50, 65, 82);
      //pushMatrix();
  //translate(height/2,width/2);
  //rect(-50,-50,30,100);
  //rect(-150,-60,30,110);
  //rect(-250,-80,60,130);
  //rect(-300,-130,60,180);

  //popMatrix();
  
  for (int x=0; x <= width; x+= 30) {
  
  float buildingH = random(height*1/7, height*3.5/7); //randomizes building height
  float buildingW = random(width*1/30, width*1/12); //randomizes building width
  color colourBuildings = color(320, 81, 15); //color of buildings
  fill(colourBuildings);
  rect (x, height/2 +50, -buildingW, -buildingH); //makes buildings
  }
  }*/
  
  void buildings(){
    push();
    rectMode(CORNERS);
    fill(255);
    
    rect(0,150,50,height/2+50);
    rect(50,200,100,height/2+50);
    rect(100,125,125,height/2+50);
    rect(125,175,190,height/2+50);
    rect(190,135,230,height/2+50);
    rect(230,190,250,height/2+50);
    rect(250,200,265,height/2+50);
    rect(265,240,290,height/2+50);
    rect(290,100,325,height/2+50);
    rect(325,255,365,height/2+50);
    rect(365,280,380,height/2+50);
    rect(380,200,450,height/2+50);
    rect(450,265,480,height/2+50);
    rect(480,235,505,height/2+50);
    rect(505,150,535,height/2+50);
    rect(535,75,width,height/2+50);


    fill(56);
    rect(0,175,35,height/2+50);
    rect(40,200,55,height/2+50); 
    rect(55,160,75,height/2+50);
    rect(85,150,100,height/2+50);
    rect(100,195,140,height/2+50);
    rect(140,160,160,height/2+50);
    rect(160,175,190,height/2+50);
    rect(190,190,215,height/2+50);
    rect(215,150,240,height/2+50);
    rect(240,220,275,height/2+50);
    rect(300,140,315,height/2+50);
    rect(315,215,340,height/2+50);
    rect(340,280,360,height/2+50);
    rect(360,300,400,height/2+50);
    rect(400,160,440,height/2+50);
    rect(440,220,460,height/2+50);
    rect(460,280,480,height/2+50);
    rect(490,250,510,height/2+50);
    rect(510,170,540,height/2+50);
    rect(540,90,570,height/2+50);
    rect(570,100,width,height/2+50);
    //rect(50,300,50,130);
    pop();
  
  }
  
  void environment(){
    //change colour depending on the time of day?
   //change the fill parameter depending on the time of day
   //implement different triangles, depending on time of day
   //shadow triangles and snow triangles
  
  
  fill(35);
  triangle(-250,300,50,100,280,300);
  push();
  noStroke();
  fill(255);
  triangle(50,100,111,160,93,172);
  pop();
  
  
  triangle(-50,300,140,130,320,300);
  push();
  noStroke();
  fill(255);
  triangle(142,133,190,180,168,180);
  pop();
  
  
  triangle(50,300,300,80,490,300);
    push();
  noStroke();
  fill(255);
  triangle(302,83,371,168,354,180);
  pop();
  
  
  triangle(170,300,400,140,560,300);
    push();
  noStroke();
  fill(255);
  triangle(401,144,420,165,410,174);
  pop();
  
  
  triangle(250,300,490,100,700,300);
   push();
  noStroke();
  fill(255);
  triangle(491,103,543,160,528,169);
  pop();
  
  
  
  push();
  //strokeWeight(1);
  noStroke();
  //triangle(50,100,26,130,13,137);
  //triangle(50,100,75,132,63,124);
  //triangle(50,100,54,129,50,141);
  //triangle(50,100,44,129,33,143);
  
  pop();
  }
  
    void mountainSnow(){
      
    }
