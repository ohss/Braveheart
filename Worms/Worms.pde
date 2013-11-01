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

import java.awt.Point;

private String imageName = "image.jpg";
private PImage img;
private ArrayList<Crawler> crawlers = new ArrayList<Crawler>();
private ArrayList<Particle> particles = new ArrayList<Particle>();

private boolean drawModeLines = true;
private boolean modeSwitched = false;
private PImage bgImage;

private int numberOfPoints = 2000; //Range 1000-10 000. Very brute force.
private int border = 1; //This is used when the brightness variance of the neighborhood of a pixel is calculated
//Neighborhood is (2*border+1)^2 pixels. (1-3 are good values)
private float brightnessThreshold = 30; //range 5-50. Only pixels with greater brightness variance are selected
private int maxDistanceToNextPoint = 15; //used when approximating the sorting of points. In the end result, distances between last points tend to be long

public void setup(){
	background(0);
	setImage("./img/"+imageName);
	size(img.width, img.height);
	stroke(67,35,184);
	PointFactory pointFactory = new PointFactory(numberOfPoints, border, brightnessThreshold, maxDistanceToNextPoint);
	for (int i = 0; i<9; i++){
		crawlers.add(new Crawler(this, pointFactory));
	}
	for (Point p : pointFactory.getNewPoints()){
		particles.add(new Particle(p.x,p.y));
	}

}

private void setImage(String s) {
	img = loadImage(s);
	img.loadPixels();
}

public void switchDrawModeToParticles() {
	if (!modeSwitched) {
		modeSwitched = true;
		drawModeLines = false;
		saveFrame("bgImage.jpg");
		bgImage = loadImage("bgImage.jpg");
	}
}

public void draw() {
	if (drawModeLines) {
		for (Crawler c : crawlers){
			c.draw();
		}
	} else {
		background(bgImage);
		for (Particle p : particles){
			p.draw();
		}
	}
}

