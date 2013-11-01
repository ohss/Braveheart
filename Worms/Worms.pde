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

private int numberOfPoints = 5000; //Range 1000-10 000. O(N^2) Very brute force implementations, KdTree could help or building a binary tree when adding points.
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
	// for (int i = 0; i<3; i++){
	// 	crawlers.add(new Crawler(pointFactory, true));
	// }
	// for (int i = 0; i<7; i++){
	// 	crawlers.add(new Crawler(pointFactory, false));
	// }
	for (Point p : pointFactory.getNewPoints()){
		particles.add(new Particle(p.x,p.y));
	}
}

private void setImage(String s) {
	img = loadImage(s);
	img.loadPixels();
}

public void draw() {
	float w;
	float ww;
	int c;
	background(0);

	for (Particle p : particles){
		w = random(0.3, 1.5);
		ww = random(-1,1);
		c = color(44*(w+1), 117*(ww+1), 255, 100);
		p.draw(c);
	}
}

