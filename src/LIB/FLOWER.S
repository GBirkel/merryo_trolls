         lst   on
* Activator: Flower10 v0.02
         lst   off

* There are three triggers to deal with:
* A block with one left-facing flower (10),
* a block with one right-racing flower (01), and a block with both (11).
* In the case of the block with both, only one flower will be activated:
* The one leaning in the same direction Guido is facing.

         MX    %10
Flower10 sep   #$20
         lda   GBodyFlg_Facing ; If not facing forward,
         and   #$01            ; no valid contact.
         beq   :Continue
         rts
:Continue lda   #BlkId_Empty
         ldx   Itm
         sta   MapBl,x    ; Non-activating now
         lda   #$01
         sta   MapVl,x    ; Blank now
         sta   Tmp3       ; Erase block
         stz   Tmp3+1
         rep   #$20
         jsr   BlokZap
         rep   #$30
         lda   SpritesActiveCnt
         ASLS  3          ; x8
         adc   SpritesActiveCnt ; x9
         tax              ; in X
         lda   #IDFlower
         sta   SprI,x     ; Sets ID and anim. stage
         lda   #$0000     ; Sets type to L
         jmp   FlFinish   ; Code is identical from here on

         lst   on
* Activator: Flower01 v0.03
         lst   off

         MX    %10
Flower01 sep   #$20
         lda   GBodyFlg_Facing ; If not facing forward,
         and   #$01       ; no valid contact.
         bne   :Continue
         rts
:Continue lda   #BlkId_Empty
         ldx   Itm
         sta   MapBl,x    ; Non-activating now
         lda   #$01
         sta   MapVl,x    ; Blank now
         sta   Tmp3       ; Erase block
         stz   Tmp3+1
         rep   #$30
         jsr   BlokZap
         rep   #$30
         lda   SpritesActiveCnt
         ASLS  3          ; x8
         adc   SpritesActiveCnt ; x9
         tax              ; in X
         lda   #IDFlower
         sta   SprI,x     ; Sets ID and anim. stage
         lda   #$0003     ; Set type to R
         jmp   FlFinish

         lst   on
* Activator: Flower11 v0.05
         lst   off

         MX    %10
Flower11 sep   #$20
         lda   GBodyFlg_Facing ; If not facing forward,
         and   #$01       ; no valid contact.
         bne   Flowr11c
         lda   #BlkId_Sprt1+1
         ldx   Itm
         sta   MapBl,x    ; Different code now
         lda   #$38       ; L-flower block
         sta   MapVl,x    ; Blank now
         sta   Tmp3       ; Erase block
         stz   Tmp3+1
         rep   #$30
         jsr   BlokZap
         rep   #$30
         lda   SpritesActiveCnt
         ASLS  3          ; x8
         adc   SpritesActiveCnt ; x9
         tax              ; in X
         lda   #IDFlower
         sta   SprI,x     ; Sets ID and anim. stage
         lda   #$0000     ; Type to L
         bra   FlFinish   ; Code is identical from here on

         MX    %10
Flowr11c lda   #BlkId_Sprt1
         ldx   Itm
         sta   MapBl,x    ; Different code now
         lda   #$3A       ; R-flower block
         sta   MapVl,x    ; Blank now
         sta   Tmp3       ; Erase block
         stz   Tmp3+1
         rep   #$30
         jsr   BlokZap
         rep   #$30
         lda   SpritesActiveCnt
         ASLS  3          ; x8
         adc   SpritesActiveCnt ; x9
         tax              ; in X
         lda   #IDFlower
         sta   SprI,x     ; Sets ID and anim. stage
         lda   #$0003     ; Set type to R

FlFinish sta   SprI+2,x
         lda   WinXEdgeBlk
         sec
         sbc   #$0010
         clc
         adc   OVRt
         sta   Tmp
         ASLS  2
         clc
         adc   Tmp        ; Current map block x5
         dec
         sta   SprI+4,x   ; Sets horizontal strip location
         lda   #$000b
         sec
         sbc   DWNt
         ASLS  4          ; x16
         dec
         sta   SprI+6,x   ; Sets vertical strip location
         inc   SpritesActiveCnt
         sep   #$20
         lda   #$FF
         sta   SprI+8,x   ; Sets non-level I.D.
         lda   #$05
         sta   Score2
         jmp   ScoreAdd

         lst   on
* Sprite: Flower v0.02
         lst   off

SH_Flower rep   #$20       ; actual entry point
         ldx   Tmp
         lda   SprI+4,x
         cmp   WinXEdgeTotalFifths
         bcs   Flower1    ; Not on screen
         lda   WinXEdgeTotalFifths
         sec
         sbc   SprI+4,x
         cmp   #$004E
         bcs   Flower1    ; Not on screen
         sta   Tmp2
         lda   SprI+6,x   ; 1- animation stage (0-6,odd)
         and   #$00ff     ; 2- flower type x3 (L or R)
         sta   Tmp        ; 4,5- H strip
         ASLS  2          ; 6- V strip (bottom=1)
         adc   Tmp        ; Vert.strip x 5
         ASLS  4          ; x 80
         adc   Tmp2       ; plus horizontal offset
         sta   DraW+1,y
         sep   #$20
         lda   SprI+1,x   ; Current animation stage
         lsr              ; divided by 2
         clc              ; +
         adc   #$60       ; offset into sprite data
         clc              ; +
         adc   SprI+2,x   ; type of flower
         sta   DraW,y     ; = current sprite
         inc   SprI+1,x
         lda   SprI+1,x
         cmp   #$06
         beq   Flower1
         inc   SpritesOnScreenCnt       ; Update the animation frame
         rts
Flower1  jmp   KillDis
