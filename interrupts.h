#ifndef __INTERRUPTS_H
#define __INTERRUPTS_H

#include "types.h"
#include "port.h"
    class InterruptManager
    {
        public:
          static uint32_t handleInterrupt(uint8_t interruptNumber,uint32_t esp);

          static void handleInterruptRequest0x00();         
          static void handleInterruptRequest0x01();
    };

#endif
