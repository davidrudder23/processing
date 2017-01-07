class Dot {
  
  float x = 0;
  float y = 0;
  
  color dotColor;
  int size = 3;
  
  int width;
  int height;
  
  float maxDirection = 2.8;
  float directionX = -1;
  float directionY = -1;

  Dot(float x, float y, int width, int height) {
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
    
  }
  
  void setColor (int red, int green, int blue) {
    dotColor = color(red, green, blue, 255);
  }
  
  void setRandomColor() {
    dotColor = color((int)random(256),(int)random(256),(int)random(256),(int)random(256));
  }
  
  void changeColor() {
    int red = (int)(red(dotColor)+random(1,10)-5);
    if (red<0) red=0;
    if (red>255) red=255;
    
    int green = (int)(green(dotColor)+random(1,10)-5);
    if (green<0) green=0;
    if (green>255) green=255;

    int blue = (int)(blue(dotColor)+random(1,10)-5);
    if (blue<0) blue=0;
    if (blue>255) blue=255;

    int alpha = (int)(alpha(dotColor)+random(10)-5);
    if (alpha<128) alpha=128;
    if (alpha>255) alpha=255;

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
  
  PImage img = loadImage("http://www.dsstpublicschools.org/sites/default/files/styles/logo_style/public/school_logos/DSST_byers_FalconsRGB.png");
  //PImage img = loadImage("http://images6.fanpop.com/image/quiz/964000/964479_1357321295873_50.jpg");
  
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
      dot.setColor((int)red(img.pixels[index]), (int)green(img.pixels[index]), (int)blue(img.pixels[index]));
      dots[index] = dot;
    }
  }
  
    image(img, offsetX, offsetY);
  
}

void draw() {
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