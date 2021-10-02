//main file
import beads.*;
import java.util.Arrays; 

AudioContext ac;


import processing.sound.*;

SoundFile raindroplet;
int index = 0;

//import processing.sound.*;
int delayer = 0;
int delayer2 = 0;
int setter = 0;
int limit = 0;
int number = 4;
int rotation = 576*number;

int[] sunxs = new int[rotation];
int[] sunys = new int[rotation];
int[] moonxs = new int[rotation];
int[] moonys = new int[rotation];

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

float windSliderValue;
float sunSliderValue;

Table rainTable;
float[] rainDataArray;

PImage img;
boolean startLoading = true;

void setup(){
  size(600,600);
  img = loadImage("cloud.png");
  sunlight = loadTable("SolarVoltage.csv", "csv");

  ac = AudioContext.getDefaultContext();
  //tonePlayer1();
  
  //table1 = loadTable("raindata.csv", "header");
  raindroplet = new SoundFile(this, "droplet2.mp3");

  for(int i=0; i< r.length; i++){
    r[i] = new Rain();
  }
  
  
  //makes the slider
  slider.setupSlider();

  rainTable = loadTable("raindata.csv", "header");
  
  rainDataArray = rainTableInterpretation(rainTable);
  
}

float[] rainTableInterpretation(Table table){
  float[] rainValueArr = new float[table.getRowCount()+1];
  int count = 0;
  for(TableRow row: table.rows()){
    rainValueArr[count] = row.getFloat(1);
    
    count++;
  
  }
    
  return rainValueArr;

}


void collisionDetector(int xPos, int yPos, int sunSlider){
  
  /*if(xPos >= sunxs[sunSlider]-(sun.size/2)){
    System.out.println("Greater");
  }*/
  //when game starts
  
  if(startLoading || sun == null){
      return;
      
  }
  //check sun
  if((xPos <= sunxs[sunSlider]+(sun.size/2)  && xPos >= sunxs[sunSlider]-(sun.size/2)   ) && (   yPos >= sunys[sunSlider]-(sun.size/2) && yPos <= sunys[sunSlider]+(sun.size/2)  ) && (xPos < width/2)){
    
    textSize(30);
    text("Sun",mouseX, mouseY);
   
  }
  
  //check moon
  
  if((xPos <= moonxs[sunSlider]+(moon.size/2)  && xPos >= moonxs[sunSlider]-(moon.size/2)   ) && (   yPos >= moonys[sunSlider]-(moon.size/2) && yPos <= moonys[sunSlider]+(moon.size/2)  ) && (yPos < height/2)){
      textSize(30);
      text("Moon", mouseX, mouseY);
    
  }
  color c = get(mouseX, mouseY);
  println(c);
  if(c == -13872152){
    textSize(30);
    text("River",mouseX, mouseY);
  
  }
  //car = -16777216
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

  drawSlider();
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
    
    
    sun = new Planet(color(249, 215, 28),sunxs[index],sunys[index],sample,1);
    moon = new Planet(color(244, 246, 240),moonxs[index],moonys[index],25,1);
    sun.display();
    moon.display();
  }
  water();
  windSliderValue = (slider.posx-width/10)* 5.39375;
 
   
    //go through each rain object
  for(int i=0; i< r.length; i++){
    
    //changes rain speed based on slider pos
    r[i].xSpeed = (int)(rainDataArray[(int)windSliderValue]);
    
    
    }
  drawSlider();

  if(sunys[index] <250){
    image(img, 0, -50);
  img.resize(600, 200);
  tint(255, (21-sample)*12.75);
  }
  
  
  environment();
  buildings();
  road();
  
  if (delayer2 == 50){
    river();
    delayer2 = 0;
  }
  else{
    delayer2++;
  }

  if (limit < rotation){
    fill(0);
    rect(0,0, width*2, height*2);
    fill(255);
    textSize(100);
    text("Loading...",width/8, height/2);
  }
  else{
    startLoading = false;
    rainDisplay();
  }
  
  
  
  collisionDetector(mouseX, mouseY, (int)sunSlider);
  
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
              //print(int(sunX)+"        ");
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
  //reset the stroke to black after making the rain color
  stroke(0);
        }
  }
  void rainSound(){
    raindroplet.play();
  
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
    //line(0,height/2 +50,width,height/2+50);
    //line(0,height/2 +100,width,height/2+100);
    push();
    rectMode(CORNERS);
    fill(255);
    rect(-10,height/2 +50,width+10,height/2+100);
    float w = 45;
    float h = 380;
    strokeWeight(10);
    fill(0);
    quad(270,370,330,370,250,380,350,380);
    
    //float y= 370;
    //for(float i = 0; i < width; i = i + w*2){
    //  rect(i, y , w, h);
    //}
    pop();
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
    void water(){
      
    push();
    rectMode(CORNERS);

    fill(44,83,232);
    rect(-10,400,610,610);
    
    pop();
    }
    
    void river(){
      push();
      //frameRate(5);
       float w = random(0,100); //width of rect
       float h = 10;//height of rect
       float x = 0;//how far across the page
       float y;//how low or high on the page
       
       for( float i = x; i<=height; i = i + w*2 ){ //draws a line of rect, changes x position
        noStroke();    //takes away stroke
          y = random(400,600);//sets y height randomly within 150-250 when mouse clicked
          fill(random(100,200), random(50,150), random(200,300));//sets random shade of purple when mouse clicked
        
       rect( i,y, w,h );//draws rect  
      }
      
      pop();
    }
    

void tonePlayer(int x, int y,int z){
   Clock clock = new Clock(x+y+z);
   clock.addMessageListener(
    //this is the on-the-fly bead
    new Bead() {
      //this is the method that we override to make the Bead do something
      int pitch;
       public void messageReceived(Bead message) {
          Clock c = (Clock)message;
          if(c.isBeat()) {
            //choose some nice frequencies
            if(random(1) < 0.5) return;
            pitch = Pitch.forceToScale((int)random(12), Pitch.dorian);
            float freq = Pitch.mtof(pitch + (int)random(5) * 10 + 25);
            WavePlayer wp = new WavePlayer(freq, Buffer.SINE);
            Gain g = new Gain(1, new Envelope(0));
            g.addInput(wp);
            ac.out.addInput(g);
            ((Envelope)g.getGainEnvelope()).addSegment(0.1, random(200));
            ((Envelope)g.getGainEnvelope()).addSegment(0, random(7000), new KillTrigger(g));
         
  
   
         }
       }
       }
     
   );
   ac.out.addDependent(clock);
   ac.start();
}

void tonePlayer1(){
   Clock clock = new Clock(700);
   clock.addMessageListener(
    //this is the on-the-fly bead
    new Bead() {
      //this is the method that we override to make the Bead do something
      int pitch;
       public void messageReceived(Bead message) {
          Clock c = (Clock)message;
          if(c.isBeat()) {
            //choose some nice frequencies
            if(random(1) < 0.5) return;
            pitch = Pitch.forceToScale((int)random(12), Pitch.dorian);
            float freq = Pitch.mtof(pitch + (int)random(5) * 12 + 32);
            WavePlayer wp = new WavePlayer(freq, Buffer.SINE);
            Gain g = new Gain(1, new Envelope(0));
            g.addInput(wp);
            ac.out.addInput(g);
            ((Envelope)g.getGainEnvelope()).addSegment(0.1, random(200));
            ((Envelope)g.getGainEnvelope()).addSegment(0, random(7000), new KillTrigger(g));
         }
  
   
         }
       }
     
   );
   ac.out.addDependent(clock);
   ac.start();
}
