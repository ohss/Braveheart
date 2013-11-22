/**
The functionality and visual represantation of the H2O-bar.
*/

public class H2OBar {
  // Dummy to test the filling and emptying of the H2O-bar
  float fill = 0;
  int lastMeasurement = 0;
  int now = 0;

  float oxygenFillMultiplier = 1.5;
  float oxygenEmptyMultiplier = 0.001;

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
      if (fill < 100 && !mainMenu && !gameOver) {
        playWarnings();
      }
      emptyBar();
    }
  }

  private void fillBar(){
    if (fill < 600) {
      fill += oxygenFillMultiplier*oxygenRate();
      if (fill > 600) { //make sure that bar doesn't overfill
        fill = 600;
      }
    }
    noStroke();
    fill(255);
    rect(15, 15, (int)fill, 100);
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
      fill -= oxygenRate();
    } else if (fill <= 0) {
      fill = 0;
      if (!gameOver) {
        game.gameIsOver(); //call gameIsOver method only when state changes, not all the time
      }
    }
    noStroke();
    fill(255);
    rect(15, 15, (int)fill, 100);
    fill(0);
    stroke(0);
  }

  private float oxygenRate() {
    now = millis();
    if (now - lastMeasurement > 250) {
      lastMeasurement = now;
      float retVal = oxygenEmptyMultiplier*pow(heartRateMonitor.getPulse(),2);
      println("Pulse" + heartRateMonitor.getPulse()+" Oxygen rate: "+retVal);
      return (retVal);
    } else {
     return 0;
    }
  }
}
