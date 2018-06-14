PImage blood;
int buttonX, buttonY;
int buttonSize;
int buttonColor;
float x, y, w, h;

import ddf.minim.*;

AudioPlayer player;
Minim minim;

void setup(){
   minim = new Minim(this);
  player = minim.loadFile("Codzombies.mp3", 2048);
  player.play();
  
  fullScreen();
  blood = loadImage("blood.png");
  buttonColor = color(44, 3, 3);
  x = 200;
  y = 400;
  w = 300;
  h = 300;
}
void draw(){
   player.close();
  minim.stop();
  super.stop();
   
  background(0, 0, 225);
  
  image(blood, 0, 0, 1366, 768);
  fill(buttonColor);
  rect(x, y, w, h);
}

void mousePressed() {
  if (mouseX >= x && mouseX <= x+w && mouseY >= y && mouseY <= y+h) {
    //write what you want to happen if you click button
  }
}
   