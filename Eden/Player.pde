public class Player {
  
  static final int SPEED = 10;
  
  PApplet parent;
  
  PVector eye;
  PVector dir;
  PVector up;
  PVector zAxis;
  
  boolean movingFwd;
  boolean movingBack;
  boolean movingLeft;
  boolean movingRight;
  
  float rotX, rotY;
  
  public Player(PApplet parent) {
    eye = new PVector(0, 0, 0);
    up = new PVector(0, 0, 1);
    dir = new PVector(1, 0, 0);
    if (playerD.trim().equals("WEST")) {
      //dir = new PVector(0, 1, 0);
    } else if (playerD.trim().equals("NORTH")) {
      //dir = new PVector(-1, 0, 0);
    } else if (playerD.trim().equals("EAST")) {
      //dir = new PVector(0, -1, 0);
    } else {
    }
    movingFwd = false;
    movingBack = false;
    movingLeft = false;
    movingRight = false;
    rotX = rotY = 0.0;
    
    this.parent = parent;
  }
  
  public void draw() {
    // Rotating camera
    int deltaX = parent.pmouseX - parent.mouseX;
    rotX += radians(deltaX);
    
    /* Processing's linear algebra functionality sucks ass,
    * which forces us to use such uncivilized methods of
    * calculation instead of rotation Matrii. IRL those are
    * not that great either, see quaternions for Real Power™
    * in 3D rotations. */
    dir.x = cos(rotX);
    dir.y = sin(rotX);
    // Source: http://www.siggraph.org/education/materials/HyperGraph/modeling/mod_tran/3drota.htm
    // Remember: x=1, y=0, z=0 in the formulae, since that is our
    // original viewing direction
  
    // Adding movement to the eye
    PVector increment = PVector.mult(dir, SPEED);
    if (movingFwd) {
      eye.add(increment);
    }
    if (movingBack) {
      eye.sub(increment);
    }
    
    vCamera(eye, dir, up);
  }
  
  public void keyPressed() {
    if (parent.key == 'w' || parent.key == 'W') {
      movingFwd = true;
    }
    if (parent.key == 's' || parent.key == 'S') {
      movingBack = true;
    }
    if (parent.key == 'a' || parent.key == 'A') {
      movingLeft = true;
    }
    if (parent.key == 'd' || parent.key == 'D') {
      movingRight = true;
    }
  }
  
  public void keyReleased(){
    if (parent.key == 'w' || parent.key == 'W') {
      movingFwd = false;
    }
    if (parent.key == 's' || parent.key == 'S') {
      movingBack = false;
    }
    if (parent.key == 'a' || parent.key == 'A') {
      movingLeft = false;
    }
    if (parent.key == 'd' || parent.key == 'D') {
      movingRight = false;
    }
  }
  
  public void checkCollision() {
    for (Position trav : traversables) {
      int minX = trav.x + 30;
      int minY = trav.y + 30;
      int maxX = minX + wallSize - 60;
      int maxY = minY + wallSize - 60;
      boolean col = false;
      if (!trav.north && eye.x < minX && eye.x > trav.x && eye.y < (trav.y + wallSize) && eye.y > trav.y) {
        col = true;
      } else if (!trav.east && eye.y < minY && eye.y > trav.y && eye.x < (trav.x + wallSize) && eye.x > trav.x) {
        col = true;
      } else if (!trav.south && eye.x < (trav.x + wallSize) && eye.x > maxX && eye.y < (trav.y + wallSize) && eye.y > trav.y) {
        col = true;
      } else if (!trav.west && eye.y < (trav.y + wallSize) && eye.y > maxY && eye.x < (trav.x + wallSize) && eye.x > trav.x) {
        col = true;
      }
      if (col) {
        eye.x = max(min(eye.x, maxX), minX);
        eye.y = max(min(eye.y, maxY), minY);
      }
    }
  }
  
  public void vCamera(PVector eye, PVector dir, PVector up){
    PVector cent = PVector.add(eye, dir);
    parent.camera(eye.x, eye.y, eye.z, cent.x, cent.y, cent.z, up.x, up.y, up.x);
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
    rmx += parent.mouseX-width/2; 
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
