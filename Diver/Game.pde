/**
Visual representation for the background
*/
import java.util.Arrays;

public class Game {
  String playerName = "AAA";
  int typed = 0;
  HeartRateMonitor heartRateMonitor;

  public Game(HeartRateMonitor heartRateMonitor) {
    this.heartRateMonitor = heartRateMonitor;
  }

  public void draw(){
    fill(135, 206, 235);
    rect(0, 0, 1000, 800);
    if (!gameOver) {
      currentTime = calcTime();
    }
    drawStats(currentTime);
  }

  public void saveScore(){
    fill(0, 50);
    rect(0, 0, 1000, 800);
    fill(0);
    textAlign(CENTER);
    textSize(72);
    text("SAVE SCORE", 500, 200);
    textSize(28);
    text("Your score: " + currentTime, 500, 300);
    text("Your name: " + playerName, 500, 400);
    String blinkingCursor = "           ";
    for (int i = 0; i <= typed; i++) {
      blinkingCursor += " ";
    }
    blinkingCursor += (frameCount/10 % 2 == 0 ? "_" : " ");
    for (int i = 0; i <= (2-typed); i++) {
      blinkingCursor += " ";
    }
    text(blinkingCursor, 500, 400);
    text("Press ENTER to save", 500, 500);
  }

  private void drawStats(String time){
    textAlign(RIGHT, BOTTOM);
    // Do the outline for text
    textSize(28);
    fill(0);
    text("HEARTRATE "+Integer.toString((int)heartRateMonitor.getPulse()), 976, 49);
    text(time, 976, 99);
    // Do the text
    textSize(28);
    fill(255);
    text("HEARTRATE "+Integer.toString((int)heartRateMonitor.getPulse()), 975, 50);
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
    diveStart = 0;
    diveEnd = millis();
    mainMenu = true;
  }

  public void userTyped(){
    if (key != CODED) {
      if (key == BACKSPACE) {
        if (typed == 0) {
          playerName = "A" + playerName.substring(1, 3);
        }  else if (typed == 1) {
          playerName = playerName.substring(0, 1) + "A" + playerName.substring(2, 3);
          typed = 0;
        } else if (typed == 2) {
          playerName = playerName.substring(0, 2) + "A";
          typed = 1;
        }
      } else if (key == ENTER || key == RETURN) {
        int origLength = highScores.length;
        highScores = Arrays.copyOf(highScores, origLength+1);
        highScores[origLength] = currentTime + " - " + playerName;
        saveHighScores();
        loadHighScores();
        currentTime = "00:00:00";
        playerName = "AAA";
        mainMenu = true;
        gameOver = false;
        menu.highScore = true;
      } else if (Character.isLetter(key)) {
        char upKey = Character.toUpperCase(key);
        if (typed == 0) {
          playerName = upKey + playerName.substring(1, 3);
          typed = 1;
        } else if (typed == 1) {
          playerName = playerName.substring(0, 1) + upKey + playerName.substring(2, 3);
          typed = 2;
        } else {
          playerName = playerName.substring(0, 2) + upKey;
          typed = 2;
        }
      }
    }
  }

  public void gameIsOver(){
    diveStart = 0;
    diveEnd = millis();
    gameOver = true;
  }
}
