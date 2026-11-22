#include <Arduino.h>
#include <Wire.h>
#include <simplesmartmotor.h>

#define MS_PER_SEC 1000UL

SimpleSmartMotor motor(Wire,0x0A);

const uint8_t angle_num=2;
float angles[angle_num]={0.0f,360.0f*5}; // Set target angle
uint8_t angle_idx=0; // Index of the current target angle
uint32_t print_time_sec=20; // Print time in seconds
uint8_t delay_time_sec=10; // Print time in seconds

void setup() {
    Serial.begin(9600);
    while(!Serial);

    Wire.begin(); // Init master i2c device
    motor.begin(); // Init smartmotor
    
    motor.tune_pos_pid(1.0f,0.0f,0.0f); //  Tune position controller
    
    motor.write_angle(angles[angle_idx]); //  Reset position
    
    delay(2500); // Wait for 2.5 seconds
    Serial.println("Ready...");
}

void loop() {
    angle_idx=(angle_idx+1) % angle_num; // Increment angle index
    motor.write_angle(angles[angle_idx]); // Write target angle

    uint32_t start_time=millis();
    while (millis() - start_time <= print_time_sec * MS_PER_SEC) {
        Serial.print(angles[angle_idx]); // Print target angle
        Serial.print(",");
        Serial.println(motor.read_feedback()); // Print current angle 
        delay(20); // Wait 20 ms before next print
    }
    
    delay(delay_time_sec * MS_PER_SEC);
} 