.section    .text
.extern     _ZN16InterruptManager15handleInterruptEhj

.macro HandleInterruptRequest num
.global _ZN16InterruptManager26handleInterruptRequest\num\()Ev
    movb        $\num,(interruptnumber)
    jmp         int_bottom
.endm

   
HandleInterruptRequest 0x00
HandleInterruptRequest 0x01






int_bottom: 

    pusha
    pushl       %ds
    pushl       %es
    pushl       %fs
    pushl       %gs

    pushl       %esp
    push        (interruptnumber)
    call        _ZN16InterruptManager15handleInterruptEhj
    movl        %eax,%esp

    popl        %gs
    popl        %fs
    popl        %es
    popl        %ds
    popa

    iret

.section     .data
    interruptnumber: .byte 0


