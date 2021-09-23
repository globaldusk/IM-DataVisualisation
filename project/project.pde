//main file

import processing.sound.*;

SoundFile raindroplet;
int index = 0;

Rain[] r = new Rain[20];

Slider slider = new Slider();

Planet sun;
float sunX;
float sunY;

Planet moon;
float moonX;
float moonY;

void setup(){
  size(600,600);
  
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
  fill(255);
  ellipse(width/2, height/2, 800, 500);
  strokeWeight(5);
  planetAxis();
  sun.display();
  moon.display();
  
  drawSlider();
    //go through each rain object
    for(int i=0; i< r.length; i++){
     
     r[i].xSpeed = (slider.posx - (width/2))/(width/5);
    
    }
    
  environment();
  //buildings();
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
  
}

void planetAxis(){
    int cx = width/2;
    int cy = height/2;

    int a = 400; // major axis of ellipse
    int b = 250; // minor axis of ellipse

    float t = millis()/4000.0f; //increase to slow down the movement

    ellipse(cx, cy, 5, 5);

    for (int i = 1 ; i <= 12; i++) {
        t = t + 100;
        sunX = (int)(cx - a * cos(t));
        sunY = (int)(cy - b * sin(t));
        moonX = (int)(cx + a * cos(t));
        moonY = (int)(cy + b * sin(t));
        fill(0);

        if (i == 10) {
            textSize(15);
            sun = new Planet(color(249, 215, 28),sunX,sunY,70,1);
            moon = new Planet(color(244, 246, 240),moonX,moonY,25,1);
        }
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
    rect(slider.posx, slider.posy, slider.slider_width, slider.slider_height);
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
  
  void environment(){
    //change colour depending on the time of day?
    fill(100);
  triangle(-250,300,50,100,280,300);
  triangle(-50,300,140,130,320,300);
  triangle(50,300,300,80,490,300);
  triangle(170,300,400,140,560,300);
  triangle(250,300,490,100,700,300);
  }
