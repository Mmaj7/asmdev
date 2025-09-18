format ELF64 executable

segment executable
_start:
	mov	rax, 1			; write
	mov	rdi, 1			; stdout
	mov	rsi, msg		; message
	mov	rdx, 50			; length
	syscall
	
	mov rax, 60
	mov rdi, 0
	syscall

segment writeable
	msg	db "hello world",13,10,0

segment readable
	val rb 5
