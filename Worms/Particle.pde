import java.awt.Point;

public class Particle {


	private int posX;
	private int posY;
	private int gravX = width/2;
	private int gravY = 4*height/5;
	private float VectorX;
	private float VectorY;

	public Particle (int x, int y) {
		this.posX = x;
		this.posY = y;
		// this.gravX = x;
		// this.gravY = y;
		this.VectorX  = 0.0;
		this.VectorY  = 0.0;
	}

	//repel mouse and gravitate towards gravTo point
	public void update() {
		//repel mouse
		// int distX = mouseX - posX;
		// int distY = mouseY - posY;
		// float dist = (float) Math.sqrt(distX * distX + distY * distY);
		// println("1 "+VectorX+" "+VectorY);
		// 	if (dist == 0) {dist = 0.01;}
		// 	float tx = mouseX - REPEL_MOUSE_MIN_DIST * distX / dist;
		// 	float ty = mouseY - REPEL_MOUSE_MIN_DIST * distY / dist;
		// 	VectorX += (tx - posX) * REPEL_MOUSE_FACTOR;
		// 	VectorY += (ty - posY) * REPEL_MOUSE_FACTOR;
		
		// println("2 "+VectorX+" "+VectorY);
		
		//gravitate towards gravTo point

		int distX = mouseX - posX;
		int distY = mouseY - posY;
		int signX = (int) Math.signum(distX);
		int signY = (int) Math.signum(distY);
		println(signX+" "+ signY);
		VectorX += signX * GRAVITATION / abs(0.1 * distX);
		VectorY += signY * GRAVITATION / abs(0.1 * distY);
		println("3 "+VectorX+" "+VectorY);
		
		//move
		float speed = (float) Math.sqrt(VectorX*VectorX + VectorY*VectorY);
		if (speed > MAX_SPEED) {
			VectorX = MAX_SPEED * VectorX / speed;
			VectorY = MAX_SPEED * VectorY / speed;
		}
		println("4 "+VectorX+" "+VectorY);
		posX += VectorX;
		posY += VectorY;
	}

	public void draw() {
		update();
		fill(255, 0, 0);
		ellipse(posX, posY, 50, 50);
		fill(255);
		ellipse(width/2, 4*height/5, 50, 50);
	}


}