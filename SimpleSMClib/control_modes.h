#ifndef control_modes_h
    #define control_modes_h

    #define CONTROL_MODES 2
    enum class ControlMode: uint8_t {
        POSITION,
        VELOCITY,
        NONE
    };
#endif