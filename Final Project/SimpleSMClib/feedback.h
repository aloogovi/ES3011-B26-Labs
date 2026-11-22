#ifndef feedback_h
    #define feedback_h

    # include <Arduino.h>

    struct Feedback {
        int32_t value;
    } __attribute__((packed));
#endif