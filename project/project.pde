//main file
import processing.sound.*;

SoundFile raindroplet;
int index = 0;

Rain[] r = new Rain[100];

Slider slider = new Slider();
float windSliderValue;
float sunSliderValue;

Table rainTable;
float[] rainArray;

Planet sun;
Planet moon;

void setup(){
  size(600,600);
  
  sun = new Planet(color(249, 215, 28),width/2,height/2-50,25,1);
  moon = new Planet(color(244, 246, 240),width/2,height/2+50,15,1);
  
 
  raindroplet = new SoundFile(this, "droplet2.mp3");
  //creates rain
  for(int i=0; i< r.length; i++){
    r[i] = new Rain();
  }
  
  
  //makes the slider
  slider.setupSlider();
  rainTable = loadTable("raindata.csv", "header");
  
  rainArray = rainTableInterpretation(rainTable);
  
  
  
}

//function that returns the array for rain values into a float array
float[] rainTableInterpretation(Table table){
  float[] rainValueArr = new float[table.getRowCount()+1];
  int count = 0;
  for(TableRow row: table.rows()){
    rainValueArr[count] = row.getFloat(1);
    
    count++;
  
  }
    
  return rainValueArr;

}


void draw(){
  background(255);
  
  sun.display();
  moon.display();
  
  drawSlider();
  windSliderValue = (slider.posx-width/10)* 5.39375;
  
  
  println(windSliderValue);
    //go through each rain object
  for(int i=0; i< r.length; i++){
    
    //changes rain speed based on slider pos
    //r[i].xSpeed = (int)(rainArray[(int)windSliderValue]);
    
    
    }
  
  sunSliderValue = (slider.posx-60)*1.19791667;
  
  environment();
  buildings();
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
  //reset the stroke to black after making the rain color
  stroke(0);
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

 


    //fill(56);
    //rect(0,175,35,height/2+50);
    //rect(50,300,50,130);
    pop();
  }
  
  void environment(){
    //change colour depending on the time of day?
    fill(35);
  noStroke();
  triangle(-250,300,50,100,280,300);
  triangle(-50,300,140,130,320,300);
  triangle(50,300,300,80,490,300);
  triangle(170,300,400,140,560,300);
  triangle(250,300,490,100,700,300);
  }
