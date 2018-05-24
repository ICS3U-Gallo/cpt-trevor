//global variables
float x = 150;
float y = 100;
float speed = 5;

void setup() {
  size(600,600);
  
}

void draw() {
  background(255);
  display();

//character display
}  
  
void display() {
  fill(0,0,0);
    ellipse(x, y, 50, 50);
    if(x > width - 25){
      x = width;
    }if(y > height){
      y = height - 25;
    }
    
}
void keyPressed() {
  if(key == 'w') {
  y = y - speed;
}
  if(key == 's') {
  y = y + speed;
}
  if(key == 'a') {
  x = x -speed;
}
  if(key == 'd') {
    x = x +speed;
  }
}