/**
Studio 4 - Breveheart
Harkka 2: Tietokonetaide
Syksy 2013

Ispired by: 

procsilas (procsilas@hotmail.com / http://procsilas.net)
http://www.openprocessing.org/sketch/59807

Adam Lastowka 
http://www.openprocessing.org/sketch/95650
**/

/* @pjs preload="image.jpg, braveheart.jpg, cat.jpg, descartes.jpg, banksy.jpg"; */

private String imageName = "image.jpg";
private PImage img;

private ArrayList<Crawler> crawlers;// = new ArrayList<Crawler>();
private ArrayList<Particle> particles;// = new ArrayList<Particle>();

private boolean drawModeLines = true;

private int numberOfPoints = 2000; //Range 1000-10 000. Very brute force.
private int border = 1; //This is used when the brightness variance of the neighborhood of a pixel is calculated
//Neighborhood is (2*border+1)^2 pixels. (1-3 are good values)
private float brightnessThreshold = 30; //range 5-50. Only pixels with greater brightness variance are selected
private int maxDistanceToNextPoint = 1; //used when approximating the sorting of points. In the end result, distances between last points tend to be long
private PointFactory pointFactory;

private PImage image1;
private PImage image2;
private PImage image3;
private PImage image4;
private PImage image5;

public void setup(){
        size(600,600);
	background(0);
        setImages();
	reset();
	
}

private void reset() {
	background(0);
	pointFactory = new PointFactory(numberOfPoints, border, brightnessThreshold, maxDistanceToNextPoint);
	// crawlers.clear();
	// particles.clear();
	crawlers = new ArrayList<Crawler>();
	particles = new ArrayList<Particle>();
	for (int i = 0; i<9; i++){
		crawlers.add(new Crawler(pointFactory));
	}
	for (PVector v : pointFactory.getNewPoints()){
		particles.add(new Particle(v.x,v.y));
	}
}


private void setImages() {
        image1 = loadImage("image.jpg");
        image2 = loadImage("braveheart.jpg");
        image3 = loadImage("cat.jpg");
        image4 = loadImage("descartes.jpg");
        image5 = loadImage("banksy.jpg");
        img = image1;
        img.loadPixels();
}

public void switchDrawMode() {
	reset();
	drawModeLines = !drawModeLines;
}

public void draw() {
	if (drawModeLines) {
		for (Crawler c : crawlers){
			c.draw();
		}
	} else {
		background(0);
		for (Particle p : particles){
			p.draw();
		}
	}
}

public void keyReleased() {
	if (key == ENTER || key == RETURN) {
		switchDrawMode();
	} 
	if (key == '1') {
		imageName = "image.jpg";
		img = image1;
                img.loadPixels();
		reset();
	}
	if (key == '2') {
		imageName = "braveheart.jpg";
		img = image2;
                img.loadPixels();
		reset();
	}
	if (key == '3') {
		imageName = "cat.jpg";
		img = image3;
                img.loadPixels();
		reset();
	}
	if (key == '4') {
		imageName = "descartes.jpg";
		img = image4;
                img.loadPixels();
		reset();
	}
	if (key == '5') {
		imageName = "banksy.jpg";
		img = image5;
                img.loadPixels();
		reset();
	}


}

public class Crawler {
	private ArrayList<PVector> points;
	private int drawIndex = 0;
	private PointFactory pointFactory;

	public Crawler (PointFactory pointFactory) {
		this.pointFactory = pointFactory;
		this.points = pointFactory.getNewPoints();
	}

	public void draw() {
		float w = random(0.3, 1.5);
		float ww = random(-1,1);
		stroke(44*(w+1), 117*(ww+1), 255, 100);
		if (drawIndex == points.size()-1) {
				points = pointFactory.getNewPoints();
				drawIndex = 0;
        } else {
        	if (points.get(drawIndex).dist(points.get(drawIndex+1)) < 100) { //get rid of long lines
                line(points.get(drawIndex).x, points.get(drawIndex).y, points.get(drawIndex+1).x, points.get(drawIndex+1).y);
            }
            drawIndex++;
        }
	}
}
/** Based on:
*        http://processing.datasingularity.com/sketches/ParticlePhysicsTutorial_6/applet/ParticlePhysicsTutorial_6.pde
*        
**/

public class Particle {

        PVector location;
        PVector velocity;
        PVector acceleration;
        PVector gravLocation;
        float mass;
        float gravMass = 1000;
        float friction = 0.9;
        float strength = 500;
        float minDistance = 500;
        float minDistanceToMouse = 100;
        int drawSize = 1;

        public Particle (float x, float y) {
                location = new PVector(x,y);
                velocity = new PVector(0,0);
                acceleration = new PVector(0,0);
                gravLocation = new PVector(x, y);
                mass = 10;
                
        }

        //repel mouse and gravitate towards gravTo point
        public void update() {
                applyMouseRejectForce();
                applyDissipativeForce();
                applyAttractiveForce();
                velocity.add(acceleration);
                location.add(velocity);
                acceleration.mult(0);
        }

        private int newColor() {
        	float w = random(0.3, 1.5);
                float ww = random(-1,1);
                return(color(44*(w+1), 117*(ww+1), 255));
        }

        void applyMouseRejectForce() {
                PVector mouseLocation = new PVector(mouseX, mouseY);
                PVector dir = PVector.sub(mouseLocation, location); //vector between particle and mouse
                float d = dir.mag(); //magnitude of the vector (lenght)
                if (d < minDistanceToMouse) {
                        dir.normalize();
                        float force = (strength * mass * mass) / (d * d);
                        dir.mult(force);
                        dir.mult(-1);
                        applyForce(dir);
                }
        }

        void applyDissipativeForce() {
                PVector f = PVector.mult(velocity, -friction);
                applyForce(f);
        }

        void applyAttractiveForce() {
                PVector dir = PVector.sub(gravLocation, location); //vector between particle and gravitation point
                float d = dir.mag(); //magnitude of the vector (lenght)
                if (d < minDistance) d = minDistance;
                dir.normalize();
                float force = (strength * mass * gravMass) / (d * d);
                dir.mult(force);
                applyForce(dir);
        }

        private void applyForce(PVector force) {
                acceleration.add(PVector.div(force, mass));
        }

        public void draw() {
                update();
                stroke(newColor());
                noFill();
                ellipse(location.x, location.y, drawSize, drawSize);
        }
}

public class PointFactory {
private ArrayList<PVector> points;
private int numberOfPoints;
private int border = 1;
private float brightnessThreshold;
private int maxDistanceToNextPoint;

public PointFactory(int nPoints, int border, float btr, int distNextP) {
  this.numberOfPoints = nPoints;
  this.border = border;
  this.brightnessThreshold = btr;
  this.maxDistanceToNextPoint = distNextP;
  //createPoints();
  //sortPoints();
}

/**
*Selects 'numberOfPoints' amount of random pixels (points)
*that have standard deviation of brightness greater than 'brightnessTresshold'
*in their neighborhood and saves them in 'points' arraylist.
*At the moment this function does not take in count the minimum distance between points
 **/
private void createPoints() {
  points = new ArrayList<PVector>();
  int failedTries = 0;
  for (int i = 0; i < numberOfPoints;) {
    //select a random point that is 'border' away from edges
    int x = border+(int)(random(width-2*border));
    int y = border+(int)(random(height-2*border));
    //get brightness deviation
    float contrast = standardDeviation(x,y);
    //If contrast is enough, point is probably a contour point and the point is added to list.
    if (contrast > brightnessThreshold) {
      // System.out.println("Success!");
      points.add(new PVector(x,y));
      failedTries = 0;
      i++;
    } else {
      failedTries++;
      if (failedTries > 20) {
        // System.out.println("Shieeeeet");
        brightnessThreshold *= 0.999; //lower the treshold when too many failed attempts. Value might not be right
        failedTries = 0;
      }
    }
  }
  sortPoints();
}
/**
*This method calculates the brightness variance and standard deviation of the pixels neighborhood.
*If the variance is high, pixel is probably a contour point (also called edgel).
*Neighborhood is (2*border+1)^2 pixels
 **/
private float standardDeviation(int posX, int posY) {
  float meanBrightness = 0;
  //get the total brightness sum of the pixels
  for (int x = -border; x<=border; x++) {
    for (int y = -border; y<=border; y++) {
      color c = img.pixels[(posY+y)*img.width+(posX+x)];
      meanBrightness += brightness(c);
    }
  }
  //meanBrightness is total brightness divided by number of pixels
  meanBrightness = meanBrightness/((float)((2*border+1)*(2*border+1)));
  //Variance is the average of the squared differences from the mean
  float brightnessVariance = 0;
  for (int x = -border; x<=border; x++) {
    for (int y = -border; y<=border; y++) {
      color c = img.pixels[(posY+y)*img.width+(posX+x)];
      //sum all squared differences from the mean
      brightnessVariance += ((brightness(c)-meanBrightness)*(brightness(c)-meanBrightness));
    }
  }
  //divide brightness variance sum by number of pixels
  brightnessVariance = brightnessVariance/((float)((2*border+1)*(2*border+1)));
  return sqrt(brightnessVariance); //return standard deviation
}

/**
*Sorts the points array list so that distance between two adjacent pixels
*is approximately lowes possible. If the distance is lower than maxDistanceToNextPoint,
*point is accempted as next point.
**/
private void sortPoints() {
  for (int i=0; i < numberOfPoints-1; i++) {
    double distance;
    double minDistance = width*height;
    int k = i+1;
    int indexOfminDistancePoint = k;
    int flag = 0;
    while (flag == 0 && k < numberOfPoints) {
      distance = points.get(i).dist(points.get(k));
      if (distance < maxDistanceToNextPoint) {
        PVector v = points.get(k);
        points.remove(k);
        points.add(i+1, v);
        flag = 1;
      } else {
        if (distance < minDistance) {
          minDistance = distance;
          indexOfminDistancePoint = k;
        }
        k++;
      }
    }
    if (flag == 0) {
      PVector v = points.get(indexOfminDistancePoint);
      points.remove(indexOfminDistancePoint);
      points.add(i+1, v);
    }
  }
}

public ArrayList<PVector> getNewPoints() {
  createPoints();
  return points;
}
}

