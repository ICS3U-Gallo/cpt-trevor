//global variables
float x = 150;
float y = 100;
float speed = 5;
int wait = 2000;
boolean reload;
long reloadStartTime;
float zombieSpeed = 1;
Boolean started = false;
PVector zombieDude;
PVector big;
float bigSpeed = 3;

boolean healthregen;
int score = 0;

Player p1 = new Player(150, 100, 500, 10);
Enemy e1 = new Enemy(500, 500, 1, 1);

void setup() {
  size(600,600);
  zombieDude = new PVector(random(width), random(height), 0.);
  big = new PVector(random(width), random(height), 0.);



  ellipseMode(CENTER);
  noStroke();
  fill(255, 0,0);
 
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
  
  text(p1.x, 20 ,60);
  text(p1.y ,20, 70);
  text(zombieDude.x, 20 ,100);
  text(zombieDude.y, 20 ,110);
  
  text(mouseX, 20 , 140);
  text(mouseY, 20, 150);
  text(score, 20, 200);
  
  // i didnt know how to make an object follow player so i copied most of this code https://forum.processing.org/one/topic/how-do-i-get-objects-to-follow-a-separate-moving-object.html
 
 // enemy list
  ellipse(zombieDude.x, zombieDude.y,15, 15);
  float angle = atan2(p1.y-zombieDude.y, p1.x-zombieDude.x);
  float newX = cos(angle)*zombieSpeed + zombieDude.x;
  float newY = sin(angle)*zombieSpeed + zombieDude.y;
  zombieDude.set(newX, newY, 0.);
  
  ellipse(big.x, big.y, 50, 50);
  float a2 = atan2(p1.y-big.y, p1.x-big.x);
  float x2 = cos(a2)*bigSpeed + big.x;
  float y2 = sin(a2)*bigSpeed + big.x;
  big.set(x2, y2, 0.);
  
 
 

  if(zombieDude.y - p1.x >= -0.1 && zombieDude.y - p1.y >= -0.1 && zombieDude.y - p1.y <= 1 && zombieDude.x - p1.x <= 1){
        p1.health--;
        
    p1.health=constrain(p1.health, 0, 500);
   } else if(zombieDude.x - p1.x >= -0.1 && zombieDude.y - p1.y >= -0.1 && zombieDude.y - p1.y <= 1 && zombieDude.x - p1.x >= 1){
        p1.health--;
        
        p1.health=constrain(p1.health, 0, 500);
  } else if(zombieDude.x - p1.x >= -0.1 && zombieDude.y - p1.y >= -0.1 && zombieDude.y - p1.y >= 1 && zombieDude.x - p1.x <= 1)
        p1.health--;
  
        p1.health=constrain(p1.health, 0, 500);
        
        
  
  
  }
   

//character display

  
void display() {
  fill(0,0,0);
    ellipse(p1.x, p1.y, 15, 15);
    if(x > width - 25){
      p1.x = width -25;
    }if(y > height){
      p1.y = height - 25;
    }if(p1.x < 0 + 25){
      p1.x = 0 + 25;
    }if(p1.y < 0 + 25){
      p1.y = 0 + 25;
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
    if (mousePressed == true && p1.maxAmmo > 0 && mouseX - zombieDude.x <= 3 && mouseY - zombieDude.y <= 3 ){
      score ++ ;
      zombieDude.x = 1000;
      zombieDude.y = 1000;
      
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
class Enemy {
    public float x;
    public float y;
    public int health;
    public int damage;
  
  public Enemy(float x, float y, int health, int damage) {
    this.x = x;
    this.y = y;
    this.health = health;
    this.damage = damage;
  }


}
  