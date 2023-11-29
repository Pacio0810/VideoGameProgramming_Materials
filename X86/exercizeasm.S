bits 64

extern ExitProcess
extern InitWindow
extern BeginDrawing
extern ClearBackground
extern EndDrawing
extern DrawText
extern WindowShouldClose
extern SetTargetFPS
extern DrawRectangle
extern IsKeyDown
extern IsKeyPressed

start:
  sub rsp, 8

  sub rsp, 32
  mov rcx, 1024
  mov rdx, 768
  mov r8, wintitle
  call [InitWindow]
  add rsp, 32

  sub rsp, 32
  mov rcx, 60
  call [SetTargetFPS]
  add rsp, 32

gameloop:
  sub rsp, 32

  call [WindowShouldClose]
  cmp rax, 0
  jnz end

  call [BeginDrawing]
    
  mov rcx, 0xFFFFFFFF
  call [ClearBackground]

  jmp check_inputs

  ;DrawRectangle(int posX, int posY, int width, int height, Color color);

  draw:
    mov rcx, 0
    mov rdx, 700
    mov r8, 1024
    mov r9, 68

    sub rsp, 8
    mov rax, 0xFF000000   ; terrain
    push rax
    sub rsp, 32
    call [DrawRectangle]
    add rsp, 32
    add rsp, 8
    pop rax

    mov rcx, [player_pos_x]
    mov rdx, [player_pos_y]
    mov r8, 30
    mov r9, [player_height]

    sub rsp, 8
    mov rax, [player_color]  ; player color
    push rax
    sub rsp, 32
    call [DrawRectangle]
    add rsp, 32
    add rsp, 8
    pop rax

    call [EndDrawing]

    add rsp, 32

  jmp gameloop

check_inputs:

  mov rcx, 65             ; valore di A
  call [IsKeyDown]
  cmp rax, 1              ; verifico se premuto
  je key_A_pressed

  mov rcx, 68             ; valore di D
  call [IsKeyDown]
  cmp rax, 1              ; verifico se premuto
  je key_D_pressed

  mov rcx, 87             ; valore di W
  call [IsKeyPressed]
  cmp rax, 1              ; verifico se premuto
  je key_W_pressed

  mov rcx, 83             ; valore di W
  call [IsKeyPressed]
  cmp rax, 1              ; verifico se premuto
  je key_S_pressed

  mov rcx, 32             ; valore della SpaceBar
  call[IsKeyPressed]
  cmp rax, 1              ; verifico se premuto
  je key_SpaceBar_pressed

  jmp draw

key_SpaceBar_pressed :

  mov rcx, [player_color]  
  mov rax, [new_player_color]                 ; la spacebar cambia colore da rosso a verde e viceversa
  mov [player_color], rax
  mov [new_player_color], rcx

  jmp draw


key_A_pressed :
  
  dec dword [player_pos_x]                    ; premendo a il player si muove a sinistra
  jmp draw

key_D_pressed :
  
  inc dword [player_pos_x]                    ; premendo d il player si muove a destra
  jmp draw

key_W_pressed :
  
  mov ax, 0
  mov [player_pos_y], ax
  add dword [player_pos_y], 670               ; se il player e' abbassato si alza altrimenti non fa nulla
  mov [player_height], ax
  add dword [player_height], 30
  jmp draw

key_S_pressed :
  
  mov ax, 0
  mov [player_pos_y], ax                      ; se il player e' in piedi si alza abbassa altrimenti non fa nulla
  add dword [player_pos_y], 685
  mov [player_height], ax
  add dword [player_height], 15
  jmp draw

end:

  sub rsp, 32
  mov rcx, 100
  call [ExitProcess]
  add rsp, 32

  ret

section .data
wintitle:
db "PARKOUR", 0

player_height:
dq 30
player_pos_x:
dq 50
player_pos_y:
dq 670
player_color :
dq 0xFF0000FF
new_player_color :
dq 0xFF00FF00