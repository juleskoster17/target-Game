
//imports the sound library from processing
import processing.sound.*;
SoundFile audioGame;
SoundFile audioGameOver;

//variables for the images and fonts
PImage img;
PImage button;
PImage monkey;
PFont font;

//color
final int BLACK = 0;
final int WHITE = #FFFFFF;

//every x and y coordinate
float x;
float y;

int yPos;
int xPos;

int snelheidTarget = 10;
int lengteRechthoek = 150;
int hoogteRechthoek = 50;
int xPositieRechthoek = width / 2 - lengteRechthoek / 2;
int yPositieRechthoek = height / 2 + hoogteRechthoek;

int yPositieText;
int buttonX, buttonY, buttonW, buttonH;

//additional information
int value = 0;
int grootteAfbeelding;
int score = 0;
int missed = -1;
int time;


//every boolean
boolean buttonPressed;
boolean gameStarted = false;
boolean gameOver = false;

void setup() {
  size(1000, 1000); 
  grootteAfbeelding = 150;
  loadingPage();
  audioGame = new SoundFile(this, "undertale.mp3");
  audioGame.amp(0.7);
  audioGame.loop();

  audioGameOver = new SoundFile(this, "gameover.mp3");

  button = loadImage("button.png");
  button.resize(0, 200);

  //verander "boss.png" naar ""target.png" voor een afbeelding van een target
  img = loadImage("boss.png");
  img.resize(0, grootteAfbeelding);

  monkey = loadImage("What.png");
  monkey.resize(0, grootteAfbeelding);

  font = createFont("battle.ttf", 24);


  frameRate(60);
  x = 0;
  y = 500;

  // Assume the button has not been pressed
  buttonPressed = false;

  // Some basic parameters for a button
  buttonW = 335;
  buttonH = 100;

  buttonX = (width-buttonW)/2;
  buttonY = (height-buttonH)/2;

  time = millis();
  loop();
}

void draw() {
  background(WHITE);
  if (buttonPressed) {
    if (gameStarted == true) {
      background(0);
      drawBoard(font);

      moveTarget();
      drawTarget();
      drawText(font);
      missedScore(font);
      pauseText();
      rechthoekPauze();
    }
  } else {
    // Show the button
    fill(#58FF00);
    stroke(#00FF00);
    image(button, buttonX + 50, buttonY);

    fill(BLACK);
    textFont(font, 24);
    textAlign(CENTER, CENTER);
    text("Press the red button at your own risk...\nYou only have 4 lifes in total so be carefull", width/2, 700);
  }
}

//hier wordt de loading page aangemaakt die op het scherm te zien is als je het programma opent
void loadingPage() {
  fill(BLACK);
  textSize(24);
  textAlign(CENTER, CENTER);
  text("Loading game...\nplease wait!!!", width / 2, height / 2);
}

void rechthoekPauze() {

  fill(255);
  stroke(0);
  rect(width / 2 - 50, 750, 100, 50);
}

//de begin pagina met de startknop
void drawBoard(PFont font) {
  background(BLACK);
  funnySideText(font);
}

void drawText(PFont font) {
  fill(WHITE);
  textFont(font, 24);
  text("score: " + score, 80, 50);
  text("missed:" + missed, 80, 100);
}

void pauseText() {
  fill(BLACK);
  textFont(font);
  textAlign(CENTER, CENTER);
  text("Pause", width / 2, 750);
}
//adds some kind of interaction between the moving image and the player
void funnySideText(PFont font) {
  switch(score) {
  case 1:
    fill(WHITE);
    textFont(font, 24);
    textAlign(CENTER, CENTER);
    text("Face the consequences\nThis will be your last day on earth", width/2, 700);
    break;
  case 10:
    fill(WHITE);
    textFont(font, 24);
    textAlign(CENTER, CENTER);
    text("What are you doing??\nStop it!!", width/2, 700);
    break;
  case 15:
    fill(WHITE);
    textFont(font, 24);
    textAlign(CENTER, CENTER);
    text("I swear to *** stop hitting me\nPlease I beg you....", width/2, 700);
    break;
  case 20:
    fill(WHITE);
    textFont(font, 24);
    textAlign(CENTER, CENTER);
    text("Stop it I can't stop laughing it tickles", width/2, 700);
    break;
  case 22:
    fill(WHITE);
    textFont(font, 24);
    textAlign(CENTER, CENTER);
    text("Please.......", width/2, 700);
    break;
  case 26:
    fill(WHITE);
    textFont(font, 24);
    textAlign(CENTER, CENTER);
    text("You're not gonna stop...\nAre you now, eh?", width/2, 700);
    break;
  case 69:
    fill(WHITE);
    textFont(font, 24);
    textAlign(CENTER, CENTER);
    text("n0ice", width/2, 700);
    break;
  case 80:
    fill(WHITE);
    textFont(font, 24);
    textAlign(CENTER, CENTER);
    text("note from the developer: Dude there's nothing more coming\nPlease stop it...", width/2, 700);
    break;
  case 85:
    fill(WHITE);
    textFont(font, 24);
    textAlign(CENTER, CENTER);
    text("Ah I see you're still here\nNever trust a developer, trust me", width/2, 700);
    break;
  case 90:
    image(monkey, xPositieRechthoek, yPositieRechthoek);
    break;
  }
  switch (missed) {
  case 1:
    fill(WHITE);
    textFont(font, 24);
    textAlign(CENTER, CENTER);
    text("Moehahahaha, you will regret playing this game!", width / 2, 900);
    break;
  case 3:
    fill(WHITE);
    textFont(font, 24);
    textAlign(CENTER, CENTER);
    text("Oehhhh you're getting close to death...\nTell me, how does it feel?", width / 2, 900);
    break;
  }
}

//als je al je levens hebt verspilt staat hierin wat er gezegd wordt
void missedScore(PFont font) {
  if (missed >= 4) {
    if (score <= 10) {
      gameOverScreen(font);
      text("Game over...\nWas this too hard for you, eh?", width / 2, height / 2);
    } else if (score <= 25) {
      gameOverScreen(font);
      text("Game over...\nDon't beat yourself up man you did great!", width / 2, height / 2);
    } else if (score <= 50) {
      gameOverScreen(font);
      text("Game over..\nBut fear not brave warrior, you are the best of your kind, a true legend!!!", width / 2, height / 2);
    } else if (score <= 100) {
      gameOverScreen(font);
      text("developers note: I had to add an extra line of code for your kind of people\nPlease show me some respect", width / 2, height / 2);
    } else if (score <= 250) {
      gameOverScreen(font);
      text("Why?? just why?\nGame over", width / 2, height / 2);
    } else if (score <= 500) {
      gameOverScreen(font);
      text("I can't take this anymore\nGame over and GG", width / 2, height / 2);
    }
  }
}

//hier staat alle informatie over het game over scherm
void gameOverScreen(PFont font) {
  audioGame.stop();
  background(BLACK);
  textFont(font, 24);
  textAlign(CENTER, CENTER);
}

//het stukje code verantwoordelijk voor het bewegen van het doelwit staat hierin
void moveTarget() {
  if (x > width - 150 || x < 0) {
    snelheidTarget = -snelheidTarget;
  }

  x = x + snelheidTarget;
}

//het doelwit wordt hierin getekend
void drawTarget() {
  image(img, x, y);
}


//als de muis wordt ingedrukt staat hierin wat hij moet doen
void mousePressed() {
  if (mouseX > buttonX && mouseX < buttonX+buttonW && mouseY > buttonY && mouseY < buttonY+buttonH)
    buttonPressed = true;
  gameStarted = true;
  if (gameStarted == true) {
    if (dist(x, y, mouseX, mouseY) < grootteAfbeelding) {
      score++;
    }
    if (gameStarted == true) {
      if (dist(x, y, mouseX, mouseY) > grootteAfbeelding) {
        missed++;
      }
    }
  }
}

void keyPressed() {
  if (key == 'p') {
    looping = !looping;
  }
}
