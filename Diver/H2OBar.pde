/**
The functionality and visual represantation of the H2O-bar.
*/

public class H2OBar {
  // Dummy to test the filling and emptying of the H2O-bar
  int fill = 0;
  int fillSize = 1;
  int emptySize = 1;
  
  public void draw(){
    noFill();
    stroke(255);
    strokeWeight(10);
    rect(15, 15, 600, 100);
    fill(0);
    stroke(0);
    strokeWeight(1);
    if (!mainMenu && countDown) {
      fillBar();
    } else {
      if (fill < 200 && !mainMenu && !gameOver) {
        playWarnings();
      }
      emptyBar();
    }
  }
  
  private void fillBar(){
    if (fill < 600) {
      fill += fillSize;
    }
    noStroke();
    fill(255);
    rect(15, 15, fill, 100);
    fill(0);
    stroke(0);
  }
  
  private void playWarnings() {
    if (((int)millis()/700)%2 == 0) {
      if (!warningPlayer.isPlaying()) {
        warningPlayer.rewind();
        warningPlayer.play();
      }
      fill(255, 0, 0);
      stroke(255);
      strokeWeight(10);
      rect(15, 15, 600, 100);
      fill(0);
      stroke(0);
      strokeWeight(1);
    }
  }
  
  private void emptyBar(){
    if (fill > 0) {
      gameOver = false;
      fill -= fillSize;
    } else if (fill <= 0) {
      fill = 0;
      game.gameIsOver();
    }
    noStroke();
    fill(255);
    rect(15, 15, fill, 100);
    fill(0);
    stroke(0);
  }
}
