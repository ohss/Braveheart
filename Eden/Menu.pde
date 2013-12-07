/**
The visual representation and functionality of the main menu.
*/

public class Menu {
  boolean help = false;
  boolean credits = false;
  private final int half = displayWidth/2;

  /* IN SELECT ATTRIBUTE:
  * 0 equals start game, 1 equals instructions,
  * 2 equals high scores, 3 equals credits
  */
  int select = 0;

  public void draw(){
    fill(0, 50);
    rect(0, 0, displayWidth, displayHeight);
    fill(0);
    textAlign(CENTER);
    if (!help && !credits) {
      drawMain();
    } else if (help) {
      drawHelp();
    } else if (credits) {
      drawCredits();
    }
  }

  private void drawMain(){
    // Draw the header and subheader
    textSize(100);
    text("DIVER", half, 200);
    textSize(24);
    text("A game by BraveHeart Studios", half, 300);
    for (int i = 295; i < 306; i++) {
      text("Studios", half+250, i);
    }

    textSize(28);
    textAlign(LEFT, CENTER);
    text("Start game", half-150, 500);
    text("Instructions", half-150, 550);
    text("Credits", half-150, 600);

    if (((int)millis()/600)%2 == 0) {
      fill(0);
      stroke(0);
    } else {
      fill(0, 30);
      stroke(0, 30);
    }
    if (select == 0) {
      triangle(half-160, 500, half-190, 480, half-190, 520);
    } else if (select == 1) {
      triangle(half-160, 550, half-190, 530, half-190, 570);
    } else if (select == 2) {
      triangle(half-160, 600, half-190, 580, half-190, 620);
    }
    fill(0);
    stroke(0);
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
    text(instructions, half, 400, half+300, 550);
    textSize(28);
    textAlign(CENTER);
    rectMode(CORNER);
    footer();
  }

  public void drawCredits(){
    String credits = "* Programming and design: Team Braveheart (Emmi Peltonen, Lauri Lavanti and Otso Sorvettula)\n\n" +
    "* Menu music: Underclocked (underunderclocked mix) by Eric Skiff (ericskiff.com)\n\n" +
    "* Countdown music: Red Alert FX 001 from woolyss.com/chipmusic-samples.php\n\n" +
    "* Underwater music: We're the Resistors by Eric Skiff (ericskiff.com)\n\n" +
    "* Font: Press Start 2P by codeman38 (fontspace.com)\n\n" +
    "* Other sounds made with Bfxr (bfxr.net)";
    header("CREDITS");
    textAlign(LEFT, CENTER);
    rectMode(CENTER);
    textSize(20);
    text(credits, half, 400, half+300, 550);
    textSize(28);
    textAlign(CENTER);
    rectMode(CORNER);
    footer();
  }

  private void header(String head){
    textSize(72);
    text(head, half, 150);
    textSize(28);
  }

  private void footer(){
    if (((int)millis()/600)%2 == 0) {
      text("Press ENTER to return", half, 750);
    }
  }

  public void keyPressed(){
    if (!help && !credits) {
      if (key == CODED) {
        int i = 0;
        if (keyCode == UP) {
          i = -1;
        } else if (keyCode == DOWN) {
          i = 1;
        }
        select += i;
        if (select > 2) {
          select = 0;
        } else if (select < 0) {
          select = 2;
        }
      }
      if (key == ENTER || key == RETURN) {
        if (select == 0) {
          mainMenu = false;
          gameOver = false;
        } else if (select == 1) {
          help = true;
        } else if (select == 2) {
          credits = true;
        }
      }
    } else if (help && (key == ENTER || key == RETURN)) {
      help = false;
    } else if (credits && (key == ENTER || key == RETURN)) {
      credits = false;
    }
  }
}
