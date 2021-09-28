//main file

//import processing.sound.*;
int delayer = 0;
int setter = 0;
int limit = 0;
int number = 4;
int rotation = 576*number;

int[] sunxs = new int[rotation];
int[] sunys = new int[rotation];
int[] moonxs = new int[rotation];
int[] moonys = new int[rotation];
int index;

//SoundFile raindroplet;
//int index = 0;

Rain[] r = new Rain[20];

Slider slider = new Slider();
float sliderValue;
float sunSlider;

Table sunlight;
int sunIndex = 0;

Planet sun;
float sunX;
float sunY;

Planet moon;
float moonX;
float moonY;

int sample;

PImage img;

void setup(){
  size(600,600);
  img = loadImage("cloud.png");
  sunlight = loadTable("SolarVoltage.csv", "csv");
  
  //table1 = loadTable("raindata.csv", "header");
  //raindroplet = new SoundFile(this, "droplet.mp3");
  
  for(int i=0; i< r.length; i++){
    r[i] = new Rain();
  }
  //makes the slider
  slider.setupSlider();
}

int darkness;

void draw(){
  sunIndex = int(sunSlider);
  sample = sunlight.getInt(sunIndex, 1)*4;
  darkness = height-sunys[index];
  darkness = darkness/2;
  darkness -= 200;
  darkness += sample*2;
  background(darkness, darkness, moonY);//sky colours
  //print(sample+" / ");
  fill(255);
  //ellipse(width/2, height/2, 800, 500);
  strokeWeight(5);
  
  
    //go through each rain object
    for(int i=0; i< r.length; i++){
     
     r[i].xSpeed = (slider.posx - (width/2))/(width/5);
    
    }
  sliderValue = (slider.posx - (width/2))/(width/5);
  sunSlider = (slider.posx-60)*1.19791667;
  
  if (limit < rotation){
    
    planetAxis();
    limit++;
  }
  else{
    index = int(sunSlider);
    for(int i = 0; i < sunxs.length; i++){
      //print (xs[i]);
      //print (ys[i]+"       ");
    }
    print(darkness+"       ");
    
    sun = new Planet(color(249, 215, 28),sunxs[index],sunys[index],sample,1);
    moon = new Planet(color(244, 246, 240),moonxs[index],moonys[index],25,1);
    sun.display();
    moon.display();
  }
  
  if(sunys[index] <250){
    image(img, 0, -50);
  img.resize(600, 200);
  tint(255, (21-sample)*12.75);
  }
  
  environment();
  //buildings();
  road();
  rainDisplay();
  drawSlider();
  if (limit < rotation){
    fill(0);
    rect(0,0, width*2, height*2);
    fill(255);
    textSize(100);
    text("Loading...",width/8, height/2);
  }
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
    int b = 250;// sample; // minor axis of ellipse

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
            if (delayer == number-1){
              sunxs[setter] = int(sunX);
              sunys[setter] = int(sunY);
              moonxs[setter] = int(moonX);
              moonys[setter] = int(moonY);
              print(int(sunX)+"        ");
              setter++;
              append(sunys, int(sunY));
              append(moonys, int(moonY));
              delayer = 0;
            }
            else{
              delayer++;
            }
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
