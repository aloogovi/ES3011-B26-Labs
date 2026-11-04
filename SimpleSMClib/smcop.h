#ifndef smcop_h
    #define smcop_h

    #include <Arduino.h>

    enum class SMCOP: uint8_t {
        SET_ADDRESS,
        SET_GEAR_RATIO,
        SET_CPR,
        SET_SAMPLE_RATE,
        SET_DIRECTION,
        SET_PID_GAINS,
        HOME,
        WRITE_ANGLE,
        WRITE_RPM,
        SET_RETURN_MODE,
        SET_ACTIVE_WINDOW,
        SET_INTEGRAL_LIMIT,

        NUM // Number of SMC operations (must be last member)
    };
#endif