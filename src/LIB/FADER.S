         LST   ON
* Color Fader v0.02 (c) ace 1994 - v0.02b garote 1994
*             v0.02c ace 1994
         LST   OFF

         DUM   ]ZPPlay
FadeRate DS    2
]ZPPlay      =     *
         DEND

FadeLoop php
         PHB
         PEA   #$0101
         Plb
         PLB
         REP   #$30

         lda   #$0010
         sta   Tmp2

         ldy   #$01fe
         lda   #$0
         tax
         sep   $20
]lp      lda   ShrA+$7e00,y
         and   #$0f       ;blu
         sta   Tmp
         ASLS  4
         sta   FadeWork,X
         lda   FadeDat,y
         and   #$0f
         sec
         sbc   Tmp
         sta   FadeVals,x
         lda   ShrA+$7e00,y ;grn
         and   #$f0
         sta   FadeWork+1,X
         LSRS  4
         sta   Tmp
         lda   FadeDat,y
         and   #$f0
         LSRS  4
         sec
         sbc   Tmp
         sta   FadeVals+1,x
         lda   ShrA+$7e01,y ;red
         and   #$0f
         sta   Tmp
         ASLS  4
         sta   FadeWork+2,x
         lda   FadeDat+1,y
         and   #$0f
         sec
         sbc   Tmp
         sta   FadeVals+2,x
         inx
         inx
         inx
         dey
         dey
         bpl   ]lp

]lp2     ldx   FadeRate
]lp      jsr   WaitSync
         dex
         bpl   ]lp
         inx
         ldy   #$1fe
]lp      lda   FadeWork,x ;blu
         clc
         adc   FadeVals,x
         sta   FadeWork,x
         LSRS  4
         sta   Tmp
         lda   FadeWork+1,x ;grn
         clc
         adc   FadeVals+1,x
         sta   FadeWork+1,x
         and   #$f0
         ora   Tmp
         sta   ShrA+$7e00,y
         lda   FadeWork+2,x ;red
         clc
         adc   FadeVals+2,x
         sta   FadeWork+2,x
         LSRS  4
         sta   ShrA+$7e01,y
         inx
         inx
         inx
         dey
         dey
         bpl   ]lp

         dec   Tmp2
         bne   ]lp2

         plb
         plp
         rts
