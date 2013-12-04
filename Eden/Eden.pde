import java.util.*;

// Required elements for drawing the game.
List<GardenWall> walls = new ArrayList();
Menu menu;
Player player;
Sky sky;

// Required flags.
private boolean mainMenu = true;
private boolean gameOver = true;

public void setup(){
  size(1000,800,P3D);
  background(255);
  sky = new Sky();
  menu = new Menu();
  player = new Player();
  // Tähän tehdään muurit
}

public void draw(){
  drawAxes();
  sky.draw();
  for (GardenWall wall : walls) {
    wall.draw();
  }
  player.draw();
  //tähän tarkistus siitä ollaanko menussa
  if (mainMenu) {
  menu.draw();
  }
}

public void keyPressed() {
  if (mainMenu) {
    menu.keyPressed();
  }
}

private void drawAxes(){
  translate(0, 800);
  rotateX(radians(90));
  rotateZ(radians(-90));
  // X-axis = red
  line(1, 1, 1, 401, 1, 1);
  fill(255, 0, 0);
  beginShape(TRIANGLES);
  vertex(401, -21, 1);
  vertex(401, 21, 1);
  vertex(421, 1, 1);
  endShape();
  // Y-axis = green
  line(1, 1, 1, 1, 401, 1);
  fill(0, 255, 0);
  beginShape(TRIANGLES);
  vertex(1, 401, -21);
  vertex(1, 401, 21);
  vertex(1, 421, 1);
  endShape();
  // Z-axis = blue
  line(1, 1, 1, 1, 1, 401);
  fill(0, 0, 255);
  beginShape(TRIANGLES);
  vertex(-21, 1, 401);
  vertex(21, 1, 401);
  vertex(1, 1, 421);
  endShape();
}
