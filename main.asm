use16
org 100h

;init graphics
push 0B800h
pop es
xor di, di
call HideCursor

;clear screen
mov cx, ScreenX * ScreenY
clear:
 mov [es:di], word Empty
 inc di
 inc di
loop clear
xor di, di

mainLoop:
 call CalcDI
 mov [es:di], word Smiley

 call GetKey
 call KeyHandle

 ;escape
 cmp ah, 1h
jnz mainLoop

;exit
int 20h

; === Functions ===
GetKey:
 mov ah, 10h
 int 16h
ret

KeyHandle:
 ;left
 cmp ah, 4Bh
 jnz @f
  mov [es:di], word Blue
  dec [y]
 @@:

 ;right
 cmp ah, 4Dh
 jnz @f
  mov [es:di], word Blue
  inc [y]
 @@:

 ;up
 cmp ah, 48h
 jnz @f
  mov [es:di], word Blue
  dec [x]
 @@:

 ;down
 cmp ah, 50h
 jnz @f
  mov [es:di], word Blue
  inc [x]
 @@:

 ;fix coord overflow
 cmp [x], 0
 jnl @f
  mov [x], 0
 @@:
 cmp [x], ScreenX - 1
 jng @f
  mov [x], ScreenX - 1
 @@:

 cmp [y], 0
 jnl @f
  mov [y], 0
 @@:
 cmp [y], ScreenY - 1
 jng @f
  mov [y], ScreenY - 1
 @@:
ret

HideCursor:
 mov ah, 2
 mov bh, 0
 mov dh, ScreenX
 int 10h
ret

CalcDI:
 mov di, [x]
 imul di, ScreenY
 add di, [y]
 shl di, 1
ret

; === Data ===
x dw 10
y dw 10

Smiley  = 1F01h
Empty   = 0020h
Blue    = 1F20h
ScreenX = 25
ScreenY = 80
