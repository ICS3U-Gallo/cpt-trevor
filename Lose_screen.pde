PImage blood;
int buttonX, buttonY;
int buttonSize;
int buttonColor;
float x, y, w, h;

void setup(){
  
  fullScreen();
  blood = loadImage("usuck.png");
  buttonColor = color(192, 192, 192);
  x = 250;
  y = 550;
  w = 300;
  h = 100;

}
void draw(){
   
  background(0, 0, 225);
  
  image(blood, 0, 0, 1366, 768);
  fill(buttonColor);
  rect(x, y, w, h);
  fill(0, 100, 200);
  textSize(30);
  text("Menu", x+20, y+20, 400, 500);
}

void mousePressed() {
  if (mouseX >= x && mouseX <= x+w && mouseY >= y && mouseY <= y+h) {
    //write what you want to happen if you click button
  }
}
   