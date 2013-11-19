/**
Basic module for the game Diver
by the group Braveheart
*/

// Required objects for the game to play
Game game = new Game();
H2OBar h2oBar = new H2OBar();
Player player = new Player();
Water water = new Water();
Menu menu = new Menu();

// Required flags
boolean mainMenu = true;
boolean countDown = false;
int countdownStart = 0;

public void setup(){
  size(1000,800);
  background(135, 206, 235);
  PFont gameFont = loadFont("PressStart2P-48.vlw");
  textFont(gameFont);
}

public void draw(){
  game.draw();
  h2oBar.draw();
  player.draw();
  water.draw();
  
  if (mainMenu) {
    menu.draw();
  } else if (countDown) {
    game.drawCountdown();
  }
}

public void keyPressed() {
  if (mainMenu) {
    menu.keyPressed();
  }
}
