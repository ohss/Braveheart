public class Crawler {
	private ArrayList<Point> points;
	private int drawIndex = 0;

	public Crawler (PointFactory pointFactory) {
		this.points = pointFactory.getNewPoints();
	}

	public void draw() {
		float w = random(0.3, 1.5);
		float ww = random(-1,1);
		stroke(44*(w+1), 117*(ww+1), 255, 30);
		if (drawIndex == points.size()-1) {
                noLoop();
        } else {
        	if (points.get(drawIndex).distance(points.get(drawIndex+1)) < 50) { //get rid of long lines
                line(points.get(drawIndex).x, points.get(drawIndex).y, points.get(drawIndex+1).x, points.get(drawIndex+1).y);
            }
            drawIndex++;
        }
	}
}