/**
Basic module for the game Diver
by the group Braveheart
*/
import ddf.minim.*;
import java.util.Arrays;
import java.util.Collections;

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

// Required variables
String[] highScores;
int countdownStart = 0;
int diveStart = 0;
int diveEnd = 0;
String currentTime = "00:00:00";

// Audio players
Minim minim;
AudioPlayer selectPlayer;
AudioPlayer warningPlayer;
AudioPlayer menuPlayer;
AudioPlayer divePlayer;

// Fonts
PFont biggerFont;
PFont smallerFont;

public void setup(){
  size(1000,800);
  background(135, 206, 235);
  biggerFont = loadFont("PressStart2P-150.vlw");
  smallerFont = loadFont("PressStart2P-48.vlw");
  textFont(smallerFont);
  loadMusics();
  loadHighScores();
}

public void draw(){
  //heartRateMonitor.measureHeartRate();
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
  } else if (!mainMenu && gameOver) {
    game.saveScore();
  } else {
    if (!divePlayer.isPlaying()) {
      divePlayer.play();
    }
  }

  //text(Float.toString(heartRateMonitor.getPulse()), 10,20);

}

public void keyPressed() {
  if (mainMenu) {
    menu.keyPressed();
  } else if (!mainMenu && gameOver) {
    game.userTyped();
  } else {
    game.keyPressed();
  }
}

private void loadMusics(){
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

public void loadHighScores(){
  highScores = loadStrings("data/scores.txt");
  Arrays.sort(highScores, Collections.reverseOrder());
}

public void saveHighScores(){
  saveStrings("data/scores.txt", highScores);
}
