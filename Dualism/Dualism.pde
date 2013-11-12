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

