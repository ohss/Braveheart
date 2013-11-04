
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
