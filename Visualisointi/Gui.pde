import controlP5.*;

public class Gui {
	ControlP5 cp5;

	Group asuminen;
	RadioButton energiatyyppi;
	RadioButton asumismuoto;
	Slider sisalampotila;

	Group jate;
	CheckBox kierratys;

	Group liikenne;
	Slider auto;
	Slider julkinen;
	Slider lento;

	Group kulutus;
	Slider kulutusViikossa;

	Group ruoka;
	CheckBox ruokavalio;
	Slider lihaa;
	Slider maitotuotteita;
	
	Toggle userChart;
	
	private int colorAsuminen, colorJate, colorLiikenne, colorKulutus, colorRuoka; 

	public Gui(PApplet parent) {
		this.colorAsuminen = getColorAsuminen();
		this.colorJate = getColorJate();
		this.colorKulutus = getColorKulutus();
		this.colorLiikenne = getColorLiikkuminen();
		this.colorRuoka = getColorRuoka();
		this.cp5 = new ControlP5(parent);
		cp5.setFont(createFont("",9));
		gui();
		cp5.getTooltip().setDelay(100);
		//tooltip käyttää control5p:n oletusfonttia, joka ei tue ääkkösiä. Vahitaminen ai näytä onnistuvan...
		cp5.getTooltip().register(kulutusViikossa, "Kulutustuotteiden, kuten elektroniikan ja vaatteiden (ei ruuan), euromaarainen kulutus viikossa");
	}

	private void gui() {
		asuminen();
		jate();
		liikenne();
		kulutus();
		ruoka();
		toggleUserChart();
	}
	
	

	private void toggleUserChart() {
		userChart = new Toggle(cp5, "");
		userChart
			.setValue(true)
			.setMode(ControlP5.SWITCH)
			.setSize(40, 20)
			.setPosition(3*width/4-20, 4*height/7+240);
	}

	private void asuminen() {
		
		asuminen = new Group(cp5, "asuminen");
		energiatyyppi = new RadioButton(cp5, "energiatyyppi");
		asumismuoto = new RadioButton(cp5, "asumismuoto");
		sisalampotila = new Slider(cp5, "sisälämpötila");

		asuminen
		.setColorForeground(colorAsuminen)
		.setColorBackground(colorAsuminen)
		.disableCollapse()
		.setBackgroundColor(color(0, 64))
		.setSize(240, 120)
		.setPosition(0, 15)
		.setBarHeight(15);

		energiatyyppi
		.setColorForeground(color(colorAsuminen, 200))
		.setColorActive(colorAsuminen)
		.setPosition(10, 5)
		.setItemWidth(20)
		.setItemHeight(20)
		.setItemsPerRow(1)
		.addItem("öljylämmitys", 0)
		.addItem("sähkölämmitys", 1)
		.addItem("kaukolämmitys", 2)
		.setColorLabel(color(255))
		.activate(2)
		.moveTo(asuminen);

		asumismuoto
		.setColorForeground(color(colorAsuminen, 200))
		.setColorActive(colorAsuminen)
		.setPosition(130, 5)
		.setItemWidth(20)
		.setItemHeight(20)
		.setItemsPerRow(1)
		.addItem("oma", 0)
		.addItem("rivi", 1)
		.addItem("kerros", 2)
		.setColorLabel(color(255))
		.activate(2)
		.moveTo(asuminen);
		
		sisalampotila
		.setColorActive(color(colorAsuminen, 200))
		.setColorForeground(colorAsuminen)
		.setNumberOfTickMarks(10)
		.setPosition(10, 80)
		.setSize(80, 20)
		.setRange(16, 25)
		.setValue(20)
		.moveTo(asuminen);
	}

	private void jate() {
		jate = new Group(cp5, "jäte");
		kierratys = new CheckBox(cp5, "kierrätys");
		
		jate
		.setColorForeground(colorJate)
		.setColorBackground(colorJate)
		.disableCollapse()
		.setBackgroundColor(color(0, 64))
		.setSize(240, 75)
		.setPosition(0, 150)
		.setBarHeight(15);
		;

		kierratys
		.setColorForeground(color(colorJate, 200))
		.setColorActive(colorJate)
		.setPosition(10, 5)
		.setItemWidth(20)
		.setItemHeight(20)
		.setItemsPerRow(1)
		.addItem("kierrätän biojatteita", 0)
		.addItem("kierrätän pahvia", 1)
		.addItem("kierrätän elektroniikkaa", 2)
		.setColorLabel(color(255))
		.moveTo(jate);
	}

	private void liikenne() {
		liikenne = new Group(cp5, "liikenne");
		auto = new Slider(cp5, "auto (km/viikko)");
		julkinen = new Slider(cp5, "julkinen (km/viikko)");
		lento = new Slider(cp5, "lento (km/vuosi)");
				
		liikenne
		.setColorForeground(colorLiikenne)
		.setColorBackground(colorLiikenne)
		.setColorLabel(color(100))
		.disableCollapse()
		.setBackgroundColor(color(0, 64))
		.setSize(240, 170)
		.setPosition(0, 240)	
		.setBarHeight(15)
		;

		auto
		.setColorValueLabel(color(100))
		.setColorActive(color(colorLiikenne, 200))
		.setColorForeground(colorLiikenne)
		.setPosition(10, 20)
		.setSize(80, 20)
		.setRange(0, 2000)
		.setValue(420)
		.moveTo(liikenne);
		
		julkinen
		.setColorValueLabel(color(100))
		.setColorActive(color(colorLiikenne, 200))
		.setColorForeground(colorLiikenne)
		.setPosition(10, 60)
		.setSize(80, 20)
		.setRange(0, 2000)
		.setValue(420)
		.moveTo(liikenne);
		
		lento
		.setColorValueLabel(color(100))
		.setColorActive(color(colorLiikenne, 200))
		.setColorForeground(colorLiikenne)
		.setNumberOfTickMarks(16)
		.setPosition(10, 100)
		.setSize(80, 20)
		.setRange(0, 30000)
		.setValue(0)
		.moveTo(liikenne);
		
	}

	private void kulutus() {
		kulutus = new Group(cp5, "kulutus");
		kulutusViikossa = new Slider(cp5, "kulutus viikossa (euroa)");
				
		kulutus
		.setColorForeground(colorKulutus)
		.setColorBackground(colorKulutus)
		.disableCollapse()
		.setBackgroundColor(color(0, 64))
		.setSize(240, 60)
		.setPosition(0, 410)
		.setBarHeight(15)
		;
		
		kulutusViikossa
		.setColorActive(color(colorKulutus, 200))
		.setColorForeground(colorKulutus)
		.setPosition(10, 20)
		.setSize(80, 20)
		.setRange(0, 200)
		.setValue(50)
		.moveTo(kulutus);
	}
	
	private void ruoka() {
		ruoka = new Group(cp5, "ruoka");
		ruokavalio = new CheckBox(cp5, "ruokavalio");
		lihaa = new Slider(cp5, "lihaa (pv/viikko)");
		maitotuotteita = new Slider(cp5, "maitotuotteita (pv/viikko)");
				
		ruoka
		.setColorForeground(colorRuoka)
		.setColorBackground(colorRuoka)
		.disableCollapse()
		.setBackgroundColor(color(0, 64))
		.setSize(240, 190)
		.setPosition(0, 480)
		.setBarHeight(15)
		;
		
		ruokavalio
		.setColorForeground(color(colorRuoka, 200))
		.setColorActive(colorRuoka)
		.setPosition(10, 5)
		.setItemWidth(20)
		.setItemHeight(20)
		.setItemsPerRow(1)
		.addItem("luomuruoka", 0)
		.addItem("lähiruoka", 1)
		.addItem("kausiruoka", 2)
		.setColorLabel(color(255))
		.moveTo(ruoka);
		
		lihaa
		.setColorActive(color(colorRuoka, 200))
		.setColorForeground(colorRuoka)
		.setPosition(10, 90)
		.setSize(80, 20)
		.setNumberOfTickMarks(8)
		.setRange(0, 7)
		.setValue(5)
		.moveTo(ruoka);
		
		maitotuotteita
		.setColorActive(color(colorRuoka, 200))
		.setColorForeground(colorRuoka)
		.setPosition(10, 140)
		.setSize(80, 20)
		.setNumberOfTickMarks(8)
		.setRange(0, 7)
		.setValue(7)
		.moveTo(ruoka);
	}
}
