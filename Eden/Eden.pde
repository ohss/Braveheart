import java.util.*;
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.io.File;

// Required elements for drawing the game.
List<Position> wallPos = new ArrayList<Position>();
List<GardenWall> walls = new ArrayList<GardenWall>();
Menu menu;
Player player;
Sky sky;

// Required flags and variables.
private boolean mainMenu = true;
private boolean gameOver = true;
final int wallHeight = 200;

public void setup(){
  size(displayWidth,displayHeight,OPENGL);
  background(135, 206, 235);
  noCursor();
  sky = new Sky();
  menu = new Menu();
  //player = new Player();
  // Tähän tehdään muurit
  readFile();
  for (Position pos : wallPos) {
    walls.add(new GardenWall(pos.x, pos.y));
  }
}

boolean sketchFullScreen(){
  return true;
}

public void draw(){
  if (!mainMenu && !gameOver) {
    setAxes();
    sky.draw();
    drawFloor();
    for (GardenWall wall : walls) {
      println(wall);
      wall.draw();
    }
  }
  else if (mainMenu) {
    fill(135, 206, 235);
    rect(0, 0, displayWidth, displayHeight);
    menu.draw();
  }
}

public void keyPressed(){
  if (mainMenu) {
    menu.keyPressed();
  } else if (!mainMenu && !gameOver) {
    //player.keyPressed();
  }
}

public void drawFloor(){
  fill(1, 142, 14);
  rect(0, 0, 2000, 2000);
}

public void readFile(){
  BufferedReader br = null;
  try {
    br = new BufferedReader(new FileReader(dataPath("testilabyrintti.txt")));
    String line;
    int x = 0;
    while ((line = br.readLine()) != null) {
      for (int y = 0; y < line.length(); y++) {
        String sub = "" + line.charAt(y);
        if (sub.equals("x")) {
          wallPos.add(new Position(x, y));
        }
      }
      x++;
  }
  br.close();
  } catch (IOException e) {
    e.printStackTrace();
    try {
    if (br != null) br.close();
    } catch (IOException ex) {
    }
  }
}

private void setAxes(){
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

public class Position {
  public int x;
  public int y;
  
  public Position(int x, int y) {
    this.x = x;
    this.y = y;
  }
}
