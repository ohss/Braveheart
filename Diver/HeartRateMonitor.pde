/**
The class to handle heart rate-based control.
*/

/*
This Processing application (Easy_Pulse_PPG_Analyzer_V1.0) is developed for analyzing PPG waveform detected by Easy Pulse (V1.1) sensor, and
transferred to PC through Arduino or any other microcontroller platform using a serial interface. The application
displays the received PPG waveform on a graphical window, and also computes the instantaneous heart rate.

"Easy Pulse is designed for hobby and educational applications to illustrate the principle of photoplethysmography (PPG)
as a non-invasive optical technique for detecting cardio-vascular pulse wave from a fingertip. It uses an infrared light
source to illuminate the finger on one side, and a photodetector placed on the other side measures the small variations
in the transmitted light intensity. The variations in the photodetector signal are related to changes in blood volume
inside the tissue. The signal is filtered and amplified to obtain a nice and clean PPG waveform, which is synchronous with
the heart beat. For more details, visit http://embedded-lab.com/blog/?p=7336"

Name of application: Easy_Pulse_PPG_Analyzer_V1.0
Author: Rajendra Bhatt (http://embedded-lab.com)

This software is licensed under a Creative Commons Attribution-ShareAlike 3.0
*/

import processing.serial.*;

public class HeartRateMonitor {

  // Define signal parameters
  int Sampling_Time = 5;
  int Num_Samples = 600;
  int Peak_Threshold_Factor = 80;
  int Minimum_Range = 500;
  int Minimum_Peak_Separation = 50;  // 50*5=250 ms
  int Moving_Average_Num = 10;
  int Index1, Index2, Index3, i, j, k, ZeroFlag;
  float Pulse_Rate, Temp1, Peak1, Peak2, Peak3, PR1, PR2, ADC_Range;
  float Amplification_Factor,Peak_Magnitude, Peak_Threshold, Minima, Range, temp, Sum_Points,   Num_Points;
  float[] ADC_Value = new float[Num_Samples];
  int[] ADC_Index = new int[Num_Samples];

  //Serial port
  Serial myPort;

  //Heart rate
  private int heartRate;

  //Constructor
  public HeartRateMonitor(PApplet parent) {
    myPort = new Serial(parent, Serial.list()[0], 115200);
    myPort.bufferUntil('\n');
  }

  public int getHeartRate() {
    return heartRate;
  }
}
