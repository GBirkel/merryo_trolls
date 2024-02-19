         lst   on
*
* Solid activator checker v0.2
         lst   off

         MX    %10
ChSolid  cmp   #BlkId_SolidActn10+1
         bcs   OutAHere
         cmp   #BlkId_SolidActn1
         bcs   ChSolid2   ; If it doesn't match the first time,
         adc   #BlkId_SolidActn1-BlkId_HiddenSld1 ; Add to it- in case it's invisible
         cmp   #BlkId_SolidActn10+1   ; and check again
         bcs   OutAHere
         cmp   #BlkId_SolidActn1
         bcc   OutAHere
ChSolid2 sta   Itm2
         rep   #$20
         and   #$00FF
         sec
         sbc   #BlkId_SolidActn1
         asl
         tax
         sep   #$20
         lda   Itm2
         jmp   (SldList,x)
OutAHere ldx   Itm
         rts

SldList  DA    Bl_Coin,Bl_Mushroom,Bl_Mushroom,Bl_Mushroom,Bl_Mushroom
         DA    Bl_Mushroom,Bl_Ladder,Bl_Breakable,Bl_Breakable,Bl_Message

* Action-solid 7: Ladder (not implemented)
Bl_Ladder jmp OutAHere

         lst   on
* Action-solid 1: Coin Block v0.02
         lst   off

         mx    %10
Bl_Coin  ldx   Itm
         lda   #BlkId_Solid
         sta   MapBl,x    ; Coin block is solid now
         lda   MapVl,x    ; Get the current coin pic value
         and   #$03       ; $01E0
         ora   #BlkPic_SolidEmpty      ; add standard offset to make it into
         sta   MapVl,x
         sta   Tmp3       ; it's respective empty box.
         stz   Tmp3+1
         rep   #$20
         jsr   BlokZap
         rep   #$10
         sep   #$20
         lda   #$05
         sta   Score2+1   ; Award 50 points for the coin
         jsr   ScoreAdd
         rep   #$31
         lda   SpritesActiveCnt
         ASLS  3          ; x8
         adc   SpritesActiveCnt ; x9
         tax              ; in X
         lda   #$0305
         sta   SprI,x     ; C: sets ID and anim. stage
         stz   SprI+2,x   ; C: clear flip counter
         lda   WinXEdgeBlk
         sec
         sbc   #$0010
         clc
         adc   OVRt
         sta   Tmp
         ASLS  2
         adc   Tmp        ; Current map block x5
         dec
         sta   SprI+4,x   ; C: Sets horizontal strip location
         lda   #$000b
         sec
         sbc   DWNt
         ASLS  4          ; x16
         inc
         sta   SprI+6,x   ; C: sets vertical line
         inc   SpritesActiveCnt
         sep   #$20
         lda   #$FF
         sta   SprI+8,x   ; Coin- Sets non-level I.D.
         rts

         lst   on
* Action-solid 2: Message Block v0.02
         lst   off

         MX    %10
Bl_Message rep   #$31
         lda   Itm
         tax
         ldy   #$0000
]lp      cmp   Connects,y ; Check the list for the message location
         beq   :Found
         LUP   8
         iny
         --^
         cpy   #$0100
         bne   ]lp
         bra   MesagEr    ; Not found?  Too bad, no message...
:Found   lda   Connects+2,y
         clc
         adc   #MsgList-1
         sty   Erotic+1
         jsr   Amused
         rep   #$10
         sep   #$20
         lda   #$01
         sta   Score2     ; Give the sucker 1 point
         jsr   ScoreAdd   ; for reading the message
         sep   #$20
]lp      ldal  $00c061    ; Wait for button up, then button down.
         bmi   ]lp
]lp      ldal  $00c061
         bpl   ]lp
         phb
         pea   #>SHR
         plb
         plb
         rep   #$30
         ldx   #$00c6
]lp      lda   $9d00,x    ; Reset changed scanlines
         sta   $9d00,x
         dex
         dex
         bpl   ]lp
         plb
Erotic   ldy   #$0000
Friction lda   Connects+4,y
         ldx   Itm
         and   #$0001       ; If the connects say so,
         bne   Splergh
MesagEr  sep   #$20         ; remove this message from the map
         lda   #BlkId_Solid
         sta   MapBl,x
         lda   #BlkPic_SolidEmpty+3
         sta   MapVl,x
         sta   Tmp3
         stz   Tmp3+1
         rep   #$20
         jsr   BlokZap-2
         rep   #$10
Splergh  sep   #$20
         rts              ; That's it.

Amused   pha
         jmp   MsgPrint

         lst   on
* Action-solid 3: Breakable Block v0.05
         lst   off

Bl_Breakable  ldx   Itm
         stz   MapBl,x    ; Change I.D to clear
         and   #$01       ; Set proper background
         sta   Tmp3
         stz   Tmp3+1
         lda   MapVl,x
         and   #$03
         sta   ST
         stz   ST+1
         lda   Tmp3
         sta   MapVl,x
         rep   #$20
         jsr   BlokZap-2
         rep   #$10
         sep   #$20
         lda   #$03
         sta   Score2     ; Give 3 points
         jsr   ScoreAdd   ; for bothering to break it
         rep   #$31
         lda   SpritesActiveCnt
         ASLS  3          ; x8
         adc   SpritesActiveCnt ; x9
         tax              ; in X
         lda   #$0101
         sta   SprI,x     ; set up "brick"
         sta   SprI+9,x   ; call #'s and stages
         clc
         adc   #$0100
         sta   SprI+18,x  ; for four new sprites
         sta   SprI+27,x
         lda   ST
         asl
         adc   ST         ; x3
         sta   SprI+11,x  ; brick
         sta   SprI+29,x  ; colors
         eor   #$8000     ; and directions
         sta   SprI+2,x   ; for the
         sta   SprI+20,x  ; new sprites
         lda   WinXEdgeBlk
         sec
         sbc   #$0010
         clc
         adc   OVRt
         sta   Tmp
         ASLS  2
         adc   Tmp        ; Current map block x5
         tay
         dec
         sta   SprI+4,x
         sta   SprI+22,x
         tya
         inc
         inc
         sta   SprI+13,x
         sta   SprI+31,x
         lda   #$000b
         sec
         sbc   DWNt       ; Blox down inverted
         ASLS  4          ; x16
         dec
         sta   Tmp
         lda   GVelocityY-1
         lsr
         and   #$7F00
         ORA   #$4000
         clc
         adc   Tmp        ; Put the freaks' velocity in the high byte
         sta   SprI+6,x
         sta   SprI+15,x
         clc
         adc   #$0308
         sta   SprI+24,x
         sta   SprI+33,x
         sep   #$20
         lda   #$FF
         sta   SprI+8,x   ; Put fake i.d.s in, since
         sta   SprI+17,x  ; these sprites didn't come from
         sta   SprI+26,x  ; the level list
         sta   SprI+35,x
         inc   SpritesActiveCnt
         inc   SpritesActiveCnt ; four new sprites
         inc   SpritesActiveCnt
         inc   SpritesActiveCnt
         ldx   Itm        ; --Check for coin above--
         lda   MapBl-1,x
         and   #$FD
         cmp   #BlkId_CoinA
         beq   *+3
         rts
         lda   MapBl-1,x
         stz   MapBl-1,x  ; Change I.D to clear
         and   #$02
         lsr
         sta   MapVl-1,x  ; Change screen I.D to background
         sta   Tmp3
         stz   Tmp3+1
         rep   #$20
         dex
         jsr   BlokZap
         rep   #$10
         sep   #$20
         lda   #$05
         sta   Score2+1   ; Award 50 points for the coin
         jsr   ScoreAdd
         rep   #$30
         lda   SpritesActiveCnt
         ASLS  3          ; x8
         adc   SpritesActiveCnt ; x9
         tax              ; in X
         lda   #$0305
         sta   SprI,x     ; C: sets ID and anim. stage
         stz   SprI+2,x   ; C: clear flip counter
         lda   WinXEdgeBlk
         sec
         sbc   #$0010
         clc
         adc   OVRt
         sta   Tmp
         ASLS  2
         adc   Tmp        ; Current map block x5
         dec
         sta   SprI+4,x   ; C: Sets horizontal strip location
         lda   #$000b
         sec
         sbc   DWNt
         ASLS  4          ; x16
         inc
         sta   SprI+6,x   ; C: sets vertical line
         inc   SpritesActiveCnt
         sep   #$20
         lda   #$FF
         sta   SprI+8,x   ; Coin- Sets non-level I.D.
         rts

         lst   on
* Action-solid 4: Mushroom Block v0.02
         lst   off

         MX    %10
Bl_Mushroom sec
         sbc   #BlkId_SolidActn1+1
         sta   Parakeet+1
         lda   #BlkId_Solid
         ldx   Itm
         sta   MapBl,x    ; Coin block is solid now
         lda   MapVl,x    ; Get the current coin pic value
         and   #$03
         ora   #BlkPic_SolidEmpty      ; add standard offset to make it into
         sta   MapVl,x
         sta   Tmp3       ; its respective empty box.
         stz   Tmp3+1
         rep   #$30
         jsr   BlokZap
         rep   #$30
         lda   SpritesActiveCnt
         ASLS  3          ; x8
         adc   SpritesActiveCnt ; x9
         tax              ; in X
         lda   #$0003
         sta   SprI+9,x   ; P: sets ID and anim. stage
         lda   #$0504
         sta   SprI,x     ; M: sets ID and pause counter
Parakeet lda   #$8000
         sta   SprI+2,x   ; M: Standard mushroom, Vv at $80
         lda   WinXEdgeBlk
         sec
         sbc   #$0010
         clc
         adc   OVRt
         sta   Tmp
         sta   SprI+6,x   ; M: sets HB, clears HS to 0
         ASLS  2
         adc   Tmp        ; Current map block x5
         dec
         sta   SprI+13,x  ; P: Sets horizontal strip location
         lda   #$000c     ; +1 for up one block
         sec
         sbc   DWNt
         sta   SprI+4,x   ; M: Sets VB, clears VS to 0
         ASLS  4          ; x16
         dec
         sta   SprI+15,x  ; P: sets vertical line
         inc   SpritesActiveCnt ; M
         inc   SpritesActiveCnt ; P
         sep   #$20
         lda   #$FF
         sta   SprI+17,x  ; P: Sets non-level I.D.
         sta   SprI+8,x   ; M: Sets non-level I.D.
         rts
