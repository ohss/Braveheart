import java.math.BigDecimal;

import processing.core.*;

public class Charts {
	private Gui gui;
	private DataGroup userData;
	private DataGroup meanData;
	private PieChart meanPieChart;
	private PieChart userPieChart;
	private BarChart meanBarChart;
	private BarChart userBarChart;
	private Data asuminen, jate, liikkuminen, kulutus, ruoka, 
		keskAsuminen, keskJate, keskLiikkuminen, keskKulutus, keskRuoka;

		
	public Charts(Gui gui) {
		this.gui = gui;
		createUserDataGroup();
		createMeanDataGroup();
		this.userPieChart = new PieChart(userData, 3*width/4, 4* height/7);
		this.meanPieChart = new PieChart(meanData, 3*width/4, 4* height/7);
		this.userBarChart = new BarChart(userData, width/3, 6* height/7);
		this.meanBarChart = new BarChart(meanData, width/3+55, 6* height/7);
	}
	
	public void draw() {
		updateUserSettings();
		//meanData.update();
		userData.update();
		if (gui.userChart.getState()) {
			userPieChart.draw();			
		} else {
			meanPieChart.draw();			
		}
		meanBarChart.draw();
		userBarChart.draw();
		drawChartInfo();
		drawFlightDetails();
		hover();
	}
	
	private void hover() {
		int posX = 
		mouseX;
		int posY = 
		mouseY;
		int c = 
		get(posX, posY);
		String s;
		String st;
		if (c == meanData.getColor()) {
			displayTooltip(posX, posY, 150, 25, "TAVANOMAINEN SUOMALAINEN");
		} if (c== userData.getColor()) {
			displayTooltip(posX, posY, 55, 25, "KÄYTTÄJÄ");
		}
		if (gui.userChart.getState()){
			if (c == 
				getColorAsuminen()) {
				s = Float.toString(asuminen.getValue());
				st = Float.toString(round(asuminen.getValue()/userData.getSumValue()*100));
				displayTooltip(posX, posY, "ASUMINEN:\n"+s+" kg, \n"+st+" %");
			} if (c == 
				getColorJate()) {
				s = Float.toString(jate.getValue());
				st = Float.toString(round(jate.getValue()/userData.getSumValue()*100));
				displayTooltip(posX, posY, "JÄTE:\n"+s+" kg, \n"+st+" %");
			} if (c == 
				getColorKulutus()) {
				s = Float.toString(kulutus.getValue());
				st = Float.toString(round(kulutus.getValue()/userData.getSumValue()*100));
				displayTooltip(posX, posY, "KULUTUS:\n"+s+" kg, \n"+st+" %");
			} if (c == 
				getColorLiikkuminen()) {
				s = Float.toString(liikkuminen.getValue());
				st = Float.toString(round(liikkuminen.getValue()/userData.getSumValue()*100));
				displayTooltip(posX, posY, "LIIKKUMINEN:\n"+s+" kg, \n"+st+" %");
			} if (c == 
				getColorRuoka()) {
				s = Float.toString(ruoka.getValue());
				st = Float.toString(round(ruoka.getValue()/userData.getSumValue()*100));
				displayTooltip(posX, posY, "RUOKA:\n"+s+" kg, \n"+st+" %");
			} 
		} else {
			if (c == 
				getColorAsuminen()) {
				s = Float.toString(keskAsuminen.getValue());
				st = Float.toString(round(keskAsuminen.getValue()/meanData.getSumValue()*100));
				displayTooltip(posX, posY, "ASUMINEN:\n"+s+" kg, \n"+st+" %");
			} if (c == 
				getColorJate()) {
				s = Float.toString(keskJate.getValue());
				st = Float.toString(round(keskJate.getValue()/meanData.getSumValue()*100));
				displayTooltip(posX, posY, "JÄTE:\n"+s+" kg, \n"+st+" %");
			} if (c == 
				getColorKulutus()) {
				s = Float.toString(keskKulutus.getValue());
				st = Float.toString(round(keskKulutus.getValue()/meanData.getSumValue()*100));
				displayTooltip(posX, posY, "KULUTUS:\n"+s+" kg, \n"+st+" %");
			} if (c == 
				getColorLiikkuminen()) {
				s = Float.toString(keskLiikkuminen.getValue());
				st = Float.toString(round(keskLiikkuminen.getValue()/meanData.getSumValue()*100));
				displayTooltip(posX, posY, "LIIKKUMINEN:\n"+s+" kg, \n"+st+" %");
			} if (c == 
				getColorRuoka()) {
				s = Float.toString(keskRuoka.getValue());
				st = Float.toString(round(keskRuoka.getValue()/meanData.getSumValue()*100));
				displayTooltip(posX, posY, "RUOKA:\n"+s+" kg, \n"+st+" %");
			} 
		}
	}
	
	private float round(float f) {
        BigDecimal bd = new BigDecimal(Float.toString(f));
        bd = bd.setScale(2, BigDecimal.ROUND_HALF_UP);
        return bd.floatValue();
    }

	private void drawChartInfo(){
		
		fill(250,250,250);
		
		text("KOKONAISKULUTUS (co2)", userBarChart.getPosX(), meanBarChart.getPosY()+55);
		
		textAlign(PConstants.RIGHT);
		
		text("KÄYTTÄJÄN ARVOT", userPieChart.getPosX()-30, meanBarChart.getPosY()+55);
		
		textAlign(PConstants.LEFT);
		
		text("TAVANOMAISEN SUOMALAISEN ARVOT", userPieChart.getPosX()+30, meanBarChart.getPosY()+55);
		
		textSize(20);
		
		textAlign(PConstants.CENTER);		
		
		text("HIILIDIOKSIDIVERTAILIJA", 240+(
			width-240)/2, 35);
		
		textSize(16);
		
		textAlign(PConstants.LEFT);
		
		text("", 
			width/3, 100);
		
		textSize(9);
	}
	
	private void drawFlightDetails() {
		String s = "";
		int value = (int) gui.lento.getValue();
		if (value == 0) {
			s = "";
		} if (value == 2000) {
			s = "EDESTAKAISIN HELSINKI-BERLIINI";
		} if (value == 4000) {
			s = "EDESTAKAISIN HELSINKI-PARIISI";
		} if (value == 6000) {
			s = "EDESTAKAISIN HELSINKI-MADRID";
		} if (value == 8000) {
			s = "EDESTAKAISIN HELSINKI-KUWAIT";
		} if (value == 10000) {
			s = "EDESTAKAISIN HELSINKI-DELHI";
		} if (value == 12000) {
			s = "4 x EDESTAKAISIN HELSINKI-AMSTERDAM";
		} if (value == 14000) {
			s = "2 x EDESTAKAISIN HELSINKI-CAIRO";
		} if (value == 16000) {
			s = "EDESTAKAISIN HELSINKI-BANGKOK";
		} if (value == 18000) {
			s = "EDESTAKAISIN HELSINKI-CALIFORNIA";
		} if (value == 20000) {
			s = "EDESTAKAISIN HELSINKI-SINGAPORE";
		} if (value == 22000) {
			s = "4 x EDESTAKAISIN HELSINKI-BARCELONA";
		} if (value == 24000) {
			s = "2 x EDESTAKAISIN HELSINKI-MUMBAI";
		} if (value == 26000) {
			s = "EDESTAKAISIN HELSINKI-NEW YORK";
		} if (value == 28000) {
			s = "2 x EDESTAKAISIN HELSINKI-SHANGHAI";
		} if (value == 30000) {
			s = "EDESTAKAISIN HELSINKI-SYDNEY";
		} 
		
		text(s, 10, 380);
		
	}

	private void updateUserSettings() {
		ruoka();
		kulutus();
		liikkuminen();
		jate();
		asuminen();
	}
	
	private void displayTooltip(int posX, int posY, String s) {
		
		noStroke();
		
		fill(255,255,180,200);
		
		rect(posX-5,posY+20, 70, 55);
		
		triangle(posX-2,posY+20, posX+3, posY+16, posX+8, posY+20);
		
		fill(10);
		
		text(s, posX-2, posY+37);
		
		stroke(0);
	}
	
	private void displayTooltip(int posX, int posY, int width, int height, String s) {
		
		noStroke();
		
		fill(255,255,180,200);
		
		rect(posX-5,posY+20, width, height);
		
		triangle(posX-2,posY+20, posX+3, posY+16, posX+8, posY+20);
		
		fill(10);
		
		text(s, posX-2, posY+37);
		
		stroke(0);
	}

	private void ruoka() {

		float kaikki;
		float perusruoka = 1000;//kg per vuos
		float luomu = -100; 
		float lahi = -200;
		float kausi = -300;
		float lihatuotteita = 0;
		lihatuotteita = gui.lihaa.getValue()*2*52;
		float maitotuotteita = 0;
		maitotuotteita = (float) (gui.maitotuotteita.getValue()*0.65*52); // eli juusto
		float ruokavalio = perusruoka;
		if (gui.ruokavalio.getState(0)){
			ruokavalio = ruokavalio+luomu;
		} if (gui.ruokavalio.getState(1)){
			ruokavalio = ruokavalio+lahi;
		} if(gui.ruokavalio.getState(2)) { 
			ruokavalio = ruokavalio+kausi; 
		}
		
		kaikki = ruokavalio+lihatuotteita+maitotuotteita; 
												
		ruoka.setValue(kaikki);
	}

	private void kulutus() {
		
		double eurokerroin = 0.4;
		double menot = gui.kulutusViikossa.getValue();
		double loppupaastot = eurokerroin*menot*52;
		
		kulutus.setValue((float) loppupaastot);		
	}

	private void liikkuminen() {
		
		double autopaastot = 0.15; //kg/km
		double lentopaastot = 0.10;
		double julkinenpaastot = 0.05;
		double auto = gui.auto.getValue()*autopaastot*52;
		double lento = gui.lento.getValue()*lentopaastot;
		double julkinen = gui.julkinen.getValue()*julkinenpaastot*52;
		int kaikki = (int) (auto+lento+julkinen);
		
		liikkuminen.setValue(kaikki);
	}

	private void jate() {
		
		int normi = 185;
		int bio = -25;
		int pahvi = -60;
		int elektroniikka = -30;
		
		if (gui.kierratys.getState(0)){
			normi = normi+bio;					
		}
		if (gui.kierratys.getState(1)){
			normi = normi+pahvi;
		}
		if (gui.kierratys.getState(2)){
			normi = normi+elektroniikka;
		}
		jate.setValue(normi);
		//TODO
	}

	private void asuminen() {
		
		int perusosa=1000;
		if (gui.asumismuoto.getState(0)){
			perusosa = 1900;
		}
		if (gui.asumismuoto.getState(1)){
			perusosa = 1000;
		}
		if (gui.asumismuoto.getState(2)){
			perusosa = 550;
		}
		
		int energia = 3500;
		if (gui.energiatyyppi.getState(0)){
			energia = 3000;
		}
		if (gui.energiatyyppi.getState(1)){
			energia = 3500;
		}
		if (gui.energiatyyppi.getState(2)){
			energia = 3500;
		}
		
		int lampotila = (int) (150*gui.sisalampotila.getValue()-1800); // Ei ole merkityst√§
		
		int kaikki = 0;
		kaikki = energia+perusosa+lampotila;
		asuminen.setValue(kaikki);
	}
	
	private void createUserDataGroup() {
		asuminen = new Data("asuminen", 
			color(78,166,246), 0);
		jate = new Data("jate", 
			color(91,215,123), 0);
		liikkuminen = new Data("liikenne", 
			color(247,224,107), 0);
		kulutus = new Data("kulutus", 
			color(239,161,83), 0);
		ruoka = new Data("ruoka", 
			color(238,70,119), 0);
		
		userData = new DataGroup(asuminen, jate, liikkuminen, kulutus, ruoka, 
			color(244, 240, 236));
		userData.update();
	}

	private void createMeanDataGroup() {
		keskAsuminen = new Data("keskAsuminen", 
			color(78,166,246), 5800);
		keskJate = new Data("keskJate", 
			color(91,215,123), 180);
		keskLiikkuminen = new Data("keskLiikenne", 
			color(247,224,107), 4000);
		keskKulutus = new Data("keskKulutus", 
			color(239,161,83), 1300);
		keskRuoka = new Data("keskRuoka", 
			color(238,70,119), 1600);
		
		meanData = new DataGroup(
				keskAsuminen, keskJate, keskLiikkuminen, keskKulutus, keskRuoka,
				
				color(112, 128, 144));
		meanData.update();
	}
}
