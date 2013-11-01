/**
Studio 4 - Breveheart
Harkka 2: Tietokonetaide
Syksy 2013

Ispired by: http://www.openprocessing.org/sketch/59807
procsilas (procsilas@hotmail.com / http://procsilas.net)

**/

import java.awt.Point;

private String imageName = "image.jpg";
private PImage img;
private ArrayList<Crawler> crawlers = new ArrayList<Crawler>();
private ArrayList<Particle> particles = new ArrayList<Particle>();

private int numberOfPoints = 1000; //Range 1000-10 000. O(N^2) Very brute force implementations, KdTree could help or building a binary tree when adding points.
private int border = 1; //This is used when the brightness variance of the neighborhood of a pixel is calculated
//Neighborhood is (2*border+1)^2 pixels. (1-3 are good values)
private float brightnessThreshold = 30; //range 5-50. Only pixels with greater brightness variance are selected
private int maxDistanceToNextPoint = 15; //used when approximating the sorting of points. In the end result, distances between last points tend to be long

private static int REPEL_MOUSE_MIN_DIST = 50;
private static float REPEL_MOUSE_FACTOR = 0.2;
private static int GRAV_TO_POINT_FACTOR = 500;
private static float GRAVITATION = 9;
private static float MAX_SPEED = 50;
private static float RANDOM_MOTION_FACTOR = 5;

public void setup(){
	background(0);
	setImage("./img/"+imageName);
	size(img.width, img.height);
	// fill(0,0,0,20);
	stroke(67,35,184);
	PointFactory pointFactory = new PointFactory(numberOfPoints, border, brightnessThreshold, maxDistanceToNextPoint);
	for (int i = 0; i < 10; i++) {
		//crawlers.add(new Crawler(pointFactory));
		int x = (int) random(0, width);
		int y = (int) random(0, height);
		println(x+" "+y);
		particles.add(new Particle(x,y));
	}
}

private void setImage(String s) {
	img = loadImage(s);
	img.loadPixels();
}

public void draw() {
	background(0);
	// for (Crawler c : crawlers) {
	// 	c.draw();
	// }
	for (Particle p : particles) {
		p.draw();
	}
}

