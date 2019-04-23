


PImage bg, soil,title,gameover;
PImage groundHog,soldier,life1,life2,life3,cabbage;
PImage restartHover,restartNormal,startHover,startNormal;
PImage hogUp,hogDown,hogRight,hogLeft;

final int GAME_START=0;
final int GAME_RUN=1;
final int GAME_OVER=2;
int gameState=GAME_START;

final int LIFE_2=3;
final int LIFE_3=4;
final int LIFE_1=5;
final int LIFE_0=6;
int lifeScore=LIFE_2;

/*
boolean upPressed,downPressed,rightPressed,leftPressed=false;
*/

//life
int life1X=10;
int life2X=80;
int life3X=150;
int lifeY=10;
int lifeSize=50;
//grass
int grassHeight=15;
//soldier
int soldierX=0;
int soldierY=160;
int soldierSpeed=5;
//hog
int hogX=320;
int hogY=80;
int hogDistance=80;
//cabbage
int cabbageX,cabbageY;
//
float timeSpeed=3;


void setup() {
	size(640, 480, P2D);

	//image
  bg= loadImage("img/bg.jpg");
  soil= loadImage("img/soil.png");
  title=loadImage("img/title.jpg");
  gameover=loadImage("img/gameover.jpg");
  groundHog= loadImage("img/groundhogIdle.png");
  soldier= loadImage("img/soldier.png");
  cabbage= loadImage("img/cabbage.png");
  life1= loadImage("img/life.png");
  life2= loadImage("img/life.png");
  life3= loadImage("img/life.png");  
  restartHover=loadImage("img/restartHovered.png");
  restartNormal=loadImage("img/restartNormal.png");
  startHover=loadImage("img/startHovered.png");
  startNormal=loadImage("img/startNormal.png");
  hogDown=loadImage("img/groundhogDown.png");
  hogRight=loadImage("img/groundhogRight.png");
  hogLeft=loadImage("img/groundhogLeft.png");
  //soldier
 soldierY= 160+80*floor(random(4));
  //cabbage
 cabbageX=80*floor(random(8));
 cabbageY=160+80*floor(random(4));
 
 frameRate(60);
}

void draw() {
	// Switch Game State
  switch(gameState){
    // Game Start
      case GAME_START:
      image(title,0,0);
      if(mouseX>248&&mouseX<248+144&&mouseY>360&&mouseY<360+60){
          image(startHover,248,360);
          if(mousePressed){
              gameState=GAME_RUN;              
          }
      }else{
          image(startNormal,248,360);
      }
      break;

		// Game Run
      case GAME_RUN:
     
      imageMode(CORNER);
      image(bg,0,0);
      image(soil,0,160);        
      image(cabbage,cabbageX,cabbageY);
     //soldier
      image(soldier,soldierX-80,soldierY);
      soldierX+=soldierSpeed;
      soldierX %= 720;     
     //draw sun
      stroke(255,255,0);
      strokeWeight(5);
      fill(253,184,19);
      ellipse(590,50,120,120);
     //grass
      noStroke();
      colorMode(RGB);
      fill(124,204,25);
      rectMode(CORNER);
      rect(0,160-grassHeight,640,15);      
      //goundHog      
      image(groundHog,hogX,hogY);
     
      //keycode        
      /*
          if(downPressed){
            hogY+=hogDistance;
            if(hogY>height-80) hogY=height-80;
          }
          if(upPressed){
            hogY-=hogDistance;
            if(hogY<80) hogY=80;
          }
          if(rightPressed){
            hogX+=hogDistance;
            if(hogX>width-80) hogX=width-80;           
          }
          if(leftPressed){
            hogX-=hogDistance;
            if(hogX<0) hogX=0;            
          }
         */ 
         
        //life score 
           switch(lifeScore){         
           case LIFE_2:             
              image(life1,life1X,lifeY,lifeSize,lifeSize);
              image(life2,life2X,lifeY,lifeSize,lifeSize);                            
              if(hogX<soldierX+80&&hogX+80>soldierX&&hogY<soldierY+80&&hogY+80>soldierY){
                  lifeScore=LIFE_1;  
                  hogX=320;
                  hogY=80;
               } 
              if(hogX<cabbageX+80&&hogX+80>cabbageX&&hogY<cabbageY+80&&hogY+80>cabbageY){
                  lifeScore=LIFE_3;
                  cabbageX=width+10;
                  cabbageY=height+10;
              }
               
             break;     
             
           case LIFE_3: 
              image(life1,life1X,lifeY,lifeSize,lifeSize);
              image(life2,life2X,lifeY,lifeSize,lifeSize);
              image(life3,life3X,lifeY,lifeSize,lifeSize);               
              if(hogX<soldierX+80&&hogX+80>soldierX&&hogY<soldierY+80&&hogY+80>soldierY){
                lifeScore=LIFE_2;
                hogX=320;
                hogY=80;
              }
             break; 
           
           case LIFE_1:
              image(life1,life1X,lifeY,lifeSize,lifeSize);              
              if(hogX<cabbageX+80&&hogX+80>cabbageX&&hogY<cabbageY+80&&hogY+80>cabbageY){
                  lifeScore=LIFE_2;
                  cabbageX=width+10;
                  cabbageY=height+10;                 
               }
              if(hogX<soldierX+80&&hogX+80>soldierX&&hogY<soldierY+80&&hogY+80>soldierY){
                lifeScore=LIFE_0;                               
              }
             break;
             
           case LIFE_0:              
              gameState=GAME_OVER;
             break; 
           }           
         break;           
                                                       
      // Game Lose
      case GAME_OVER:
      image(gameover,0,0);
      if(mouseX>248&&mouseX<248+144&&mouseY>360&&mouseY<360+60){
          image(restartHover,248,360);
          if(mousePressed){            
            gameState=GAME_RUN;
            lifeScore=LIFE_2;
            hogX=320;
            hogY=80;
            cabbageX=80*floor(random(8));
            cabbageY=160+80*floor(random(4)); 
            soldierX=-80;
            soldierX+=soldierSpeed;
            soldierY= 160+80*floor(random(4));
          }
      }else{
          image(restartNormal,248,360);
      }
      break; 
   }
}      		
  
void keyPressed(){
    switch(keyCode){
     
      case DOWN:
        hogY+=hogDistance;
        if(hogY>height-80) hogY=height-80;
      break;
      case RIGHT:     
        hogX+=hogDistance;        
        if(hogX>width-80) hogX=width-80; 
      break;
      case LEFT:
        hogX-=hogDistance;
        if(hogX<0) hogX=0;
      break;
    }
}

/*
void keyReleased(){
  if(key==CODED){
    switch(keyCode){
      case UP:
      upPressed=false;
      break;
      case DOWN:
      downPressed=false;
      break;
      case RIGHT:
      rightPressed=false;
      break;
      case LEFT:
      leftPressed=false;
      break;
    }
 }
}
*/
