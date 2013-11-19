/**
Visual representation for the background
*/

public class Game {
  
  public void draw(){
    fill(135, 206, 235);
    rect(0, 0, 1000, 800);
    String time = calcTime();
    drawStats(time);
  }
  
  private void drawStats(String time){
    textAlign(RIGHT, BOTTOM);
    // Do the outline for text
    textSize(28);
    fill(0);
    text("HEARTRATE", 976, 49);
    text(time, 976, 99);
    // Do the text
    textSize(28);
    fill(255);
    text("HEARTRATE", 975, 50);
    text(time, 975, 100);
    // Reset settings
    fill(0);
    textAlign(CENTER);
  }
  
  private String calcTime(){
    String finMinutes = "00";
    String finSeconds = "00";
    String finTenths = "00";
    if (diveStart != 0) {
      int minutes = 0;
      int seconds = 0;
      int tenths = 0;
      int diff = millis() - diveStart;
      while (diff/60000 >= 1) {
        minutes++;
        diff -= 60000;
      }
      while (diff/1000 >= 1) {
        seconds++;
        diff -= 1000;
      }
      while (diff/10 >= 1) {
        tenths++;
        diff -= 10;
      }
      if (minutes < 10) {
        finMinutes = "0" + minutes;
      } else {
        finMinutes = minutes + "";
      }
      if (seconds < 10) {
        finSeconds = "0" + seconds;
      } else {
        finSeconds = seconds + "";
      }
      if (tenths < 10) {
        finTenths = "0" + tenths;
      } else {
        finTenths = tenths + "";
      }
    }
    return finMinutes + ":" + finSeconds + ":" + finTenths;
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
      diveStart = millis();
    }
  }
  
  private void drawCDNumbers(String num){
    textFont(biggerFont);
    textAlign(CENTER, CENTER);
    textSize(150);
    text(num, 500, 400);
  }
  
  public void keyPressed(){
    endGame();
  }
  
  public void endGame(){
    diveStart = 0;
    diveEnd = millis();
    mainMenu = true;
  }
}
