/**
Basic module for the game Diver
by the group Braveheart
*/
import ddf.minim.*;
import java.util.Arrays;
import java.util.Collections;

//System variables
private int framerate = 60;

// Required objects for the game to play
private Game game = new Game();
private H2OBar h2oBar = new H2OBar();
private Player player = new Player();
private Water water = new Water();
private Menu menu = new Menu();
private HeartRateMonitor heartRateMonitor;

// Required flags
private boolean mainMenu = true;
private boolean countDown = false;
private boolean gameOver = false;

// Required variables
private String[] highScores;
private int countdownStart = 0;
private int diveStart = 0;
private int diveEnd = 0;
private String currentTime = "00:00:00";

// Audio players
protected Minim minim;
protected AudioPlayer selectPlayer;
protected AudioPlayer warningPlayer;
protected AudioPlayer menuPlayer;
protected AudioPlayer divePlayer;
protected AudioPlayer heartBeatSound;

// Fonts
private PFont biggerFont;
private PFont smallerFont;

public void setup(){
  frameRate(framerate);

  size(1000,800,P2D);
  background(135, 206, 235);

  heartRateMonitor = new HeartRateMonitor(framerate, "Heart Rate", this);
  heartRateMonitor.start();

  biggerFont = loadFont("PressStart2P-150.vlw");
  smallerFont = loadFont("PressStart2P-48.vlw");
  textFont(smallerFont);

  loadMusics();
  loadHighScores();
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
  } else if (!mainMenu && gameOver) {
    game.saveScore();
  } else {
    if (!divePlayer.isPlaying()) {
      divePlayer.play();
    }
  }
  text(Float.toString(heartRateMonitor.getPulse()), 10,20);

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
  heartBeatSound = minim.loadFile("data/beat.wav", 2048);
  menuPlayer.loop();
  menuPlayer.pause();
  divePlayer.loop();
  divePlayer.pause();
  selectPlayer.loop(1);
  selectPlayer.pause();
  warningPlayer.loop(1);
  warningPlayer.pause();
  heartBeatSound.loop(1);
  heartBeatSound.pause();
}

public void playHeartBeatSound(){
  //heartBeatSound.rewind();
  //heartBeatSound.play();
}

public void loadHighScores(){
  highScores = loadStrings("data/scores.txt");
  Arrays.sort(highScores, Collections.reverseOrder());
}

public void saveHighScores(){
  saveStrings("data/scores.txt", highScores);
}
