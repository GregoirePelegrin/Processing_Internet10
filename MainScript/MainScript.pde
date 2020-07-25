PerlinImage pImage;
float perlinSpeed = 0.01;

void setup(){
  fullScreen();
  frameRate(30);
  colorMode(HSB);
  
  pImage = new PerlinImage();
}

void draw(){
  if(pImage.updated){
    background(0);
    pImage.display();
  }
}

void mousePressed(){
  if(mouseButton == LEFT){
    pImage.update();
  }
}
