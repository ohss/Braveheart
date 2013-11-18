import java.util.ArrayList;

public class PieChart {
	private ArrayList<Data> datas;
	private DataGroup dataGroup;
	private int posX;
	private int posY;
		
	public PieChart(DataGroup dataGroup, int posX, int posY) {
		this.dataGroup = dataGroup;
		this.datas = dataGroup.getDatas();
		this.posX = posX;
		this.posY = posY;
	}
	
	public ArrayList<Data> getDatas() {
		return datas;
	}

	public void draw() {
		//hint(PConstants.DISABLE_DEPTH_TEST);
		float lastAngle = 0;
		float r = dataGroup.getR();
		for (Data data : datas) {
			fill(data.getColor());
			arc(posX, posY, r, r, lastAngle, lastAngle+PApplet.radians(data.getAngle()));
			lastAngle += PApplet.radians(data.getAngle());
		}
		//hint(PConstants.ENABLE_DEPTH_TEST);
	}

	public int getPosX() {
		return posX;
	}

	public int getPosY() {
		return posY;
	}
}
