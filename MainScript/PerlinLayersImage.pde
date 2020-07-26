class PerlinLayersImage{
  FloatList amps;
  FloatList freqs;
  
  float hues[][];
  boolean updated;
  
  PerlinLayersImage(FloatList a, FloatList f){
    this.hues = new float[width][height];
    this.amps = a;
    this.freqs = f;
    
    this.update();
  }
  
  void update(){
    this.updated = true;
    
    float zPos[][] = new float [width][height];
    for(int y=0; y<height; y++){
      for(int x=0; x< width; x++){
        zPos[x][y] = 0;
      }
    }
    
    for(int i=0; i<this.amps.size(); i++){
      float xOffset = random(10000);
      float yOffset = random(10000);
      for(int y=0; y<height; y++){
        for(int x=0; x<width; x++){
          zPos[x][y] += this.amps.get(i)*noise(x*noiseSpeed*this.freqs.get(i) + xOffset, y*noiseSpeed*this.freqs.get(i) + yOffset);
        }
      }
    }
    
    float zMin = minPerso(zPos);
    float zMax = maxPerso(zPos);
    for(int y=0; y<height; y++){
      for(int x=0; x< width; x++){
        this.hues[x][y] = map(zPos[x][y], zMin, zMax, 0, 127);
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
