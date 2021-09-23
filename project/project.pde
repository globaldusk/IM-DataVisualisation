//main file
Rain[] r = new Rain[100];
Slider slider = new Slider();

Planet sun;
Planet moon;

void setup(){
  size(700,500);
  
  sun = new Planet(color(249, 215, 28),width/2,height/2-50,25,1);
  moon = new Planet(color(244, 246, 240),width/2,height/2+50,15,1);
  
  for(int i=0; i< r.length; i++){
    r[i] = new Rain();
  }
  //makes the slider
  slider.setupSlider();
}

void draw(){
  background(255);
  
  sun.display();
  moon.display();
  
  drawSlider();
    //go through each rain object
    for(int i=0; i< r.length; i++){
     
    r[i].xSpeed = (slider.posx-250)/25;
    r[i].force();
    r[i].show();
    
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
