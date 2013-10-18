import java.util.ArrayList;

import processing.core.PApplet;
import processing.core.PConstants;


public class DataGroup {
	private ArrayList<Data> datas = new ArrayList<Data>();
	public final int R_MULTIPLIER = 5;
	private float r;
	private float sumValue;
	private color c;
	
	
	public DataGroup(Data asuminen, Data jate, Data liikenne, Data kulutus,
			Data ruoka, color c) {
		datas.add(asuminen);
		datas.add(jate);
		datas.add(liikenne);
		datas.add(kulutus);
		datas.add(ruoka);
		this.c = c;
		update();
	}
	
	public void update() {
		updateSumValue();
		updateR();
		updateAngles();
	}

	private void updateAngles() {
		for (Data data : datas) {
			data.setAngle(data.getValue()/sumValue*360);
		}
	}
	
	private void updateR() {
		r = PApplet.sqrt(sumValue/PConstants.PI)*R_MULTIPLIER;
	}
	
	private void updateSumValue() {
		float newSumValue = 0;
		for (Data data: datas) {
			newSumValue += data.getValue();
		}
		sumValue = newSumValue;
	}
	
	public float getR() {
		return r;
	}


	public float getSumValue() {
		return sumValue;
	}
	
	public ArrayList<Data> getDatas() {
		return datas;
	}
	
	public int getColor() {
		return c;
	}
}
