/**
The visual representation of the player.
*/

public class Player {
  // Images
  PImage diverStart = loadImage("data/diver_start.png");
  PImage diverMiddle = loadImage("data/diver_middle.png");
  PImage diverEnd = loadImage("data/diver_end.png");
  
  // Requirements for draw
  boolean onSurface = true;
  float change = 0;
  float yMovement = 360;
  
  // Requirements for drawDiver
  int stateChange = millis();
  int drawNow = 0;
  int lastDraw = 0;
  
  public void draw(){
    if (gameOver && !onSurface) {
      yMovement -= 2;
      if (yMovement <= 360) {
        yMovement = 360;
        onSurface = true;
      }
    } else if (!gameOver && onSurface) {
      yMovement += 2;
      if (yMovement >= 560) {
        yMovement = 560;
        onSurface = false;
      } 
    }
    float noise = 50*noise(0/100, change);
    float x = 474 + (noise*0.5);
    float y = yMovement + (onSurface ? (noise*0.2) : (noise*0.5));
    drawDiver(x, y);
    change += 0.02;
  }
  
  private void drawDiver(float x, float y){
    int diff = millis()-stateChange;
    if (diff > 120) {
      stateChange = millis();
      if (drawNow == 0 || drawNow == 2) {
        drawNow = 1;
      } else {
        if (lastDraw == 0) {
          drawNow = 2;
          lastDraw = 2;
        } else {
          drawNow = 0;
          lastDraw = 0;
        }
      }
    }
    if (drawNow == 0) {
      image(diverStart, x, y);
    } else if (drawNow == 1) {
      image(diverMiddle, x, y);
    } else {
      image(diverEnd, x, y);
    }
  }
}
