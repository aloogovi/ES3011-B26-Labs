#include "simplesmartmotor.h"
#include "smc_header.h"
#include "args_set_pid_gains.h"
#include "args_set_return_mode.h"
#include "args_write_target.h"

SimpleSmartMotor::SimpleSmartMotor(TwoWire& wire, uint8_t addr) {
    _wire=&wire;
    _addr=addr;
    _joined=false;
    _return_mode=ReturnMode::NONE;
}

bool SimpleSmartMotor::begin() {
    _wire->beginTransmission(_addr);
    _joined=(_wire->endTransmission() == 0); // Returns true if device responds
    return _joined;
}

uint8_t SimpleSmartMotor::tune_pos_pid(float kp, float ki, float kd) {
    return _tune_pid(ControlMode::POSITION,kp,ki,kd);
}

uint8_t SimpleSmartMotor::tune_vel_pid(float kp, float ki, float kd) {
    return _tune_pid(ControlMode::VELOCITY,kp,ki,kd);
}

uint8_t SimpleSmartMotor::home() {
    uint8_t status=_write(SMCOP::HOME,nullptr,0); // SEND PACKET
    return status;
}

uint8_t SimpleSmartMotor::write_angle(float angle) {
    ArgsWriteTarget args{static_cast<int32_t>( angle * 10)};
    return _write(SMCOP::WRITE_ANGLE,&args,sizeof(args));
}

uint8_t SimpleSmartMotor::write_rpm(float rpm) {
    ArgsWriteTarget args{static_cast<int32_t>( rpm * 10)};
    uint8_t status=_write(SMCOP::WRITE_RPM,&args,sizeof(args));
    if (rpm == 0.0f) home(); // Reset motor to prevent jitter
    return status;
}
  
float SimpleSmartMotor::read_feedback() {
    if (_return_mode != ReturnMode::FEEDBACK)
        _set_return_mode(ReturnMode::FEEDBACK);

    Feedback fb;
    _read(_addr,&fb,sizeof(fb));
    return static_cast<float>(fb.value)/10.0f;
}

void SimpleSmartMotor::_read(uint8_t addr, void* dest, uint8_t pckt_sz) {
    if (!_joined) return;

    _wire->requestFrom(addr,pckt_sz); // REQUEST DATA FROM ADDRESS
    for (int i=0; i < pckt_sz; i++) { 
        *(((uint8_t*)dest)+i)= uint8_t(_wire->read()); 
    }
}

uint8_t SimpleSmartMotor::_write(SMCOP op, void* body_ptr, uint8_t target_sz) {
    if (!_joined) return 4; // Return error status

    SMCHeader header{op,target_sz}; // SET HEADER
    _wire->beginTransmission(_addr);
    _wire->write((uint8_t*)&header,sizeof(SMCHeader));
    _wire->write((uint8_t*)body_ptr,target_sz);
    return _wire->endTransmission();
}

uint8_t SimpleSmartMotor::_tune_pid(ControlMode control_mode, float kp, float ki, float kd) {
    if (kp < 0 || ki < 0 || kd < 0) return 4;
    
    ArgsSetPIDGains args{control_mode,{kp,ki,kd}};
    uint8_t status=_write(
        SMCOP::SET_PID_GAINS,
        &args,
        sizeof(args)
    );
    _write_delay(sizeof(args)); // Small delay after writing to EEPROM
    return status;
}

uint8_t SimpleSmartMotor::_set_return_mode(ReturnMode return_mode) {
    ArgsSetReturnMode args{return_mode};
    _return_mode=return_mode;
    return _write(
        SMCOP::SET_RETURN_MODE,
        &args,
        sizeof(args)
    );
}

void SimpleSmartMotor::_write_delay(uint8_t byte_num) {
    delay(byte_num*WRITE_DELAY_MS);
}