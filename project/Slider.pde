// SLIDER 
class Slider{
  
  float slider_width = 50;
  float slider_height = 10;
  float posx, posy;
  boolean over = false;
  boolean locked = false;
  float xoff;
  float fundo;
  
  void setupSlider() {
    posx = width/2;
    posy = height - height/8;
    rectMode(CENTER);
    line (posx, posy, posx+100, posy);
  }
}
  
  
