import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

PImage zombiePhoto; //image from https://www.pinterest.com/pin/220746819207739812/

// sound from:http://soundbible.com/2095-Mossberg-500-Pump-Shotgun.html
//sound reload http://soundbible.com/1996-Shotgun-Reload-Old.html
//song : https://www.youtube.com/watch?v=H-kA3UtBj4M
//song 2:https://www.youtube.com/watch?v=30aGtXWo0SU
Minim minim;
Minim minim2;
AudioPlayer shot;
AudioInput input;
AudioPlayer reloadSound;
AudioInput input2;
AudioPlayer click;
AudioPlayer soul;
AudioPlayer rap;

 
// variables
float speed = 5;
int wait = 2000;
boolean reload;
long reloadStartTime;
Boolean started = false;

//enemies
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
PVector z5; //BOSS
float z5Speed = 1.5;
int z5H = 5;



boolean healthregen;
int score = 0;

float maxHealth = 500;
float rectWidth = 100;


int intro = 0;
int menu = 1;
int play= 2;
int over= 3;
int mode = 0; // 0 is main menu, 1 means play, 2 means game over

Player p1 = new Player(300, 300, 500, 10);


void setup() {
  size(600,600);
  
  zombiePhoto = loadImage("zombiePhoto.jpg");
  
  minim = new Minim(this);
  shot = minim.loadFile("shot.mp3");
  input = minim.getLineIn();
  
  minim2 = new Minim(this);
  reloadSound = minim2.loadFile("reload.mp3");
  input2 = minim2.getLineIn();
  
  click = minim.loadFile("click.mp3");
  
  soul = minim.loadFile("soul.mp3");
  
  rap = minim.loadFile("rap.mp3");
  
  // Pvector List
  zombieDude = new PVector(random(width), random(height), 0.);
  big = new PVector(20000, 20000, 0.);
  z = new PVector(-1000,1000 , 0);
  z1 = new PVector(2000, -2000, 0);
  z2 = new PVector(5000, 5000, 0);
  z3 = new PVector(-10000, -10000, 0); 
  z4 = new PVector(7000, 7000, 0);
  z5 = new PVector(5500,5500, 0);

 
  

  ellipseMode(CENTER);
  noStroke();
  fill(255, 0,0);
 
}
  

void draw() {
  

  background(176,196,222);
  
  if(mode==intro){
    doIntroMode();
  
  } else if (mode == menu){
    doMenuMode();
    
  } else if (mode == play) {
  display();
  //health bar
  if (p1.health < 100){
    fill(255,0,0);
  }else if (p1.health < 300){
    fill(255, 200, 0);
  }else{
    fill(0,255,0);
  }
  
  noStroke();
  float drawWidth = (p1.health / maxHealth)*rectWidth;
  rect(10, 10, drawWidth, 25);
  
  stroke(0);
  noFill();
  rect(10, 10, rectWidth, 25);
  
  
  //aim
  fill(255, 0, 0, 100);
  ellipse(mouseX, mouseY, 10, 10); 
  
  
  
  textSize(15);{
    fill(0,102,153);
    text("Ammo", 10, 60);
    text(p1.maxAmmo , 10, 80);
    text("/10",28,80);}
  

    text("Score:", 520 ,20);
    text(score, 576, 20);
  
  
  text("Boss", z5.x - 20, z5.y -20);
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
  
  //Boss (z5)
  
  fill(107,142,35);
  ellipse(z5.x, z5.y,40, 40);
  float angle5 = atan2(p1.y-z5.y, p1.x-z5.x);
  float newX5 = cos(angle5)*z5Speed + z5.x;
  float newY5 = sin(angle5)*z5Speed + z5.y;
  z5.set(newX5, newY5, 0.);
  
  
     
 
 
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
        
//boss man (z5)

if(z5.x - p1.x >= -0.1 && z5.y - p1.y >= -0.1 && z5.y - p1.y <= 1 && z5.x - p1.x <= 1){
        p1.health--;
        
    p1.health=constrain(p1.health, 0, 500);
   } else if(z5.x - p1.x >= -0.1 && z5.y - p1.y >= -0.1 && z5.y - p1.y <= 1 && z5.x - p1.x >= 1){
        p1.health--;
        
        p1.health=constrain(p1.health, 0, 500);
  } else if(z5.x - p1.x >= -0.1 && z5.y - p1.y >= -0.1 && z5.y - p1.y >= 1 && z5.x - p1.x <= 1)
        p1.health--;
  
        p1.health=constrain(p1.health, 0, 500);
        
        if(p1.health == 0) mode = 3;
        
        } else if (mode == over) {
          doGameOver();
      }
}

public void doIntroMode() {
  background(zombiePhoto);
  size(600,600);
  fill(240,255,240);
  stroke(0);
  textSize(32);
  String introText = "Operation Outburst";
  text(introText, 150, 200);
  textSize(20);
  fill(240,255,240);
  text("Press 'space' to Continue" , 185, 300);
  
  if (keyPressed) {
    if (key == ' ') mode = 1;
}
}
public void doMenuMode() {
  fill(0);
  text("Operation Briefing: ...clear out as much infected as you can.", 10,50);
  textSize(15);
  text("...Civilian evacuation in progress, you will be escorted to a deserted ", 10 , 70);
  text("area to create a diversion and drive the infected away from the city. Good luck.",10, 90);
  
  
  text("Given Tools: AA12 (Automatic Shotgun)", 10, 140);
  
  text("Types of Infected:" , 10 , 160);
  
  text("Typical Infected: Medium speed, Easy to fight off-" , 10 , 190);
  text("'Fat Boys': Fast(Tends to Rush), Medium threat-", 10, 240);
  text("'Runners': High Speed, High Threat Kill ASAP  -",10, 320);
  text("'Angel': Releases chemicals that heal you   -",10, 370);
  fill(0,204, 0);
  ellipse(400, 185 ,15, 15);
  fill(255,102, 0);
  ellipse(400, 240, 35, 35);
  fill(0,255,255);
  ellipse(400, 315,18, 18);
  fill(255,0,0);
  ellipse(400, 365,20, 20);
  
  text("Controls: w- up, a- left, s-down, d-right, r-reload, mouseclick- shoot", 10 , 500);
  text("'g'-groove mode 'h'-rap mode ",10, 525);
  text("Press 'p' to Begin", 10 , 550);
  
  
  
  
  
  if (keyPressed) {
    if (key == 'p') mode = 2;
  
}
}

public void doGameOver() {
  background(169,169,169);
  textSize(40);
  fill(255,0,0);
  String overText = "GAME OVER!";
  text(overText, 220 , 100);
  textSize(32);
  fill(0);
  text("SCORE:",220, 300);
  text(score, 330 , 300);
 
  
  if (keyPressed) {
    if (key == 'k') mode = 0;
  
}
}


   

//character display

  
void display() {
  fill(240,255,240);
    ellipse(p1.x, p1.y, 15, 15);
    if(p1.x == 0){
      p1.x = 25;
    }if(p1.y == 0){
      p1.y = 25;
    }if(p1.x == 600){
      p1.x =575;
    }if(p1.y == 600){
      p1.y = 575;
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
   if(key == 'r' && mode==2) {
       reload = true;
       reloadStartTime = millis();
       reloadSound.play();
       reloadSound = minim.loadFile("reload.mp3");
       
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
  if(key == 'g') {
    soul.play();
  }
  if(key == 'h') {
    rap.play();
  }
 
  
}
  void mousePressed() {
    
    if(mode == 2 && p1.maxAmmo > 0 && mousePressed== true){
    shot.play();
    shot = minim.loadFile("shot.mp3");}
    
    if(mode==2 && p1.maxAmmo==0 &&mousePressed==true){
      click.play();
      click = minim.loadFile("click.mp3");}
    
    if (mousePressed == true && mode == 2) {
      p1.maxAmmo -= 1;
    }
    if (p1.maxAmmo < 0) {
      p1.maxAmmo = 0;
  }

  


  
  
  
  
  
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
      z4.x = -4000; //adrian lee did nOThgin
      z4.y = -4000;
    }else if(mousePressed == true && p1.maxAmmo >0 && mouseX-z4.x >= -4 && mouseY-z4.y >= -4 && mouseY-z4.y <= 4 && mouseX-z4.x >= 4){
      score ++ ;
      p1.health += 100;
      z4.x = 4000;
      z4.y = 4000; 
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
  
//Boss
if (mousePressed == true && p1.maxAmmo > 0 && mouseX-z5.x >= -4 && mouseY-z5.y >= -4 && mouseY-z5.y <= 4 && mouseX-z5.x <= 4 ){
      z5H--;
    }else if(mousePressed == true && p1.maxAmmo >0 && mouseX-z5.x >= -4 && mouseY-z5.y >= -4 && mouseY-z5.y <= 4 && mouseX-z5.x >= 4){
      z5H--;
    }
    
    if(z5H == 0){
     score += 10;
     z5.x = 10000;
     z5.y = 10000;
     z5H += 5;
    }
  }
    
   
      
      
     void mouseReleased() {
       shot.close();
       shot = minim.loadFile("shot.mp3");
      
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
