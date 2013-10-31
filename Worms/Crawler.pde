public class Crawler {
	private ArrayList<Point> points;
	private ArrayList<Point> newPoints;
	private PointFactory pointFactory;
	private int drawIndex = 0;
	private int num = 0;

	public Crawler (PointFactory pointFactory) {
		this.pointFactory = pointFactory;
		this.points = pointFactory.getNewPoints();
	}

	public void draw() {
		if (newPoints != null){
			if (drawIndex == newPoints.size()-1){
			newPoints = points;
			newPoints = pointFactory.getNewPoints();
			}
		}	
		if (drawIndex == points.size()-1) {
			newPoints = pointFactory.getNewPoints();
			drawIndex = 0;
		} else {
			if (points.get(drawIndex).distance(points.get(drawIndex+1)) < 50){
					stroke(0);
					line(points.get(drawIndex).x, points.get(drawIndex).y, points.get(drawIndex+1).x, points.get(drawIndex+1).y);
			} 
			if (newPoints != null){
				if (newPoints.get(drawIndex).distance(newPoints.get(drawIndex+1)) < 50){
					stroke(180);
					line(newPoints.get(drawIndex).x, newPoints.get(drawIndex).y, newPoints.get(drawIndex+1).x, newPoints.get(drawIndex+1).y);
				}
			}
			drawIndex++;
		}
	}
}