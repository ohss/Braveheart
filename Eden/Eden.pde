// Required elements for drawing the game.
List<GardenWall> walls = new ArrayList();
Menu menu;
Player player;
Sky sky;

public void setup(){
  sky = new Sky();
  menu = new Menu();
  player = new Player();
  // Tähän tehdään muurit
}

public void draw(){
  sky.draw();
  for (GardenWall wall : walls) {
    wall.draw();
  }
  player.draw();
  //tähän tarkistus siitä ollaanko menussa
  menu.draw();
}
