public class GardenWall {
  int x;
  int y;
  
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
    vertex(startX, startY, 0);
    vertex(startX, startY, wallHeight);
    if (xNotY) {
      vertex(startX+wallSize, startY, wallHeight);
      vertex(startX+wallSize, startY, 0);
    } else {
      vertex(startX, startY+wallSize, wallHeight);
      vertex(startX, startY+wallSize, 0);
    }
    endShape(CLOSE);
  }
}
