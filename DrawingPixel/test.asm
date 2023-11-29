.define CRT $0200                     
.define button_pressed $05              ; indirizzo in cui memorizzare il tasto premuto
.define old_button $06
.define ROW_LENGTH $07                  ; variabile per memorizzare il valore della lunghezza della riga
.org $8000

start:
    LDA #$02  
    STA CRT
    LDY #$0f
    STY ROW_LENGTH

wait_for_input:

    STA old_button
    LDA $4000
    BEQ wait_for_input

    CMP old_button                      ; if it's the same go back
    BEQ wait_for_input

    JSR clear_pixel

    STA button_pressed                  

    LSR A                       ; right shift
    BCS move_up               
        
    LSR A                       ; right shift
    BCS move_down

    LSR A                       ; right shift
    BCS move_left                 
        
    LSR A                       ; right shift
    BCS move_right                

    draw:
        LDA button_pressed
        JSR draw_pixel
        JMP wait_for_input
       

move_up:
    TXA
    SBC ROW_LENGTH
    TAX
    DEX
    LDA $00
    JMP draw

move_down:
    TXA
    ADC ROW_LENGTH
    TAX
    LDA $00
    JMP draw

move_right:
    INX
    JMP draw

move_left:
    DEX
    JMP draw

draw_pixel:
    STA $00
    LDA #$02
    STA CRT, X
    LDA $00
    RTS

clear_pixel:
    STA $00     ;memorizzo il valore di a 
    LDA #00     ; carico direttamente il valore 0
    STA CRT,X   ; lo memorizzo nella scheda grafica con un offset x
    LDA $00     ; ricarico nell'accumulatore il valore precedente
    RTS         ; esco dalla subroutine



.goto $fffa     ; fill the page

.dw start       ; OP code for interrupts
.dw start
.dw start