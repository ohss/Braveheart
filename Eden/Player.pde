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
  }
  
  void draw(){    
    // Rotating camera
    rotX += radians(pmouseX - mouseX)/2;
    rotY += radians(pmouseY - mouseY)/2;
    
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
      int minX = trav.x + 30;
      int minY = trav.y + 30;
      int maxX = minX + wallSize - 60;
      int maxY = minY + wallSize - 60;
      boolean col = false;
      if (!trav.north && locX < minX && locX > trav.x && locY < (trav.y + wallSize) && locY > trav.y) {
        col = true;
      } else if (!trav.east && locY < minY && locY > trav.y && locX < (trav.x + wallSize) && locX > trav.x) {
        col = true;
      } else if (!trav.south && locX < (trav.x + wallSize) && locX > maxX && locY < (trav.y + wallSize) && locY > trav.y) {
        col = true;
      } else if (!trav.west && locY < (trav.y + wallSize) && locY > maxY && locX < (trav.x + wallSize) && locX > trav.x) {
        col = true;
      }
      if (col) {
        locX = max(min(locX, maxX), minX);
        locY = max(min(locY, maxY), minY);
      }
    }
  }
}
