/**
The visual representation and functionality of the main menu.
*/

public class Menu {
  boolean help = false;
  boolean highScore = false;
  boolean credits = false;
  
  /* IN SELECT ATTRIBUTE:
  * 0 equals start game, 1 equals instructions,
  * 2 equals high scores, 3 equals credits
  */
  int select = 0;
  
  public void draw(){
    
    fill(0, 50);
    rect(0, 0, 1000, 800);
    fill(0);
    textAlign(CENTER);
    if (!help && !credits && !highScore) {
      drawMain();
    } else if (help) {
      drawHelp();
    } else if (highScore) {
      drawHigh();
    } else if (credits) {
      drawCredits();
    }
  }
  
  private void drawMain(){
    // Draw the header and subheader
    textSize(100);
    text("DIVER", 500, 200);
    textSize(24);
    text("A game by BraveHeart Studios", 500, 300);
    for (int i = 295; i < 306; i++) {
      text("Studios", 750, i);
    }
    
    textSize(28);
    textAlign(LEFT, CENTER);
    text("Start game", 350, 500);
    text("Instructions", 350, 550);
    text("High scores", 350, 600);
    text("Credits", 350, 650);
    
    if (((int)millis()/600)%2 == 0) {
      fill(0);
      stroke(0);
      if (select == 0) {
        triangle(340, 500, 310, 480, 310, 520);
      } else if (select == 1) {
        triangle(340, 550, 310, 530, 310, 570);
      } else if (select == 2) {
        triangle(340, 600, 310, 580, 310, 620);
      } else if (select == 3) {
        triangle(340, 650, 310, 630, 310, 670);
      }
    }
  }
  
  public void drawHelp(){
    // Tänne sit vaan kirjottelemaan ohjeita
  }
  
  public void drawHigh(){
    
  }
  
  public void drawCredits(){
    
  }
  
  public void keyPressed(){
    if (!help && !highScore && !credits) {
      if (key == CODED) {
        int i = 0;
        if (keyCode == UP) {
          i = -1;
        } else if (keyCode == DOWN) {
          i = 1;
        }
        select += i;
        if (select > 3) {
          select = 0;
        } else if (select < 0) {
          select = 3;
        }
      }
      if (key == ENTER || key == RETURN) {
        if (select == 0) {
          mainMenu = false;
          countDown = true;
          countdownStart = millis();
        } else if (select == 1) {
          help = true;
        } else if (select == 2) {
          highScore = true;
        } else if (select == 3) {
          credits = true;
        }
      }
    } else if (help && (key == ENTER || key == RETURN)) {
      help = false;
    } else if (highScore && (key == ENTER || key == RETURN)) {
      highScore = false;
    } else if (credits && (key == ENTER || key == RETURN)) {
      credits = false;
    }
  }
}
