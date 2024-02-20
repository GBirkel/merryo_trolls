         lst   on
* Sprite: Player v0.06
         lst   off

SH_Player   sep   #$20       ; actual entry point
         rep   #$10
         ldx   Tmp
         lda   SprI+5,x
         stz   SprI+5,x
         cmp   #$69       ; If 1st cycle
         beq   Player5    ; Set up index
         lda   SprI+3,x
         and   #$0F
         sta   JoystkHDir ; 1,2- Current index to records
         lda   SprI+3,x   ; 3- last joystick & buttons status
         and   #$F0       ; 4- duration counter
         sta   JoystkBtns01 ; 5- Very first cycle flag (1st=$69)
         lda   SprI+4,x   ; 6- Skript number
         beq   Player1
         dec   SprI+4,x
         rts
Player5  rep   #$20
         lda   SprI+6,x
         and   #$000F
         asl
         tay
         lda   Skriptz,y  ; Set skript location index
         sta   Player4+1
Player1  rep   #$20
         lda   SprI+1,x
         tay
Player4  lda   EndLevA,y  ; Get new status & index
         cmp   #$6969     ; "Return control" ending
         beq   Player2
         cmp   #$7734     ; "Enter door" ending
         bne   Player3
         stz   JoystkReadY  ; Make joystick go up to enter door
         bra   Player6
Player3  sta   SprI+3,x
Player6  iny
         iny
         tya
         sta   SprI+1,x
         sep   #$20
         rts
Player2  sep   #$20
         lda   #$C0       ; Turn off auto flag & NoPole flag
         trb   GameFlags
         jmp   KillDis

Skriptz  DA    Demo,EndLevA

EndLevA  HEX   0202030004190200000A020704020203
         HEX   04000300020034776969

Demo     HEX   0206040484090405020C040C84070400
         HEX   03000207040184018200020404058201
         HEX   0200820102080300040A020182038401
         HEX   04020300020F03158304030102030300
         HEX   04030300020E82038300840404168407
         HEX   04080206820283008401040102170403
         HEX   84038200020382040214030004008401
         HEX   040F8408040102058407040102060401
         HEX   030002050302020D030102100006800D
         HEX   0003010002036969
