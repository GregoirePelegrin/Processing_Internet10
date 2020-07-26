float noiseSpeed = 0.01;
String imageChoice = "perlin";

FBMImage fbmImage;
int nbrLayers;
FloatList amplitudes;
FloatList frequencies;
float FBMLacunarity = 2;
float FBMPersistance = 0.5;

PerlinImage pImage;

PerlinLayersImage plImage;

void setup() {
  //fullScreen();
  size(500, 500);
  frameRate(30);
  colorMode(HSB);

  nbrLayers = 10;
  amplitudes = new FloatList();
  frequencies = new FloatList();
  for (int i=0; i<nbrLayers; i++) {
    amplitudes.append(pow(FBMPersistance, i));
    frequencies.append(pow(FBMLacunarity, i));
  }
  fbmImage = new FBMImage(amplitudes, frequencies);
  
  pImage = new PerlinImage();
  
  plImage = new PerlinLayersImage(amplitudes, frequencies);
}

void draw() {
  if (fbmImage.updated && imageChoice == "fbm") {
    background(0);
    fbmImage.display();
    println("FBM displayed");
  } else if (pImage.updated && imageChoice == "perlin") {
    background(0);
    pImage.display();
    println("Perlin displayed");
  } else if (plImage.updated && imageChoice == "perlinLayers"){
    background(0);
    plImage.display();
    println("PerlinLayers displayed");
  }
}

void mousePressed() {
  if (mouseButton == LEFT) {
    print("Updating image: ");
    if (imageChoice == "fbm") {
      fbmImage.update();
      println("FBM");
    } else if (imageChoice == "perlin") {
      pImage.update();
      println("Perlin");
    } else if (imageChoice == "perlinLayers"){
      plImage.update();
      println("PerlinLayers");
    }
  } else if (mouseButton == RIGHT) {
    print("Changing mode: ");
    if (imageChoice == "fbm") {
      imageChoice = "perlin";
      pImage.updated = true;
      println("to Perlin");
    } else if (imageChoice == "perlin") {
      imageChoice = "perlinLayers";
      plImage.updated = true;
      println("to PerlinLayers");
    } else if (imageChoice == "perlinLayers") {
      imageChoice = "fbm";
      fbmImage.updated = true;
      println("to FBM");
    }
  }
}

float minPerso(float a[][]) {
  float min = a[0][0];

  for (int i=0; i<a.length; i++) {
    for (int j=0; j<a[0].length; j++) {
      if (a[i][j] < min) {
        min = a[i][j];
      }
    }
  }

  return min;
}

float maxPerso(float a[][]) {
  float max = a[0][0];

  for (int i=0; i<a.length; i++) {
    for (int j=0; j<a[0].length; j++) {
      if (a[i][j] > max) {
        max = a[i][j];
      }
    }
  }

  return max;
}
