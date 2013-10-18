import processing.core.*;


public class BarChart {
	
	private DataGroup dataGroup;
	private int posX;
	private int posY;
		
	public BarChart(DataGroup dataGroup, int posX, int posY) {
		this.dataGroup = dataGroup;
		this.posX = posX;
		this.posY = posY;
	}
	
	public int getPosX(){
		return posX;
	}
	
	public int getPosY(){
		return posY;
	}

	public void draw() {
			fill(dataGroup.getColor());
			rect(posX, posY, 50, -dataGroup.getSumValue()/70);
			fill(250,250,250);
			text((int)dataGroup.getSumValue() + " kg", posX+3, posY+20);
	}
}