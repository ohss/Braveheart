public class Crawler {
	private ArrayList<Point> points;
	private ArrayList<Particle> particles = new ArrayList<Particle>();
	private int drawIndex = 0;
	private PointFactory pointFactory;
	private boolean useParticles;

	public Crawler (PointFactory pointFactory, boolean useParticles) {
		this.pointFactory = pointFactory;
		this.useParticles = useParticles;
		reset();
		
	}

	private void reset() {
		points = pointFactory.getNewPoints();
		if (useParticles) {
        	particles.clear();
			for (Point p : points){
				particles.add(new Particle(p.x, p.y));
			}
		}
        drawIndex = 0;
	}

	public void draw() {
		float w;
		float ww;
		int c;

		if (drawIndex == points.size()-2) {
                reset();
   
        } else {
         	for (int i = 0; i<drawIndex; i++){
         		w = random(0.3, 1.5);
				ww = random(-1,1);
				c = color(44*(w+1), 117*(ww+1), 255, 100);
				stroke(c);
				if (useParticles) {
     			particles.get(i).draw(c);
     			particles.get(i+1).draw(c);
     			}
     			line(points.get(i).x, points.get(i).y, points.get(i+1).x, points.get(i+1).y);
         	}
            drawIndex++;
        }
	}
}