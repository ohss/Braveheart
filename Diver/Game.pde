/**
Visual representation for the background
*/

public class Game {
  
  public void draw(){
    fill(135, 206, 235);
    rect(0, 0, 1000, 800);
  }
  
  public void drawCountdown(){
    fill(0, 30);
    rect(0, 0, 1000, 800);
    fill(0);
    int diff = millis() - countdownStart;
    if (diff > 100 && diff < 900) {
      drawCDNumbers("10");
    } else if (diff > 1100 && diff < 1900) {
      drawCDNumbers("9");
    } else if (diff > 2100 && diff < 2900) {
      drawCDNumbers("8");
    } else if (diff > 3100 && diff < 3900) {
      drawCDNumbers("7");
    } else if (diff > 4100 && diff < 4900) {
      drawCDNumbers("6");
    } else if (diff > 5100 && diff < 5900) {
      drawCDNumbers("5");
    } else if (diff > 6100 && diff < 6900) {
      drawCDNumbers("4");
    } else if (diff > 7100 && diff < 7900) {
      drawCDNumbers("3");
    } else if (diff > 8100 && diff < 8900) {
      drawCDNumbers("2");
    } else if (diff > 9100 && diff < 9900) {
      drawCDNumbers("1");
    } else if (diff > 10100 && diff < 10900) {
      drawCDNumbers("RELAX");
    } else if (diff > 11000) {
      countDown = false;
    }
  }
  
  private void drawCDNumbers(String num) {
    PFont countdownFont = loadFont("PressStart2P-150.vlw");
    textFont(countdownFont);
    textAlign(CENTER, CENTER);
    textSize(150);
    text(num, 500, 400);
  }
  
  public void keyPressed() {
    mainMenu = true;
  }
}
