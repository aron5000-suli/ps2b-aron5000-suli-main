.intel_syntax noprefix

.section .text
.global _start
_start:
test1:
    mov rax, 1
    mov QWORD PTR [SUM_POSITIVE], 0
    mov QWORD PTR [SUM_NEGATIVE], 0

    mov rbx, OFFSET data_start

    jmp SHL_FRAG
test2:
    jmp SHL_FRAG
test3:
    jmp SHL_FRAG
test4:
    jmp SHL_FRAG

.section .data
data_start:
    .quad 1
    .quad 4
    .quad 100
    .quad -350
data_end:
    .quad 0x0
