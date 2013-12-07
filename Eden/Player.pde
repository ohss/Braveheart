/**
* Code taken/inspired by http://www.openprocessing.org/sketch/25255
* 
*/

public class Player {
  // Floor has y-value
  final float floorLevel = 0.0;

  // camera / where you are
  float xpos,ypos,zpos, xlookat,ylookat,zlookat;
  float angle=0.0; // (angle left / right; 0..359)
  
  /**
  sincoslookup taken from http://wiki.processing.org/index.php/Sin/Cos_look-up_table
  @author toxi (http://www.processinghacks.com/user/toxi)
  */
 
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
  }
}
