/**
Basic module for the game Diver
by the group Braveheart
*/

// Required objects for the game to play
Game game = new Game();
H2OBar h2oBar = new H2OBar();
Player player = new Player();
Water water = new Water();
Menu menu = new Menu();

// Required flags
Boolean mainMenu = true;

public void setup(){
  size(1000,800);
  background(135, 206, 235);
}

public void draw(){
  game.draw();
  h2oBar.draw();
  player.draw();
  water.draw();
  
  if (mainMenu) {
    menu.draw();
  }
}
