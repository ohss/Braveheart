	private color colorAsuminen;
	private color colorJate;
	private color colorLiikkuminen ;
	private color colorKulutus;
	private color colorRuoka;
	private Gui gui;
	private Charts charts; 

	@Override
	public void setup() {
		size(1000, 700);
		textSize(9);
		colorAsuminen = color(78,166,246);
		colorJate = color(91,215,123);
		colorLiikkuminen = color(247,224,107);
		colorKulutus = color(239,161,83);
		colorRuoka = color(238,70,119);
		gui = new Gui(this);
		charts = new Charts(gui);
	}

	@Override
	public void draw() {
		background(100);
		charts.draw();
	}

	public color getColorAsuminen() {
		return colorAsuminen;
	}

	public color getColorJate() {
		return colorJate;
	}

	public color getColorLiikkuminen() {
		return colorLiikkuminen;
	}

	public color getColorKulutus() {
		return colorKulutus;
	}

	public color getColorRuoka() {
		return colorRuoka;
	}	

