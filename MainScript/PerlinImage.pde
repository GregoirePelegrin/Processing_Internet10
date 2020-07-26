class PerlinImage{
  float hues[][];
  boolean updated;
  
  PerlinImage(){
    this.hues = new float[width][height];
    
    this.update();
  }
  
  void update(){
    this.updated = true;
    
    float xOffset = random(10000);
    float yOffset = random(10000);
    
    for(int y=0; y<height; y++){
      for(int x=0; x<width; x++){
        this.hues[x][y] = map(noise(xOffset+x*noiseSpeed, yOffset+y*noiseSpeed), 0, 1, 0, 127);
      }
    }
  }
  
  void display(){
    this.updated = false;
    
    for(int y=0; y<height; y++){
      for(int x=0; x<width; x++){
        stroke(this.hues[x][y], 100);
        point(x, y);
      }
    }
  }
}
