
public class Data {
	private String name;
	private color c;
	private float angle;
	private float value;
	
	public Data(String name, color c, int value) {
		this.name = name;
		this.c = c;
		this.value = value;
	}

	public float getValue() {
		return value;
	}

	public void setValue(float value) {
		this.value = value;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getColor() {
		return c;
	}

	public void setColor(color c) {
		this.c = c;
	}

	public float getAngle() {
		return angle;
	}

	public void setAngle(float angle) {
		this.angle = angle;
	}
}
