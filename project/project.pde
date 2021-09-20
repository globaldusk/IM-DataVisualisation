//main file
Rain[] r = new Rain[500];
void setup(){
  size(600,600);
  for(int i=0; i< r.length; i++){
    r[i] = new Rain();
  }
}
void draw(){
  background(255);
    for(int i=0; i< r.length; i++){
  r[i].force();
 
  r[i].show();
    }
}
