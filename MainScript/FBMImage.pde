// FBM stands for Fractional Brownian Motion, only is a superposition of multiple layers of Perlin noise (amplitude --, frequency ++)

class FBMImage{
  FloatList amps;
  FloatList freqs;
  
  float hues[][];
  boolean updated;
  
  FBMImage(){
    this.hues = new float[width][height];
    
    this.update();
  }
  
  void update(){
    this.updated = true;
    
    
  }
  
  void display(){
    this.updated = false;
    
    for(int y=0; y<height; y++){
      for(int x=0; x<width; x++){
        stroke(this.hues[x][y], 255, 255, 100);
        point(x, y);
      }
    }
  }
}
