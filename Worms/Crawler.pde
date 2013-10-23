public class Crawler {
	private ArrayList<Point> points;
	private int drawIndex = 0;

	public Crawler (PointFactory pointFactory) {
		this.points = pointFactory.getNewPoints();
	}

	public void draw() {
		if (drawIndex == points.size()-1) {
                noLoop();
        } else {
                line(points.get(drawIndex).x, points.get(drawIndex).y, points.get(drawIndex+1).x, points.get(drawIndex+1).y);
                drawIndex++;
        }
	}
}