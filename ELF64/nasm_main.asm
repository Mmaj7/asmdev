global _start

section .text
_start:
	mov	rax, 1			; write
	mov	rdi, 1			; stdout
	mov	rsi, msg		; message
	mov	rdx, 50			; length
	syscall
	
	mov rax, 60
	mov rdi, 0
	syscall

section .data
	msg	db "hello world",13,10,0

section .bss
	val resb 5
