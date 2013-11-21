import processing.serial.*;
import cc.arduino.*;

public class HeartRateMonitor extends Thread {
  private Diver parent;
  private boolean running;
  private int wait;
  private String id;

  private Arduino arduino;
  private int ARDUINO_PULSE_IN = 2;

  private int state = 0;
  private int read = 0;
  private int now;
  private int beatOn = 0;
  private int beatOff = 0;
  private int interval = 0;
  private int totalInterval = 0;
  private float bpm = 0;
  private int index = 0;

  //Constructor
  public HeartRateMonitor(int framerate, String name, Diver parent) {
    this.parent = parent;
    this.wait = 1000/framerate;
    this.id = name;
    this.running = false;
    this.arduino = new Arduino(parent, Arduino.list()[0], 57600);
    arduino.pinMode(ARDUINO_PULSE_IN, Arduino.INPUT);
  }

  public void start() {
    running = true;
    super.start();
    println("Starting thread (will execute every " + wait + " milliseconds.)");
  }

  public void run() {
    while (running) {
      read();
      try {
        sleep((long)(wait));
      } catch (Exception e) {
      }
    }
  }

  public void quit() {
    System.out.println("Quitting.");
    running = false;  // Setting running to false ends the loop in run()
    // IUn case the thread is waiting. . .
    interrupt();
  }

  private void read() {
    read = arduino.digitalRead(2);
    if (read == Arduino.HIGH && state == Arduino.LOW){
      now = millis();
      interval = now - beatOn;
      if (now - beatOff > 200) {
        state = Arduino.HIGH;
        parent.playHeartBeatSound();
        println(interval);
        beatOn = now;
        if (index < 5) {
          totalInterval += interval;
          index++;
        } else {
          bpm = 60000/(float)totalInterval*5;
          totalInterval = 0;
          index = 0;
        }
      }
    }

    if (read == Arduino.LOW && state == Arduino.HIGH) {
      now = millis();
      if (now - beatOn > 200) {
       state = Arduino.LOW;
       beatOff = now;
      }
    }
  }

  public float getPulse() {
    return bpm;
  }
}
