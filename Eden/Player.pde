
public class Player {
 
  // Player's location
  private final float locZ = wallHeight/3*2;
  private float locX;
  private float locY;
  
  // The location the player is looking at
  private float lookX;
  private float lookY;
  private float lookZ = wallHeight/3*2;
  
  // The location of axes to the player.
  private float upX = 0;
  private float upY = 0;
  private float upZ = -1.0;
  
  public Player() {
    locX = playerPos.x*wallSize + (wallSize/2);
    locY = playerPos.y*wallSize + (wallSize/2);
    if (playerD.trim().equals("WEST")) {
      lookX = locX;
      lookY = locY + 10;
    } else if (playerD.trim().equals("NORTH")) {
      lookX = locX - 10;
      lookY = locY;
    } else if (playerD.trim().equals("EAST")) {
      lookX = locX;
      lookY = locY - 10;
    } else {
      lookX = locX + 10;
      lookY = locY;
    } 
  }
  
  public void setCam() {
    camera(locX, locY, locZ, lookX, lookY, lookZ, upX, upY, upZ);
  }
  
  public void keyPressed() {
    if (key == 'w' || key == 'W') {
      locX += 10;
      lookX += 10;
    }
    if (key == 's' || key == 'S') {
      locX -= 10;
      lookX -= 10;
    }
    if (key == 'a' || key == 'A') {
      locY -= 10;
      lookY -= 10;
    }
    if (key == 'd' || key == 'D') {
      locY += 10;
      lookY += 10;
    }
    checkCollision();
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
  
  /**
  * Code taken/inspired by http://www.openprocessing.org/sketch/25255
  */
  /*
  // Floor has y-value
  final float floorLevel = 0.0;

  // camera / where you are
  float xpos,ypos,zpos, xlookat,ylookat,zlookat;
  float angle=0.0; // (angle left / right; 0..359)
  
  /**
  sincoslookup taken from http://wiki.processing.org/index.php/Sin/Cos_look-up_table
  @author toxi (http://www.processinghacks.com/user/toxi)
  */
  /*
  // declare arrays and params for storing sin/cos values
  float sinLUT[];
  float cosLUT[];
  // set table precision to 0.5 degrees
  float SC_PRECISION = 0.5f;
  // caculate reciprocal for conversions
  float SC_INV_PREC = 1/SC_PRECISION;
  // compute required table length
  int SC_PERIOD = (int) (360f * SC_INV_PREC);
  
  // -------------------------------------------------------------
  // virtual mouse
  // Code by rbrauer.
  // It won't work in the applet, ie online.
  // Copy the source code and try it from the PDE.
 
  float rmx, rmy;   // virtual mouse values
  
  public Player(){
    xpos = width/2.0;
    ypos = 360;
    zpos = 0 ; 
  
    CheckVirtualMouse ();
    CheckCameraMouse ();
  }
  
  void CheckCameraMouse () {
    // Mouse 
    // note: Makes use of the values of Robot-Mouse.
    float Radius = 450.0;  // Anfangsradius des Kreises
 
    // command map: See Help.
    angle = map(rmx,width,0,0,359); // left right
 
    // look at
    xlookat = Radius*sin(radians(angle)) + xpos;
    ylookat = map(rmy,-300,floorLevel-120,-270,height); // look up / down
    zlookat = Radius*cos(radians(angle)) + zpos;
 
    camera (xpos,ypos,zpos, xlookat, ylookat, zlookat, 0.0, 1.0, 0.0);
  }
  
  void CheckVirtualMouse () {
 
    // Code by rbrauer.
    // it won't work in the applet, ie online.
    // Copy the source code and try it from the PDE.
 

 
    //mouse pos is locked in center of canvas 
    //above lines subtract the centering, get whatever offset from 
    //center user creates by moving mouse before robot resets it, then 
    //continously adds that to our new mouse pos variables 
    rmx += mouseX-width/2; 
    rmy += mouseY-height/2; 
 
    //these lines are just shortened conditionals to handle 
    //wrapping of our mouse pos variables when they go outside canvas 
    //first one: 
    //if rmx>width? set rmx to rmx-width else : set rmx to rmx 
    rmx = rmx>width?rmx-width:rmx; 
    rmx = rmx<0?width+rmx:rmx; 
    // check ceiling
    if (rmy<-300) {
      rmy= -300;
    }
    // check floor
    if (rmy>floorLevel-20) {
      rmy= floorLevel-20;
    }
  }
  
  public void keyPressed(){
    float Radius = 13;
 
    // ----------------------------   
    // forward & backward
    if (key == 'w' || key == 'W') {
      // forward : should be running towards lookat
      xpos =   Radius*sin(radians(angle)) + xpos;
      zpos =   Radius*cos(radians(angle)) + zpos;
    }
    if (key == 's' || key == 'S') {
      // backward
      xpos =  xpos- (Radius*sin(radians(angle))) ;
      zpos =  zpos- (Radius*cos(radians(angle))) ;
    }
    // ----------------------------   
    // left & right
    if (key == 'a' || key == 'A') {
      // left
      xpos =   xpos- Radius*sin(radians(angle-90)) ;
      zpos =   zpos- Radius*cos(radians(angle-90)) ;
    }
    if (key == 'D' || key == 'd') {
      // right
      xpos =   Radius*sin(radians(angle-90)) + xpos;
      zpos =   Radius*cos(radians(angle-90)) + zpos;
    }
    checkBoundaries ();
  }
  
  void checkBoundaries () {
 
    if (xpos<-3995) {
      xpos=-3995;
    } else if (xpos>3995) {
      xpos=3995;
    }
    if (zpos<-3995) {
      zpos=-3995;
    } else if (zpos>3995) {
      zpos=3995;
    }
  }*/
}
