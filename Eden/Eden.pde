import java.util.*;
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.io.File;

// Required positions and directions.
List<Position> wallPos = new ArrayList<Position>();
Position playerPos;
String playerD;
List<Position> traversables = new ArrayList<Position>();

// Required elements for drawing the game.
List<GardenWall> walls = new ArrayList<GardenWall>();
Menu menu;
Player player;
Sky sky;

// Required flags and variables.
private boolean mainMenu = true;
private boolean gameOver = true;
final int wallHeight = 200;
final int wallSize = 200;
int gameWidth;
int gameHeight;
final boolean fullScreen = true;
private PImage bg;

public void setup(){
  gameWidth = displayWidth;
  gameHeight = displayHeight;
  size(gameWidth,gameHeight,OPENGL);
  bg = loadImage("garden_labyrinth.jpg");
  bg.resize(gameWidth, gameHeight);
  background(bg);
  noCursor();
  sky = new Sky();
  menu = new Menu();
  // Tähän tehdään muurit
  readFile();
  player = new Player();
  for (Position pos : wallPos) {
    walls.add(new GardenWall(pos.x, pos.y));
  }
}

boolean sketchFullScreen(){
  return fullScreen;
}

public void draw(){
  if (!mainMenu && !gameOver) {
    setAxes();
    player.setCam();
    sky.draw();
    drawFloor();
    for (GardenWall wall : walls) {
      wall.draw();
    }
  }
  else if (mainMenu) {
    menu.draw();
  }
}

public void keyPressed(){
  if (mainMenu) {
    menu.keyPressed();
  } else if (!mainMenu && !gameOver) {
    player.keyPressed();
  }
}

public void mouseMoved(){
  if (!mainMenu && !gameOver) {
    player.mouseMoved();
  }
}

public void drawFloor(){
  fill(1, 142, 14);
  //rect(0, 0, 2000, 2000);
  ellipseMode(CENTER);
  ellipse(width/2, height/2, 4000, 4000);
}

public void readFile(){
  BufferedReader br = null;
  try {
    br = new BufferedReader(new FileReader(dataPath("testilabyrintti.txt")));
    String line;
    int x = 0;
    playerD = br.readLine();
    while ((line = br.readLine()) != null) {
      for (int y = 0; y < line.length(); y++) {
        String sub = "" + line.charAt(y);
        if (sub.equals("x")) {
          wallPos.add(new Position(x, y));
        } else if (sub.equals("a")) {
          playerPos = new Position(x, y);
          traversables.add(new Position(x*wallSize, y*wallSize));
        } else if (sub.equals("o")) {
          traversables.add(new Position(x*wallSize, y*wallSize));
        }
      }
      x++;
    }
    for (Position trav : traversables) {
      if (wallPos.contains(new Position((trav.x-wallSize)/wallSize, trav.y/wallSize))) {
        trav.north = false;
      }
      if (wallPos.contains(new Position(trav.x/wallSize, (trav.y-wallSize)/wallSize))) {
        trav.east = false;
      }
      if (wallPos.contains(new Position((trav.x+wallSize)/wallSize, trav.y/wallSize))) {
        trav.south = false;
      }
      if (wallPos.contains(new Position(trav.x/wallSize, (trav.y+wallSize)/wallSize))) {
        trav.west = false;
      }
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
  public boolean north = true;
  public boolean east = true;
  public boolean south = true;
  public boolean west = true;
  
  public Position(int x, int y) {
    this.x = x;
    this.y = y;
  }
  
  public boolean equals(Object other) {
    if (other == null) return false;
    if (other == this) return true;
    if (!(other instanceof Position)) return false;
    Position that = (Position) other;
    return this.x == that.x && this.y == that.y;
  }
  
  public int hashCode() {
    int result = (int) (x ^ (x >>> 32));
    result = 31 * result + (int) (y ^ (y >>> 32));
    return result;
  }
  
  public String toString() {
    return "X: " + x + ", Y: " + y;
  }
}
