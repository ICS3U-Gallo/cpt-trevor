//global variables
float x = 150;
float y = 100;
float speed = 5;
int wait = 2000;
boolean reload;
long reloadStartTime;

Player p1 = new Player(150, 100, 10, 10);

void setup() {
  size(600,600);
  
}

void draw() {
  background(255);
  display();
  
  fill(255, 0, 0, 100);
  ellipse(mouseX, mouseY, 10, 10); //aim
  
  text("Health", 20, 10);
  text(p1.health, 20 ,20);
  text("Ammo", 20, 30);
  text(p1.maxAmmo, 20, 40);
    
  

//character display
}  
  
void display() {
  fill(0,0,0);
    ellipse(p1.x, p1.y, 50, 50);
    if(x > width - 25){
      p1.x = width -25;
    }if(y > height){
      p1.y = height - 25;
    }
    
if (reload) {
  if (millis() > (reloadStartTime + wait)) {
    p1.maxAmmo= 10;
    reload = false;
  }
  
}
    
}
void keyPressed() {
   if(key == 'r') {
       reload = true;
       reloadStartTime = millis();
    }
  if(key == 'w') {
  p1.y = p1.y - speed;
}
  if(key == 's') {
  p1.y = p1.y + speed;
}
  if(key == 'a') {
  p1.x = p1.x -speed;
}
  if(key == 'd') {
    p1.x = p1.x +speed;
}
 
  
}
  void mousePressed() {
    if (mousePressed == true) {
      p1.maxAmmo -= 1;
    }
    if (p1.maxAmmo < 0) {
      p1.maxAmmo = 0;
  }
  }
class Player {
  public float x;
  public float y;
  public int health;
  public int maxAmmo;

  public Player(float x, float y, int health, int maxAmmo) {
    this.x = x;
    this.y = y;
    this.health = health;
    this.maxAmmo = maxAmmo;
  } 

}