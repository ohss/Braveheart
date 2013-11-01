public class Crawler {
	private ArrayList<Point> points;
	private int drawIndex = 0;
	private PointFactory pointFactory;
	private boolean isFinished = false;
	private Worms parent;

	public Crawler (Worms parent, PointFactory pointFactory) {
		this.parent = parent;
		this.pointFactory = pointFactory;
		this.points = pointFactory.getNewPoints();
	}

	public void draw() {
		float w = random(0.3, 1.5);
		float ww = random(-1,1);
		stroke(44*(w+1), 117*(ww+1), 255, 100);
		if (drawIndex == points.size()-1) {
                parent.switchDrawModeToParticles();
        } else {
        	if (points.get(drawIndex).distance(points.get(drawIndex+1)) < 100) { //get rid of long lines
                line(points.get(drawIndex).x, points.get(drawIndex).y, points.get(drawIndex+1).x, points.get(drawIndex+1).y);
            }
            drawIndex++;
        }
	}

	public boolean isFinished() {
		return isFinished;
	}
}