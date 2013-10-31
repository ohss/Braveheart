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

private int numberOfPoints = 1000; //Range 1000-10 000. O(N^2) Very brute force implementations, KdTree could help or building a binary tree when adding points.
private int border = 1; //This is used when the brightness variance of the neighborhood of a pixel is calculated
//Neighborhood is (2*border+1)^2 pixels. (1-3 are good values)
private float brightnessThreshold = 30; //range 5-50. Only pixels with greater brightness variance are selected
private int maxDistanceToNextPoint = 1; //used when approximating the sorting of points. In the end result, distances between last points tend to be long

public void setup(){
	setImage("./img/"+imageName);
	size(img.width, img.height);
	PointFactory pointFactory = new PointFactory(numberOfPoints, border, brightnessThreshold, maxDistanceToNextPoint);
	for (int i = 0; i < 10; i++) {
		crawlers.add(new Crawler(pointFactory));
	}
}

private void setImage(String s) {
	img = loadImage(s);
	img.loadPixels();
}

public void draw() {
	for (Crawler c : crawlers) {
		c.draw();
	}
}

