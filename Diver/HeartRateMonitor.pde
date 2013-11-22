import processing.serial.*;
import cc.arduino.*;
import java.util.Iterator;
import java.util.LinkedList;

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
  private int index = 0;
  private float bpm = 0;

  private LinkedList<Integer> timestamps = new LinkedList<Integer>();

  float time = 0; //for debugging and running without arduino
  int timeReset = 0;

  //Constructor
  public HeartRateMonitor(int framerate, String name, Diver parent) {
    this.parent = parent;
    this.wait = 1000/framerate;
    this.id = name;
    this.running = false;
    this.arduino = new Arduino(parent, Arduino.list()[0], 57600);
    arduino.pinMode(ARDUINO_PULSE_IN, Arduino.INPUT);
    for (int i = 0; i < 5; i++) {
      timestamps.add(0);
    }
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

  // //Dummy method for running and debugging without arduino
  // public void run() {
  //   while (running) {
  //     float noise = 50*noise(0.05,time);
  //     bpm = 50+noise;
  //     time = time+.02;
  //     timeReset++;
  //     if (timeReset > 1000) {
  //       time = 0;
  //       timeReset = 0;
  //     }
  //     try {
  //       sleep((long)(wait));
  //     } catch (Exception e) {
  //     }
  //   }
  // }

  public void quit() {
    System.out.println("Quitting.");
    running = false;
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
        timestamps.add(interval);
        timestamps.removeFirst();
        Iterator it = timestamps.iterator();
        while (it.hasNext()) {
          int next = (Integer) it.next();
          totalInterval += next;
        }
        bpm = 60000/(float)totalInterval*5;
        totalInterval = 0;
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
