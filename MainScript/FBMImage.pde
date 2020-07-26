// FBM stands for Fractional Brownian Motion, only is a superposition of multiple layers of Perlin noise (amplitude --, frequency ++)

class FBMImage{
  FloatList amps;
  FloatList freqs;
  
  float xOffset;
  float yOffset;
  
  float zPos[][];
  float hues[][];
  boolean updated;
  
  FBMImage(FloatList a, FloatList f){
    this.zPos = new float[width][height];
    this.hues = new float[width][height];
    this.amps = a;
    this.freqs = f;
    
    this.update();
  }
  
  void update(){
    this.updated = true;
    this.xOffset = random(10000);
    this.yOffset = random(10000);
    
    for(int y=0; y<height; y++){
      for(int x=0; x<width; x++){
        PVector currCoord = new PVector(x, y);
        //this.zPos[x][y] = patternSingleWarp(currCoord);
        this.zPos[x][y] = patternDoubleWarp(currCoord);
      }
    }
    
    float zPosMin = minPerso(this.zPos);
    float zPosMax = maxPerso(this.zPos);
    
    for(int y=0; y<height; y++){
      for(int x=0; x<width; x++){
        this.hues[x][y] = map(this.zPos[x][y], zPosMin, zPosMax, 0, 127);
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
  
  float patternSingleWarp(PVector p){
    PVector _xOffset = new PVector(0, 0);
    PVector _yOffset = new PVector(5.2, 1.3);
    
    PVector q = new PVector(fbm(p.add(_xOffset)), fbm(p.add(_yOffset)));
        
    return fbm(p.add(q.mult(4)));
  }
  
  float patternDoubleWarp(PVector p){
    PVector _xOffset1 = new PVector(0, 0);
    PVector _yOffset1 = new PVector(5.2, 1.3);
    PVector _xOffset2 = new PVector(1.7, 9.2);
    PVector _yOffset2 = new PVector(8.3, 2.8);
    
    PVector q = new PVector(fbm(p.add(_xOffset1)), 
                            fbm(p.add(_yOffset1)));
    PVector r = new PVector(fbm(p.add(q.mult(4)).add(_xOffset2)),
                            fbm(p.add(q.mult(4)).add(_yOffset2)));
    
    return fbm(p.add(r.mult(4)));
  }
  
  float fbm(PVector coord){
    float pos = 0;
    
    for(int i=0; i<nbrLayers; i++){
      pos += this.amps.get(i) * noise(coord.x*noiseSpeed*this.freqs.get(i)+this.xOffset,
                                      coord.y*noiseSpeed*this.freqs.get(i)+this.yOffset);
    }
    
    return pos;
  }
}
