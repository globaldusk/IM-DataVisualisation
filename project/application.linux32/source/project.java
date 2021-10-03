import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import beads.*; 
import java.util.Arrays; 
import processing.sound.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class project extends PApplet {

//main file

 

AudioContext ac;




SoundFile raindroplet;
int index = 0;

//import processing.sound.*;
int delayer = 0;
int delayer2 = 0;
int setter = 0;
int limit = 0;
int number = 4;
int rotation = 576*number;
boolean flip = false;

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
//car
Roadlines two;
PImage carImage;
boolean startLoading = true;

public void setup(){
  
  img = loadImage("cloud.png");
  sunlight = loadTable("SolarVoltage.csv", "csv");

  carImage = loadImage("car.png");

  two = new Roadlines();

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

public float[] rainTableInterpretation(Table table){
  float[] rainValueArr = new float[table.getRowCount()+1];
  int count = 0;
  for(TableRow row: table.rows()){
    rainValueArr[count] = row.getFloat(1);
    
    count++;
  
  }
    
  return rainValueArr;

}


public void collisionDetector(int xPos, int yPos, int sunSlider){
  
  /*if(xPos >= sunxs[sunSlider]-(sun.size/2)){
    System.out.println("Greater");
  }*/
  //when game starts
  
 
  if(startLoading || sun == null){
      return;
      
  }
  int c = get(mouseX, mouseY);
  //check sun
  if((xPos <= sunxs[sunSlider]+(sun.size/2)  && xPos >= sunxs[sunSlider]-(sun.size/2)   ) && (   yPos >= sunys[sunSlider]-(sun.size/2) && yPos <= sunys[sunSlider]+(sun.size/2)  ) && (yPos < width/2)){
    
    textSize(30);
    text("Sun",mouseX + 30, mouseY);
   
  }
  
  //check moon
  
  else if((xPos <= moonxs[sunSlider]+(moon.size/2)  && xPos >= moonxs[sunSlider]-(moon.size/2)   ) && (   yPos >= moonys[sunSlider]-(moon.size/2) && yPos <= moonys[sunSlider]+(moon.size/2)  ) && (yPos < height/2)){
      textSize(30);
      fill(255, 255, 255);
      text("Moon", mouseX + 30, mouseY);
    
  }
  
  
  //river
  else if(c == -3741697){
    textSize(30);
    fill(0, 40, 255);
   
    text("River", mouseX + 30, mouseY);
    fill(0);
  
  }
  //car check
  else if(xPos < 323 && xPos > 276 && yPos < 376 && yPos > 347){
    textSize(30);
    fill(255, 0, 0);
    text("Car", mouseX + 30, mouseY);
  }
  else if(yPos < 392 && yPos > 350){
    textSize(30);
    fill(0, 255, 0);
    text("Road", mouseX + 30, mouseY);
  }
  
  
  
  else if(c == -5066062 || c == - 65794){
    textSize(30);
    fill(0, 0, 255);
    text("Building", mouseX + 30, mouseY);
  }
  
  else if(c == -1 || c == -10329502){
    textSize(30);
    fill(255, 255, 0);
    text("Mountain", mouseX + 30, mouseY);
  }
  else if(c == -2697513){
    textSize(30);
    fill(1);
    text("Cloud", mouseX + 30, mouseY);
  }
  else if(yPos < 100){
    textSize(30);
    fill(255);
    text("Sky", mouseX + 30, mouseY);
  }
  
  
  
  
}

int darkness;

public void draw(){
  sunIndex = PApplet.parseInt(sunSlider);
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
    
  sliderValue = (slider.posx - (width/2))/(width/5);
  sunSlider = (slider.posx-60)*1.19791667f;
  
  if (limit < rotation){
    
    planetAxis();
    limit++;
  }
  else{
    index = PApplet.parseInt(sunSlider);
    
    
    sun = new Planet(color(249, 215, 28),sunxs[index],sunys[index],sample,1);
    moon = new Planet(color(244, 246, 240),moonxs[index],moonys[index],25,1);
    sun.display();
    moon.display();
  }
  water();
  windSliderValue = (slider.posx-width/10)* 5.39375f;
 
   
    //go through each rain object
  for(int i=0; i< r.length; i++){
    
    //changes rain speed based on slider pos
    if((int)rainDataArray[(int)windSliderValue] == 0){
      r[i].xSpeed = 0;
      continue;
    }
    else{
      r[i].xSpeed = (int)(rainDataArray[(int)windSliderValue]);
    }
    
    
    
    }
  drawSlider();
  
  if(sunys[index] <250){
    push();
    tint(255, (21-sample)*12.75f);
    image(img, 0, -50);
    img.resize(600, 200);
    pop();
  }
  
  environment();
  buildings();
  road();
  caller();
  noTint();
  image(carImage, 275, 340);
  
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
    if(!flip){
      tonePlayer();
      flip = true;
    }
    startLoading = false;
    rainDisplay();
  }
  
  
  
  collisionDetector(mouseX, mouseY, (int)sunSlider);
  
}
class Planet{
  int c;
  float x;
  float y;
  float size;
  float speed;
  
  
  Planet(int tempC, float tempX, float tempY, float tempSize, float tempSpeed){
    c = tempC;
    x = tempX;
    y = tempY;
    size = tempSize;
    speed = tempSpeed;
  }
  
  public void display(){
    fill(c);
    circle(x,y,size);
  }
  
}

public void planetAxis(){
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
              sunxs[setter] = PApplet.parseInt(sunX);
              sunys[setter] = PApplet.parseInt(sunY);
              moonxs[setter] = PApplet.parseInt(moonX);
              moonys[setter] = PApplet.parseInt(moonY);
              //print(int(sunX)+"        ");
              setter++;
              append(sunys, PApplet.parseInt(sunY));
              append(moonys, PApplet.parseInt(moonY));
              delayer = 0;
            }
            else{
              delayer++;
            }
        }
    }
}


public void drawSlider() {
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
      fill(254);
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


public void mousePressed() {
  //check if slider has been clicked
  if (slider.over) {
    slider.locked = true;
    slider.xoff = mouseX-slider.posx;
  }
}
public void mouseDragged() {
  //check if mouse is dragging slider
  if (slider.locked) {
    slider.posx = mouseX-slider.xoff;
  }
  
  
}
public void mouseReleased() {
  slider.locked = false;
}

public void rainDisplay(){
        for(int i=0; i< r.length; i++){
  r[i].force();
  r[i].show();
  //reset the stroke to black after making the rain color
  stroke(0);
        }
  }
  public void rainSound(){
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
  
  public void road(){
    //line(0,height/2 +50,width,height/2+50);
    //line(0,height/2 +100,width,height/2+100);
    push();
    rectMode(CORNERS);
    fill(196,196,196);
    rect(-10,height/2 +50,width+10,height/2+100);
    float w = 45;
    float h = 380;
    strokeWeight(10);
    fill(0);
    
    
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
  
  public void buildings(){
    push();
    rectMode(CORNERS);
    fill(178);
    
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


    fill(254, 254, 254);
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
  
  public void environment(){
    //change colour depending on the time of day?
   //change the fill parameter depending on the time of day
   //implement different triangles, depending on time of day
   //shadow triangles and snow triangles
  
  
  fill(98);
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
    public void water(){
      
    push();
    rectMode(CORNERS);

    fill(198,231,255);
    rect(-10,400,610,610);
    
    pop();
    }
    
    public void river(){
      push();
      //frameRate(5);
       float w = random(0,100); //width of rect
       float h = 10;//height of rect
       float x = 0;//how far across the page
       float y;//how low or high on the page
       
       for( float i = x; i<=height; i = i + w*2 ){ //draws a line of rect, changes x position
        noStroke();    //takes away stroke
          y = random(400,600);//sets y height randomly within 150-250 when mouse clicked
          fill(random(227,245), random(227,245), random(227,245));//sets random shade of purple when mouse clicked
        
       rect( i,y, w,h );//draws rect  
      }
      
      pop();
    }
    

public void tonePlayer(){
   Clock clock = new Clock(darkness);
   clock.addMessageListener(
    //this is the on-the-fly bead
    new Bead() {
      //this is the method that we override to make the Bead do something
      int pitch;
       public void messageReceived(Bead message) {
          Clock c = (Clock)message;
          if(c.isBeat()) {
            //choose some nice frequencies
            if(random(1) < 0.5f) return;
            pitch = Pitch.forceToScale((int)random(12), Pitch.dorian);
            float freq = Pitch.mtof(pitch + (int)random(5) * 10 + darkness/10+50);
            WavePlayer wp = new WavePlayer(freq, Buffer.SINE);
            Gain g = new Gain(1, new Envelope(0));
            g.addInput(wp);
            ac.out.addInput(g);
            ((Envelope)g.getGainEnvelope()).addSegment(0.1f, random(200));
            ((Envelope)g.getGainEnvelope()).addSegment(0, random(7000), new KillTrigger(g));
         
  
   
         }
       }
       }
     
   );
   ac.out.addDependent(clock);
   ac.start();
}


public void caller(){
   two.move();
   two.rline();
    
  
  }
  
  class Roadlines{
  float x = 0;
  float y = 375;
  float xMove = 13;
  float y2 = 20;
  
  
  public void move(){
    x= x+xMove;
    if (x > width){
      x = 0;
    }
   }
  
  public void rline(){
    push();
  fill(0);
  stroke(0,0,0);
  strokeWeight(3);
  rectMode(CORNERS);
  rect(x,y,x+20,y+5);
  
  pop();
  }


 }
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
  public void force(){
    y=y+ySpeed;
    x = x+xSpeed;
    ySpeed = ySpeed + 0.02f;

  
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
  
  public void show(){
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
// SLIDER 
class Slider{
  
  float slider_width = 50;
  float slider_height = 10;
  float posx, posy;
  boolean over = false;
  boolean locked = false;
  float xoff;
  float fundo;
  
  public void setupSlider() {
    posx = width/2;
    posy = height - height/8;
    rectMode(CENTER);
    line (posx, posy, posx+100, posy);
  }
}
  
  
  public void settings() {  size(600,600); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "--present", "--window-color=#666666", "--stop-color=#cccccc", "project" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
