import java.awt.Robot;

public class Player {
  PApplet parent;
  
  PVector eye;
  PVector dir;
  PVector up;
  PVector zAxis;
  
  boolean movingFwd;
  boolean movingBack;
  boolean movingLeft;
  boolean movingRight;
  
  static final int SPEED = 6;
  
  float rotX, rotY;
  
  // Robot to stop mouse from moving to the edges
  Robot robot;
  float rmx, rmy;
  float prevRmx, prevRmy;
  
  void init(PApplet parent){
   // "Player" and movement variables
   eye = new PVector(playerPos.x*wallSize+wallSize/2, playerPos.y*wallSize+wallSize/2, wallHeight/2);
   if (playerD.equals("NORTH")) {
     dir = new PVector(-1, 0, 0);
   } else if (playerD.equals("EAST")) {
     dir = new PVector(0, 1, 0);
   } else if (playerD.equals("SOUTH")) {
     dir = new PVector(1, 0, 0);
   } else {
     dir = new PVector(0, -1, 0);
   }
   up = new PVector(0, 0, 1);
   movingFwd = false;
   movingBack = false;
   movingLeft = false;
   movingRight = false;
   
   this.parent = parent;
   
   rotX = rotY = 0.0;
   
   try {
     robot = new Robot();
   } catch (Throwable e) {
     e.printStackTrace();
   }
  }
  
  void draw(){
    prevRmx = rmx;
    prevRmy = rmy;
    // Virtual mouse via robot
    robot.mouseMove(parent.frame.getX() + parent.getX() + round(width/2),
    parent.frame.getY() + parent.getY() + round(height/2));
    rmx += mouseX-width/2;
    rmy += mouseY-height/2;
    
    // Rotating camera
    rotX += radians(prevRmx - rmx)/2;
    rotY += radians(prevRmy - rmy)/2;
    
    /* Processing's linear algebra functionality sucks ass,
     * which forces us to use such uncivilized methods of
     * calculation instead of rotation Matrii. IRL those are
     * not that great either, see quaternions for Real Power™
     * in 3D rotations. */
    dir.x = cos(rotX);
    dir.y = sin(rotX);
    
    dir.z = -tan(rotY);
    
    // Source: http://www.siggraph.org/education/materials/HyperGraph/modeling/mod_tran/3drota.htm
    // Remember: x=1, y=0, z=0 in the formulae, since that is our
    // original viewing direction
    checkCollision();
    
    // Adding movement to the eye
    PVector increment = PVector.mult(new PVector(dir.x, dir.y, 0),SPEED);
    if(movingFwd) {
      eye.add(increment);
    }
    if(movingBack){
      eye.sub(increment);
    }
    if(movingLeft){
      eye.sub(PVector.div(increment, 2));
    }
    if (movingRight){
      eye.add(PVector.div(increment, 2));
    }
    
    // IMPORTANT NOTE: this is not the original Processing 2.0 camera method!
    vCamera(eye,dir,up);
  }
  
  void keyPressed(){
    if(key == 'w' || key == 'W'){
      movingFwd = true; 
    } else if(key == 's' || key == 'S'){
      movingBack = true; 
    } else if (key == 'a' || key == 'A'){
      movingLeft = true;
    } else if (key == 'd' || key == 'D'){
      movingRight = true;
    }
  }
  
  void keyReleased(){
    if(key == 'w' || key == 'W'){
      movingFwd = false; 
    } else if(key == 's' || key == 'S'){
      movingBack = false; 
    } else if (key == 'a' || key == 'A'){
      movingLeft = false;
    } else if (key == 'd' || key == 'D'){
      movingRight = false;
    }
  }
  
  /* Processing's camera method is retarded, and demands the center (or focal
   * point) of the view frustum. As aperture is not simulated, the distance of
   * said center is irrelevant; it only has to be on the dir vector to work. */
  void vCamera(PVector eye, PVector dir, PVector up){
    PVector cent = PVector.add(eye,dir);
    this.parent.camera(eye.x, eye.y, eye.z,
           cent.x, cent.y, cent.z,
           up.x, up.y, up.z);
  }
  
  public void checkCollision() {
    for (Position trav : traversables) {
      int minX = trav.x + 40;
      int minY = trav.y + 40;
      int maxX = minX + wallSize - 80;
      int maxY = minY + wallSize - 80;
      boolean colX = false;
      boolean colY = false;
      if (!trav.north && eye.x < minX && eye.x > trav.x && eye.y < (trav.y + wallSize) && eye.y > trav.y) {
        colX = true;
      } else if (!trav.east && eye.y < minY && eye.y > trav.y && eye.x < (trav.x + wallSize) && eye.x > trav.x) {
        colY = true;
      } else if (!trav.south && eye.x < (trav.x + wallSize) && eye.x > maxX && eye.y < (trav.y + wallSize) && eye.y > trav.y) {
        colX = true;
      } else if (!trav.west && eye.y < (trav.y + wallSize) && eye.y > maxY && eye.x < (trav.x + wallSize) && eye.x > trav.x) {
        colY = true;
      }
      if (colX) {
        eye.x = max(min(eye.x, maxX), minX);
      }
      if (colY) {
        eye.y = max(min(eye.y, maxY), minY);
      }
    }
  }
}
