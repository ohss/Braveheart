/**
Basic module for the game Diver
by the group Braveheart
*/
import ddf.minim.*;

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

// Audio players
Minim minim;
// Menu and dive music by Eric Skiff (http://ericskiff.com/music/)
AudioPlayer menuPlayer;
AudioPlayer divePlayer;

public void setup(){
  size(1000,800);
  background(135, 206, 235);
  PFont gameFont = loadFont("PressStart2P-48.vlw");
  textFont(gameFont);
  minim = new Minim(this);
  menuPlayer = minim.loadFile("data/02_Underclocked_(underunderclocked_mix).mp3", 2048);
  divePlayer = minim.loadFile("data/07_We're_the_Resistors.mp3", 2048);
  menuPlayer.loop();
  menuPlayer.pause();
  divePlayer.loop();
  divePlayer.pause();
}

public void draw(){
  game.draw();
  h2oBar.draw();
  player.draw();
  water.draw();
  
  if (mainMenu) {
    divePlayer.pause();
    if (!menuPlayer.isPlaying()) {
      menuPlayer.play();
    }
    menu.draw();
  } else if (countDown) {
    menuPlayer.pause();
    game.drawCountdown();
  } else {
    if (!divePlayer.isPlaying()) {
      divePlayer.play();
    }
  }
}

public void keyPressed() {
  if (mainMenu) {
    menu.keyPressed();
  } else {
    game.keyPressed();
  }
}
