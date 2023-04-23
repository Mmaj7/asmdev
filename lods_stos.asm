; lods/stosw example
org 100h

; init videobuffer
push 0B800h
pop es

; clear screen
xor di, di
mov cx, 2000
xor ax, ax
rep stosw

; draw string
xor di, di
mov ah, 31
mov si, mess
Next:
	lodsb
	stosw
	cmp byte [si], 0
jnz Next

; wait key
xor ah, ah
int 16h

; exit
ret

mess db 'Hello world', 0
