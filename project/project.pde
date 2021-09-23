//main file
import processing.sound.*;

SoundFile raindroplet;
int index = 0;

Rain[] r = new Rain[20];

 float roadvariable = height/2 +50;



  //Table table1;

void setup(){
  size(600,600);
  //table1 = loadTable("raindata.csv", "header");
  
  raindroplet = new SoundFile(this, "droplet.mp3");
  for(int i=0; i< r.length; i++){
    r[i] = new Rain();
  }
  fill(0);

}
void draw(){
  background(255);
  environment();
  buildings();
  
  
  
    for(int i=0; i< r.length; i++){
  r[i].force();
  r[i].show();
  //topline
  line(0,height/2 +50,width,height/2+50);
  line(0,height/2 +100,width,height/2+100);

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
  
  void buildings(){
 
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


  
