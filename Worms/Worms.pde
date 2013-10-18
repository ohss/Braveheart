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
private int drawIndex = 0;
private ArrayList<Point> points = new ArrayList<Point>();
int numberOfPoints = 6000; //Range 1000-10 000. O(N^2) Very brute force implementations, KdTree could help or building a binary tree when adding points.
int border = 1; //This is used when the brightness variance of the neighborhood of a pixel is calculated
//Neighborhood is (2*border+1)^2 pixels. (1-3 are good values)
private float brightnessThreshold = 30; //range 5-50. Only pixels with greater brightness variance are selected
private int maxDistanceToNextPoint = 15; //used when approximating the sorting of points. In the end result, distances between last points tend to be long

public void setup(){
	setImage("./img/"+imageName);
	size(img.width, img.height);
	createPoints();
	sortPoints();
}
private void setImage(String s) {
	img = loadImage(s);
	img.loadPixels();
}
/**
Selects 'numberOfPoints' amount of random pixels (points)
that have standard deviation of brightness greater than 'brightnessTresshold'
in their neighborhood and saves them in 'points' arraylist.
At the moment this function does not take in count the minimum distance between points
 **/
private void createPoints() {
	int failedTries = 0;
	for (int i = 0; i < numberOfPoints;) {
		//select a random point that is 'border' away from edges
		int x = border+(int)(random(width-2*border));
		int y = border+(int)(random(height-2*border));
		//get brightness deviation
		float contrast = standardDeviation(x,y);
		//If contrast is enough, point is probably a contour point and the point is added to list.
		if (contrast > brightnessThreshold) {
			System.out.println("Success!");
			points.add(new Point(x,y));
			failedTries = 0;
			i++;
		} else {
			failedTries++;
			if (failedTries > 20) {
				System.out.println("Shieeeeet");
				brightnessThreshold *= 0.999; //lower the treshold when too many failed attempts. Value might not be right
				failedTries = 0;
			}
		}
	}
}
/**
This method calculates the brightness variance and standard deviation of the pixels neighborhood.
If the variance is high, pixel is probably a contour point (also called edgel).
Neighborhood is (2*border+1)^2 pixels
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
Sorts the points array list so that distance between two adjacent pixels
is approximately lowes possible. If the distance is lower than maxDistanceToNextPoint,
point is accempted as next point.
**/
private void sortPoints() {
	for (int i=0; i < numberOfPoints-1; i++) {
		double distance;
		double minDistance = width*height;
		int k = i+1;
		int indexOfminDistancePoint = k;
		int flag = 0;
		while (flag == 0 && k < numberOfPoints) {
			distance = points.get(i).distance(points.get(k));
			if (distance < maxDistanceToNextPoint) {
				Point p = points.get(k);
				points.remove(k);
				points.add(i+1, p);
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
			Point p = points.get(indexOfminDistancePoint);
			points.remove(indexOfminDistancePoint);
			points.add(i+1, p);
		}
	}
}
public void draw() {
	if (drawIndex == numberOfPoints-1) {
		noLoop();
	} else {
		line(points.get(drawIndex).x, points.get(drawIndex).y, points.get(drawIndex+1).x, points.get(drawIndex+1).y);
		drawIndex++;
	}
}
