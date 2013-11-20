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
//HeartRateMonitor heartRateMonitor = new HeartRateMonitor(this);

// Required flags
boolean mainMenu = true;
boolean countDown = false;
boolean gameOver = false;
int countdownStart = 0;
int diveStart = 0;
int diveEnd = 0;

// Audio players
Minim minim;
// Menu and dive music by Eric Skiff (http://ericskiff.com/music/)
AudioPlayer menuPlayer;
AudioPlayer divePlayer;
AudioPlayer selectPlayer;
AudioPlayer warningPlayer;

// Fonts
PFont biggerFont;
PFont smallerFont;

public void setup(){
  size(1000,800);
  background(135, 206, 235);
  biggerFont = loadFont("PressStart2P-150.vlw");
  smallerFont = loadFont("PressStart2P-48.vlw");
  textFont(smallerFont);
  minim = new Minim(this);
  menuPlayer = minim.loadFile("data/02_Underclocked_(underunderclocked_mix).mp3", 2048);
  divePlayer = minim.loadFile("data/07_We're_the_Resistors.mp3", 2048);
  selectPlayer = minim.loadFile("data/select.wav", 2048);
  warningPlayer = minim.loadFile("data/Warning_sound.wav", 2048);
  menuPlayer.loop();
  menuPlayer.pause();
  divePlayer.loop();
  divePlayer.pause();
  selectPlayer.loop(1);
  selectPlayer.pause();
  warningPlayer.loop(1);
  warningPlayer.pause();
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
