public class GardenWall {
  int x;
  int y;
  PImage text = loadImage("wall.jpg");
  
  public GardenWall(int x, int y) {
    this.x = x;
    this.y = y;
  }
  
  public void draw(){
    int tempX = x;
    int tempY = y;
    if (x != 0) {
      tempX = x*wallSize;
    }
    if (y != 0) {
      tempY = y*wallSize;
    }
    drawSide(tempX, tempY, true);
    drawSide(tempX, tempY, false);
    drawSide(tempX+wallSize, tempY, false);
    drawSide(tempX, tempY+wallSize, true);
  }
  
  private void drawSide(int startX, int startY, boolean xNotY){
    beginShape(QUAD);
    fill(225);
    texture(text);
    vertex(startX, startY, 0, 0, text.height);
    vertex(startX, startY, wallHeight, 0, 0);
    if (xNotY) {
      vertex(startX+wallSize, startY, wallHeight, text.width, 0);
      vertex(startX+wallSize, startY, 0, text.width, text.height);
    } else {
      vertex(startX, startY+wallSize, wallHeight, text.width, 0);
      vertex(startX, startY+wallSize, 0, text.width, text.height);
    }
    endShape(CLOSE);
  }
}
