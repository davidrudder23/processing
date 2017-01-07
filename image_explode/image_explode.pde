class Dot {
  
  float x = 0;
  float y = 0;
  
  float originX = 0;
  float originY = 0;
  
  color dotColor;
  int size = 3;
  
  int width;
  int height;
  
  float maxDirection = 8;
  float directionX = -1;
  float directionY = -1;

  Dot(float x, float y, int width, int height) {
    this.x = x;
    this.y = y;
    this.originX = x;
    this.originY = y;
    this.width = width;
    this.height = height;
    
  }
  
  void setColor (int red, int green, int blue, int alpha) {
    dotColor = color(red, green, blue, alpha);
  }
  
  void setDirection(float x, float y) {
    this.directionX = x*maxDirection;
    this.directionY = y*maxDirection;
  }
  
  void move() {
    if ((x<=0) || (x>=width)) {
      directionX = directionX * -1;
    }
    
    if ((y<=0) || (y>=height)) {
      directionY = directionY * -1;
    }
    
    x = x+directionX;
    y = y+directionY;
    
    // direct back toward origin
    float increment;
    if (x>originX) {
      increment = (x-originX)/1000;
      directionX -= increment;
    }
    if (x<originX) {
      increment = (originX-x)/1000;
      directionX += increment;
    }
    
    if (y>originY) {
      increment = (y-originY)/1000;
      directionY -= increment;
    }
    if (y<originY) {
      increment = (originY-y)/1000;
      directionY += increment;
    }
    
    directionX *=0.99;
    directionY *=0.99;
    
    
  }
  
  void draw() {
    noStroke();
    
    fill(dotColor);
    ellipse(x, y, size, size);
  }
}

int width = 640;
int height = 480;

Dot[] dots;

void setup() {
  size(640, 480);
  
  //PImage img = loadImage("http://www.dsstpublicschools.org/sites/default/files/styles/logo_style/public/school_logos/DSST_byers_FalconsRGB.png");
  PImage img = loadImage("http://www.clipartlord.com/wp-content/uploads/2015/03/explosion4.png");
  
  if (img.width>96) img.resize(96,0);
  if (img.height>96) img.resize(0,96);
  
  img.loadPixels();

  int offsetX = (int)((width-img.width)/2);
  int offsetY = (int)((height-img.height)/2);
  

  dots = new Dot[img.width*img.height];
  println("img width="+img.width+" height="+img.height+" total="+dots.length);
  for (int x = 0; x < img.width; x++) {
    for (int y = 0; y < img.height; y++) {
      int index = y*img.width+x;
      Dot dot = new Dot(x+offsetX,y+offsetY, width, height);
      dot.setDirection(random(2)-1, random(2)-1);
      dot.setColor((int)red(img.pixels[index]), (int)green(img.pixels[index]), (int)blue(img.pixels[index]), (int)alpha(img.pixels[index]));
      dots[index] = dot;
    }
  }
  
  image(img, offsetX, offsetY);
  
}

boolean firstDraw = true;
void draw() {
  if (firstDraw) {
    delay(1000);
    firstDraw = false;
  }
  
  fill(255,255,255,10);
  rect(0,0,width-1, height-1);
  for (int x = 0; x < dots.length; x++) {
    dots[x].move();
    //dots[x].changeColor();
  }
  for (int x = 0; x < dots.length; x++) {
    dots[x].draw();
  }
}