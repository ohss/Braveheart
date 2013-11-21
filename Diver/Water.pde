/**
Visual representation of the water.

Based on http://www.funprogramming.org/38-Animate-the-ocean-surface-using-noise.html
*/

public class Water {
  private float time = 0;
  private int w = 1000;
  private int h = 800;
  private int wave = 50;


  public void draw(){
    float x = 0;
    while (x<width){
      float noise = 50*noise(x/100,time);
      stroke(1,111);
      line(x,350+noise,x,height);
      x++;
    }
    time = time+.02;
  }
}
