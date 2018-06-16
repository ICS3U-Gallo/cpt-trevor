//gun shot sound credit : http://soundbible.com/2095-Mossberg-500-Pump-Shotgun.html
// im using minim that i found on library
import ddf.minim.*;
 

//global variables
float x = 150;
float y = 100;
float speed = 5;
int wait = 2000;
boolean reload;
long reloadStartTime;

Boolean started = false;

float zombieSpeed = 1.2;
PVector zombieDude;
PVector big;
float bigSpeed = 6;
int bigH = 2;
PVector z;
float zSpeed = 1;
PVector z1;
float z1Speed = 1;
PVector z2; // fast zombie
float z2Speed = 3;
PVector  z3; // fast zombie 2
float z3Speed = 3;
PVector z4; //Health zombie
float z4Speed = 2;



boolean healthregen;
int score = 0;

AudioPlayer shot;
Minim minim;

Player p1 = new Player(300, 300, 500, 10);
Enemy e1 = new Enemy(500, 500, 1, 1);

void setup() {
  size(600,600);
  // Pvector List
  zombieDude = new PVector(random(width), random(height), 0.);
  big = new PVector(20000, 20000, 0.);
  z = new PVector(-1000,1000 , 0);
  z1 = new PVector(2000, -2000, 0);
  z2 = new PVector(5000, 5000, 0);
  z3 = new PVector(-10000, -10000, 0); 
  z4 = new PVector(7000, 7000, 0);


  //sound
  
  minim = new Minim(this);
  shot = minim.loadFile("shot.mav");


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
 
 // small zombie
  fill(0,204, 0);
  ellipse(zombieDude.x, zombieDude.y,15, 15);
  float angle = atan2(p1.y-zombieDude.y, p1.x-zombieDude.x);
  float newX = cos(angle)*zombieSpeed + zombieDude.x;
  float newY = sin(angle)*zombieSpeed + zombieDude.y;
  zombieDude.set(newX, newY, 0.);
  
  //zombie 
  fill(0,204, 0);
  ellipse(z.x, z.y,15, 15);
  float angle1 = atan2(p1.y-z.y, p1.x-z.x);
  float newX1 = cos(angle1)*zSpeed + z.x;
  float newY1 = sin(angle1)*zSpeed + z.y;
  z.set(newX1, newY1, 0.);
  
  //z1
  fill(0,204, 0);
  ellipse(z1.x, z1.y,15, 15);
  float angle2 = atan2(p1.y-z1.y, p1.x-z1.x);
  float newX2 = cos(angle2)*zSpeed + z1.x;
  float newY2 = sin(angle2)*zSpeed + z1.y;
  z1.set(newX2, newY2, 0.);
  
  
  //big rusher zombie
  fill(255,102, 0);
  ellipse(big.x, big.y, 35, 35);
  float a2 = atan2(p1.y-big.y, p1.x-big.x);
  float x2 = cos(a2)*bigSpeed + big.x;
  float y2 = sin(a2)*bigSpeed + big.x;
  big.set(x2, y2, 0.);
  
  //fast zombie (z2)
  fill(0,255,255);
  ellipse(z2.x, z2.y,18, 18);
  float angleF = atan2(p1.y-z2.y, p1.x-z2.x);
  float newXF = cos(angleF)*z2Speed + z2.x;
  float newYF = sin(angleF)*z2Speed + z2.y;
  z2.set(newXF, newYF, 0.);
  
  //fast zombie 2 (z3)
  fill(0,255,255);
  ellipse(z3.x, z3.y,18, 18);
  float angle3 = atan2(p1.y-z3.y, p1.x-z3.x);
  float newX3 = cos(angle3)*z3Speed + z3.x;
  float newY3 = sin(angle3)*z3Speed + z3.y;
  z3.set(newX3, newY3, 0.);
  
  //Health zombie (z4)
  
  fill(255,0,0);
  ellipse(z4.x, z4.y,20, 20);
  float angle4 = atan2(p1.y-z4.y, p1.x-z4.x);
  float newX4 = cos(angle4)*z4Speed + z4.x;
  float newY4 = sin(angle4)*z4Speed + z4.y;
  z4.set(newX4, newY4, 0.);
  
  
     
 
 
//zombie dude
  if(zombieDude.x - p1.x >= -0.1 && zombieDude.y - p1.y >= -0.1 && zombieDude.y - p1.y <= 1 && zombieDude.x - p1.x <= 1){
        p1.health--;
        
    p1.health=constrain(p1.health, 0, 500);
   } else if(zombieDude.x - p1.x >= -0.1 && zombieDude.y - p1.y >= -0.1 && zombieDude.y - p1.y <= 1 && zombieDude.x - p1.x >= 1){
        p1.health--;
        
        p1.health=constrain(p1.health, 0, 500);
  } else if(zombieDude.x - p1.x >= -0.1 && zombieDude.y - p1.y >= -0.1 && zombieDude.y - p1.y >= 1 && zombieDude.x - p1.x <= 1)
        p1.health--;
  
        p1.health=constrain(p1.health, 0, 500);
        
//zombie
  if(z.x - p1.x >= -0.1 && z.y - p1.y >= -0.1 && z.y - p1.y <= 1 && z.x - p1.x <= 1){
        p1.health--;
        
    p1.health=constrain(p1.health, 0, 500);
   } else if(z.x - p1.x >= -0.1 && z.y - p1.y >= -0.1 && z.y - p1.y <= 1 && z.x - p1.x >= 1){
        p1.health--;
        
        p1.health=constrain(p1.health, 0, 500);
  } else if(z.x - p1.x >= -0.1 && z.y - p1.y >= -0.1 && z.y - p1.y >= 1 && z.x - p1.x <= 1)
        p1.health--;
  
        p1.health=constrain(p1.health, 0, 500);
        
// z1
  if(z1.x - p1.x >= -0.1 && z1.y - p1.y >= -0.1 && z1.y - p1.y <= 1 && z1.x - p1.x <= 1){
        p1.health--;
        
    p1.health=constrain(p1.health, 0, 500);
   } else if(z1.x - p1.x >= -0.1 && z1.y - p1.y >= -0.1 && z1.y - p1.y <= 1 && z1.x - p1.x >= 1){
        p1.health--;
        
        p1.health=constrain(p1.health, 0, 500);
  } else if(z1.x - p1.x >= -0.1 && z1.y - p1.y >= -0.1 && z1.y - p1.y >= 1 && z1.x - p1.x <= 1)
        p1.health--;
  
        p1.health=constrain(p1.health, 0, 500);
// z2 (fast boy)

 if(z2.x - p1.x >= -0.1 && z2.y - p1.y >= -0.1 && z2.y - p1.y <= 1 && z2.x - p1.x <= 1){
        p1.health--;
        
    p1.health=constrain(p1.health, 0, 500);
   } else if(z2.x - p1.x >= -0.1 && z2.y - p1.y >= -0.1 && z2.y - p1.y <= 1 && z2.x - p1.x >= 1){
        p1.health--;
        
        p1.health=constrain(p1.health, 0, 500);
  } else if(z2.x - p1.x >= -0.1 && z2.y - p1.y >= -0.1 && z2.y - p1.y >= 1 && z2.x - p1.x <= 1)
        p1.health--;
  
        p1.health=constrain(p1.health, 0, 500);
        
// fast boy 2 (z3)
        
   if(z3.x - p1.x >= -0.1 && z3.y - p1.y >= -0.1 && z3.y - p1.y <= 1 && z3.x - p1.x <= 1){
        p1.health--;
        
    p1.health=constrain(p1.health, 0, 500);
   } else if(z3.x - p1.x >= -0.1 && z3.y - p1.y >= -0.1 && z3.y - p1.y <= 1 && z3.x - p1.x >= 1){
        p1.health--;
        
        p1.health=constrain(p1.health, 0, 500);
  } else if(z3.x - p1.x >= -0.1 && z3.y - p1.y >= -0.1 && z3.y - p1.y >= 1 && z3.x - p1.x <= 1)
        p1.health--;
  
        p1.health=constrain(p1.health, 0, 500);
        
// health boy (z4)

if(z4.x - p1.x >= -0.1 && z4.y - p1.y >= -0.1 && z4.y - p1.y <= 1 && z4.x - p1.x <= 1){
        p1.health--;
        
    p1.health=constrain(p1.health, 0, 500);
   } else if(z4.x - p1.x >= -0.1 && z4.y - p1.y >= -0.1 && z4.y - p1.y <= 1 && z4.x - p1.x >= 1){
        p1.health--;
        
        p1.health=constrain(p1.health, 0, 500);
  } else if(z4.x - p1.x >= -0.1 && z4.y - p1.y >= -0.1 && z4.y - p1.y >= 1 && z4.x - p1.x <= 1)
        p1.health--;
  
        p1.health=constrain(p1.health, 0, 500);
        
//big slam guy

  if(big.x - p1.x >= -0.1 && big.y - p1.y >= -0.1 && big.y - p1.y <= 1 && big.x - p1.x <= 1){
        p1.health--;
        
    p1.health=constrain(p1.health, 0, 500);
   } else if(big.x - p1.x >= -0.1 && big.y - p1.y >= -0.1 && big.y - p1.y <= 1 && big.x - p1.x >= 1){
        p1.health--;
        
        p1.health=constrain(p1.health, 0, 500);
  } else if(big.x - p1.x >= -0.1 && big.y - p1.y >= -0.1 && big.y - p1.y >= 1 && big.x - p1.x <= 1)
        p1.health--  ;
  
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
    
   
      
    
    

    //reload system
if (reload) {
  if (millis() > (reloadStartTime + wait)) {
    p1.maxAmmo= 10;
    reload = false;
  }
  
}


}
void keyPressed() {//movement (wasd) and reload
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
  shot.play();
  shot.rewind();
  
  
  
  
  
//zombieDude HITBOX
    if (mousePressed == true && p1.maxAmmo > 0 && mouseX-zombieDude.x >= -4 && mouseY-zombieDude.y >= -4 && mouseY-zombieDude.y <= 4 && mouseX-zombieDude.x <= 4 ){
      score ++ ;
      zombieDude.x = 1000;
      zombieDude.y = 1000;
    }else if(mousePressed == true && p1.maxAmmo >0 && mouseX-zombieDude.x >= -4 && mouseY-zombieDude.y >= -4 && mouseY-zombieDude.y <= 4 && mouseX-zombieDude.x >= 4){
      score ++ ;
      zombieDude.x = 1000;
      zombieDude.y = -1000; 
    }
    
//zombie hitbox
   
   if (mousePressed == true && p1.maxAmmo > 0 && mouseX-z.x >= -4 && mouseY-z.y >= -4 && mouseY-z.y <= 4 && mouseX-z.x <= 4 ){
      score ++ ;
      z.x = 900;
      z.y = -700;
    }else if(mousePressed == true && p1.maxAmmo >0 && mouseX-z.x >= -4 && mouseY-z.y >= -4 && mouseY-z.y <= 4 && mouseX-z.x >= 4){
      score ++ ;
      z.x = 1000;
      z.y = 800; 
    }
//z1 hitbox

    if (mousePressed == true && p1.maxAmmo > 0 && mouseX-z1.x >= -4 && mouseY-z1.y >= -4 && mouseY-z1.y <= 4 && mouseX-z1.x <= 4 ){
      score ++ ;
      z1.x = -700;
      z1.y = 700;
    }else if(mousePressed == true && p1.maxAmmo >0 && mouseX-z1.x >= -4 && mouseY-z1.y >= -4 && mouseY-z1.y <= 4 && mouseX-z1.x >= 4){
      score ++ ;
      z1.x = -800;
      z1.y = - 800; 
    }
    
//z2 (fastBoy) hitBox

if (mousePressed == true && p1.maxAmmo > 0 && mouseX-z2.x >= -4 && mouseY-z2.y >= -4 && mouseY-z2.y <= 4 && mouseX-z2.x <= 4 ){
      score ++ ;
      z2.x = -5000;
      z2.y = 5000;
    }else if(mousePressed == true && p1.maxAmmo >0 && mouseX-z2.x >= -4 && mouseY-z2.y >= -4 && mouseY-z2.y <= 4 && mouseX-z2.x >= 4){
      score ++ ;
      z2.x = 4000;
      z2.y = -4000; 
       }
       
//z3 (fast BOY 2) hitbox

if (mousePressed == true && p1.maxAmmo > 0 && mouseX-z3.x >= -4 && mouseY-z3.y >= -4 && mouseY-z3.y <= 4 && mouseX-z3.x <= 4 ){
      score ++ ;
      z3.x = 10000;
      z3.y = -10000;
    }else if(mousePressed == true && p1.maxAmmo >0 && mouseX-z3.x >= -4 && mouseY-z3.y >= -4 && mouseY-z3.y <= 4 && mouseX-z3.x >= 4){
      score ++ ;
      z3.x = 10000;
      z3.y = 10000; 
    }
//z4 (health boy) hitbox

if (mousePressed == true && p1.maxAmmo > 0 && mouseX-z4.x >= -4 && mouseY-z4.y >= -4 && mouseY-z4.y <= 4 && mouseX-z4.x <= 4 ){
      score ++ ;
      p1.health += 100;
      z4.x = -7000;
      z4.y = -7000;
    }else if(mousePressed == true && p1.maxAmmo >0 && mouseX-z4.x >= -4 && mouseY-z4.y >= -4 && mouseY-z4.y <= 4 && mouseX-z4.x >= 4){
      score ++ ;
      p1.health += 100;
      z4.x = 7000;
      z4.y = 7000; 
    }

   
      
      
//Slammer HITBOX
     if (mousePressed == true && p1.maxAmmo > 0 && mouseX-big.x >= -4 && mouseY-big.y >= -4 && mouseY-big.y <= 4 && mouseX-big.x <= 4 ){
      bigH--;
    }else if(mousePressed == true && p1.maxAmmo >0 && mouseX-big.x >= -4 && mouseY-big.y >= -4 && mouseY-big.y <= 4 && mouseX-big.x >= 4){
      bigH--;
    }
    
    if(bigH == 0){
     score ++;
     big.x = 4000;
     big.y = 4000;
     bigH ++;
     bigH ++;
  }
  }
    
   
      
      
      {
      
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
  
