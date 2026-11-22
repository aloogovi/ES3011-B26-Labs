#ifndef args_set_pid_gains_h
    #define args_set_pid_gains_h

    #include <Arduino.h>
    #include "control_modes.h"
    #include "pid_gains.h"

    struct ArgsSetPIDGains {
        ControlMode control_mode;
        PIDGains pid_gains;
    } __attribute__((packed));
#endif