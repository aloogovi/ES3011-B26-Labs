#ifndef SimpleSmartMotor_h
#define SimpleSmartMotor_h

#include <Arduino.h>
#include <Wire.h>
#include "smcop.h"
#include "control_modes.h"
#include "return_modes.h"
#include "feedback.h"

#define WRITE_DELAY_MS 6 // Time delay for each byte written to EEPROM

class SimpleSmartMotor {
  private:
    TwoWire* _wire;
    uint8_t _addr;
    bool _joined;
    ReturnMode _return_mode;

    void _read(uint8_t addr, void* dest, uint8_t pckt_sz);
    uint8_t _write(SMCOP op, void* target_ptr, uint8_t target_sz);
    uint8_t _tune_pid(ControlMode pid_mode, float kp, float ki, float kd);
    uint8_t _set_return_mode(ReturnMode return_mode);
    void _write_delay(uint8_t byte_num);
    
  public:
    SimpleSmartMotor(TwoWire& wire, uint8_t addr);
    bool begin();
    uint8_t tune_pos_pid(float kp, float ki, float kd);
    uint8_t tune_vel_pid(float kp, float ki, float kd);
    uint8_t home();
    uint8_t write_angle(float angle);
    uint8_t write_rpm(float rpm);
    float read_feedback();
};
#endif