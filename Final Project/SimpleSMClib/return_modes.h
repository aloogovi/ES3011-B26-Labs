#ifndef return_modes_h
    #define return_modes_h

    #define RETURN_MODES 4
    enum class ReturnMode: uint8_t {
        CONFIGS,
        POS_GAINS,
        VEL_GAINS,
        FEEDBACK,
        NONE
    };
#endif