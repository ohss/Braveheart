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
    drawCorners(tempX, tempY);
  }
  
  private void drawSide(int startX, int startY, boolean xNotY){
    int yPlus = 0;
    int xPlus = 0;
    if (xNotY) xPlus = 10;
    else yPlus = 10;
    beginShape(QUAD);
    fill(225);
    texture(text);
    vertex(startX+xPlus, startY+yPlus, 0, 0, text.height);
    vertex(startX+xPlus, startY+yPlus, wallHeight, 0, 0);
    if (xNotY) {
      vertex(startX+wallSize-xPlus, startY, wallHeight, text.width, 0);
      vertex(startX+wallSize-xPlus, startY, 0, text.width, text.height);
    } else {
      vertex(startX, startY+wallSize-yPlus, wallHeight, text.width, 0);
      vertex(startX, startY+wallSize-yPlus, 0, text.width, text.height);
    }
    endShape(CLOSE);
  }
  
  private void drawCorners(int x, int y){
    beginShape(QUAD);
    fill(255);
    texture(text);
    vertex(x+10, y, 0, 0, text.height);
    vertex(x+10, y, wallHeight, 0, 0);
    vertex(x, y+10, wallHeight, text.width, 0);
    vertex(x, y+10, 0, text.width, text.height);
    endShape(CLOSE);
    
    beginShape(QUAD);
    fill(255);
    texture(text);
    vertex(x+wallSize-10, y, 0, 0, text.height);
    vertex(x+wallSize-10, y, wallHeight, 0, 0);
    vertex(x+wallSize, y+10, wallHeight, text.width, 0);
    vertex(x+wallSize, y+10, 0, text.width, text.height);
    endShape(CLOSE);
    
    beginShape(QUAD);
    fill(255);
    texture(text);
    vertex(x+wallSize, y+wallSize-10, 0, 0, text.height);
    vertex(x+wallSize, y+wallSize-10, wallHeight, 0, 0);
    vertex(x+wallSize-10, y+wallSize, wallHeight, text.width, 0);
    vertex(x+wallSize-10, y+wallSize, 0, text.width, text.height);
    endShape(CLOSE);
    
    beginShape(QUAD);
    fill(255);
    texture(text);
    vertex(x+10, y+wallSize, 0, 0, text.height);
    vertex(x+10, y+wallSize, wallHeight, 0, 0);
    vertex(x, y+wallSize-10, wallHeight, text.width, 0);
    vertex(x, y+wallSize-10, 0, text.width, text.height);
    endShape(CLOSE);
  }
}
