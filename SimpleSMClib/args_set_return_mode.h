#ifndef args_set_return_mode_h
    #define args_set_return_mode_h

    #include <Arduino.h>
    #include "return_modes.h"

    struct ArgsSetReturnMode {
        ReturnMode return_mode;
    } __attribute__((packed));
#endif