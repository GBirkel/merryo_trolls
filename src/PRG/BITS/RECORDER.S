         lst   on
* Sprite: Recorder v0.02
         lst   off

Record   =     $0B0000    ; Temporary

Recorder sep   #$20       ; actual entry point
         rep   #$10
         ldx   Tmp
         lda   SprI+5,x
         stz   SprI+5,x
         cmp   #$69
         beq   Recordr3
         lda   SprI+3,x
         and   #$0F
         cmp   MhK        ; 1,2- Current index to records
         bne   Recordr1   ; 3- last joystick & buttons status
         lda   SprI+3,x   ; 4- duration counter
         and   #$F0       ; 5- Very first cycle flag (1st=$69)
         cmp   But01
         bne   Recordr1
         inc   SprI+4,x
         lda   SprI+4,x
         cmp   #$FF
         bne   Recordr2
Recordr1 rep   #$20
         txy
         lda   SprI+1,y
         tax
         lda   SprI+3,y   ; Save old status & index
         stal  Record,x
         inx
         inx
         txa
         sta   SprI+1,y
         sep   #$20
         ldx   Tmp         ; Get new status & reset index
Recordr3 stz   SprI+4,x
         lda   MhK
         ora   But01
         sta   SprI+3,x
Recordr2 rts
