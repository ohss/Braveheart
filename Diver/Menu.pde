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
    textFont(biggerFont);
    text("DIVER", 500, 200);
    textFont(smallerFont);
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
    String instructions = "THE OBJECT: The Diver's object is to stay underwater for as long as possible\n\n" +
    "THE CONTROLS: When you start the game, there will be a 10 second countdown. During this period you have to get " +
    "your pulse as high as possible in order to get as much oxygen in as possible. After you have taken a deep breath, " +
    "you will dive underwater, and will start to consume that oxygen. The way to stay underwater as long as possible, is " +
    "to get your pulse to be as low as possible.\n\n" +
    "END OF INSTRUCTIONS";
    header("INSTRUCTIONS");
    textAlign(LEFT, CENTER);
    rectMode(CENTER);
    textSize(20);
    text(instructions, 500, 400, 800, 550);
    textSize(28);
    textAlign(CENTER);
    rectMode(CORNER);
    footer();
  }
  
  public void drawHigh(){
    String scores = " 1. 10:20 - AAA\n" +
    " 2. 09:58 - AAA\n" +
    " 3. 09:30 - AAA\n" +
    " 4. 09:01 - AAA\n" +
    " 5. 08:59 - AAA\n" +
    " 6. 08:58 - AAA\n" +
    " 7. 08:30 - AAA\n" +
    " 8. 08:00 - AAA\n" +
    " 9. 07:43 - AAA\n" +
    "10. 06:59 - AAA\n" +
    "---------------\n" +
    "38. 01:23 - AAA\n" +
    "39. 01:00 - AAA\n";
    header("HIGH SCORES");
    textAlign(CENTER, CENTER);
    rectMode(CENTER);
    textSize(20);
    text(scores, 500, 400, 800, 550);
    textSize(28);
    textAlign(CENTER);
    rectMode(CORNER);
    footer();
  }
  
  public void drawCredits(){
    String credits = "* The programming and designing: Team Braveheart (Emmi Peltonen, Lauri Lavanti and Otso Sorvettula)\n\n" +
    "* The menu music: Underclocked (underunderclocked mix) by Eric Skiff (ericskiff.com)\n\n" +
    "* The countdown music: \n\n" +
    "* The underwater music: We're the Resistors by Eric Skiff (ericskiff.com)\n\n" +
    "* The player sprite: \n\n" +
    "* The game's font: Press Start 2P by codeman38 (fontspace.com)";
    header("CREDITS");
    textAlign(LEFT, CENTER);
    rectMode(CENTER);
    textSize(20);
    text(credits, 500, 400, 800, 550);
    textSize(28);
    textAlign(CENTER);
    rectMode(CORNER);
    footer();
  }
  
  private void header(String head){
    textFont(biggerFont);
    textSize(72);
    text(head, 500, 150);
    textFont(smallerFont);
    textSize(28);
  }
  
  private void footer(){
    if (((int)millis()/600)%2 == 0) {
      text("Press ENTER to return", 500, 750);
    }
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
