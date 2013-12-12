import java.util.*;
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.io.File;

// Required positions and directions.
List<Position> wallPos = new ArrayList<Position>();
Position playerPos;
Position goalPos;
String playerD;
String goalD;
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
// X
int levelWidth = 0;
// Y
int levelLength = 0;
final boolean fullScreen = true;
private PImage bg;

public void setup(){
  gameWidth = displayWidth;
  gameHeight = displayHeight;
  size(gameWidth,gameHeight,P3D);
  bg = loadImage("garden_labyrinth.jpg");
  bg.resize(gameWidth, gameHeight);
  background(bg);
  noCursor();
  sky = new Sky();
  menu = new Menu();
  // Tähän tehdään muurit
  readFile();
  player = new Player();
  player.init(this);
  for (Position pos : wallPos) {
    walls.add(new GardenWall(pos.x, pos.y));
  }
}

boolean sketchFullScreen(){
  return fullScreen;
}

public void draw(){
  if (!mainMenu && !gameOver) {
    player.draw();
    sky.draw();
    drawFloor();
    drawGoal();
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

public void keyReleased(){
  if (!mainMenu && !gameOver) {
    player.keyReleased();
  }
}

public void drawFloor(){
  translate(0, 0, wallHeight);
  fill(1, 142, 14);
  rect(0, 0, levelWidth*wallSize, levelLength*wallSize);
  translate(0, 0, -wallHeight);
}

public void drawGoal(){
  if (goalD.equals("NORTH")) {
    
  } else if (goalD.equals("EAST")) {
    
  } else if (goalD.equals("SOUTH")) {
    
  } else {
    
  }
}

public void readFile(){
  BufferedReader br = null;
  try {
    br = new BufferedReader(new FileReader(dataPath("testilabyrintti.txt")));
    String line;
    int x = 0;
    int lineY = 0;
    playerD = br.readLine();
    goalD = br.readLine();
    while ((line = br.readLine()) != null) {
      for (int y = 0; y < line.length(); y++) {
        lineY = line.length() > lineY ? line.length() : lineY;
        String sub = "" + line.charAt(y);
        if (sub.equals("x")) {
          wallPos.add(new Position(x, y));
        } else if (sub.equals("a")) {
          playerPos = new Position(x, y);
          traversables.add(new Position(x*wallSize, y*wallSize));
        } else if (sub.equals("o")) {
          traversables.add(new Position(x*wallSize, y*wallSize));
        } else if (sub.equals("g")) {
          goalPos = new Position(x, y);
          traversables.add(new Position(x*wallSize, y*wallSize));
        }
      }
      x++;
    }
    levelWidth = x;
    levelLength = lineY;
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