/**
The visual representation and functionality of the main menu.
*/

public class Menu {
  boolean help = false;
  boolean credits = false;
  private final int halfX = gameWidth/2;
  private final int halfY = gameHeight/2;
  PFont font = createFont("Freestyle Script", 32);

  /* IN SELECT ATTRIBUTE:
  * 0 equals start game, 1 equals instructions,
  * 2 equals high scores, 3 equals credits
  */
  int select = 0;

  public void draw(){
    background(bg);
    fill(255);
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
    textFont(font);
    textSize(40);
    text("EDEN", halfX, halfY/2-50);
    textSize(35);
    text("A game by BraveHeart Studios", halfX, (2*halfY/3)-50);

    textSize(35);
    textAlign(LEFT, CENTER);
    text("Start game", halfX-70, halfY+120);
    text("Instructions", halfX-70, halfY+170);
    text("Credits", halfX-70, halfY+220);

    if (((int)millis()/600)%2 == 0) {
      fill(255);
      stroke(255);
    } else {
      fill(255, 30);
      stroke(255, 30);
    }
    if (select == 0) {
      triangle(halfX-95, halfY+125, halfX-110, halfY+115, halfX-110, halfY+135);
    } else if (select == 1) {
      triangle(halfX-95, halfY+175, halfX-110, halfY+165, halfX-110, halfY+185);
    } else if (select == 2) {
      triangle(halfX-95, halfY+225, halfX-110, halfY+215, halfX-110, halfY+235);
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
    textSize(30);
    text(instructions, halfX, 400, halfX+300, 550);
    textSize(35);
    textAlign(CENTER);
    rectMode(CORNER);
    footer();
  }

  public void drawCredits(){
    String credits = "* Programming and design: Team Braveheart (Emmi Peltonen, Lauri Lavanti, Toomas Kallioja and Kaisa Halmetoja)\n\n" +
    "* Menu music: Underclocked (underunderclocked mix) by Eric Skiff (ericskiff.com)\n\n" +
    "* Menu background: FreeFever: Castle Beyond The Labyrinth Garden Wallpaper (freefever.com)" +
    "* Underwater music: We're the Resistors by Eric Skiff (ericskiff.com)\n\n" +
    "* Font: Press Start 2P by codeman38 (fontspace.com)\n\n" +
    "* Other sounds made with Bfxr (bfxr.net)";
    header("CREDITS");
    textAlign(LEFT, CENTER);
    rectMode(CENTER);
    textSize(30);
    text(credits, halfX, 400, halfX+300, 550);
    textSize(35);
    textAlign(CENTER);
    rectMode(CORNER);
    footer();
  }

  private void header(String head){
    textSize(40);
    text(head, halfX, 150);
    textSize(35);
  }

  private void footer(){
    if (((int)millis()/600)%2 == 0) {
      text("Press ENTER to return", halfX, 750);
    }
  }

  public void keyPressed(){
    if (!help && !credits) {
      int i = 0;
      if (key == 'w' || key == 'W') {
        i = -1;
      } else if (key == 's' || key == 'S') {
        i = 1;
      }
      select += i;
      if (select > 2) {
        select = 0;
      } else if (select < 0) {
        select = 2;
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
