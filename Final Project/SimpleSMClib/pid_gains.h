#ifndef pid_gains_h
    #define pid_gains_h

    #include <Arduino.h>

    struct PIDGains {
        float kp, ki, kd;
    } __attribute__((packed));
#endif