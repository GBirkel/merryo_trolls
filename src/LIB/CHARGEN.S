         lst   on
* 8x8 640 Character Generator v2.3
* (c) Garote '93
*
         lst   off

         DUM   ]ZPPlay    ; Message maker zp
Msg      DS    2          ; 8x8 char message indirect memory location
MsAND    DS    2          ; 8x8 char AND mask value storage
MsOFF    DS    2          ; 8x8 char data offset storage
MsH      DS    2          ; 8x8 char horizontal loc
MsV      DS    2          ; 8x8 char vertical location
MsHm     DS    2          ; 8x8 char horizontal left margin
]ZPPlay      =     *
         DEND             ; Nifty, huh?

MsgPrint rep   #$30
         pla
         inc
         sta   Msg
]lp      lda   (Msg)
         and   #$00ff
         inc   Msg
         cmp   #$00ff
         beq   CharSk1
         cmp   #$00FE
         bne   CharSk2

         lda   MsHm
         sta   MsH
         inc   MsV
         lda   MsV
         cmp   #$0024
         bcc   ]lp
         stz   MsV
         bra   ]lp

CharSk1  lda   (Msg)
         inc   Msg
         and   #$00FF
         cmp   #$00FF
         beq   CharRts
         asl
         tax
         jsr   (CharCmds,x)
         bra   ]lp

CharCmds DA    CharHV,CharAND,CharOFF,CharHm,CharWind

CharSk2  ASLS  4
         adc   MsOFF
         tay
         lda   MsV
         ASLS  2
         adc   MsV
         XBA              ; Vertical location x5, x$100
         lsr
         adc   MsH        ; plus the horizontal location,
         asl              ; shifted up and back to make it x2
         tax
         jsr   CharWrt
         inc   MsH
         lda   MsH
         cmp   #$0050     ; Width of screen (80 columns)
         bne   ]lp
         lda   MsHm
         sta   MsH
         inc   MsV
         lda   MsV
         cmp   #$0019     ; Length of screen (25 rows)
         bne   ]lp
         stz   MsV
         bra   ]lp

CharRts  lda   Msg
         dec
         pha
         rts

CharHV   lda   (Msg)
         sep   #$20
         sta   MsH
         xba
         sta   MsV
         rep   #$20
         inc   Msg
         inc   Msg
         rts

CharAND  lda   (Msg)
         sta   MsAND
         inc   Msg
         inc   Msg
         rts

CharOFF  lda   (Msg)
         sta   MsOFF
         inc   Msg
         inc   Msg
         rts

CharHm   lda   (Msg)
         and   #$00FF
         sta   MsHm
         inc   Msg
         rts

CharWind lda   (Msg)      ; Data: HA,VA,HB,VB
         and   #$00FF
         sta   MsH
         sta   Tmp3
         inc   Msg
         lda   (Msg)
         sta   Tmp
         and   #$003F
         ASLS  3
         sta   MsHm
         lsr
         adc   Tmp
         xba
         and   #$FF00
         sta   MsV
         inc   Msg
         lda   (Msg)
         tay
         and   #$007F
         dec
         sta   Tmp
         tya
         and   #$3F00     ; MsH, Tmp3 = Horizontal A
         xba              ; Tmp = Horizontal B - 1
         ASLS  3          ; MsHm = Vertical A x $8
         sta   Tmp2       ; MsV = Vertical A x $500
         inc   Msg        ; Tmp2 = Vertical B x $8
         inc   Msg        ; Tmp4 = value for scanlines
         lda   (Msg)
         and   #$000F
         sta   Tmp4
         xba
         ora   #$8080
         clc
         adc   Tmp4
         sta   Tmp4
         inc   Msg

         ldx   MsHm
         stal  #$E19d00,x ; 1st SCB
         stal  #$E19d02,x
         stal  #$E19d04,x
         stal  #$E19d06,x
         txa
         clc
         adc   #$0008
         sta   MsHm

         lda   MsH
         asl
         adc   MsV
         tax
         ldy   #$0280
         jsr   CharWrt
         inx
         inx
         ldy   #$0290     ; Draw UL corner
         jsr   CharWrt
         inc   MsH
         inc   MsH

         ldy   #$0300
         inx
         inx
]lp      jsr   CharWrt
         inx              ; Draw top line
         inx
         inc   MsH
         lda   MsH
         cmp   Tmp
         bne   ]lp

         ldy   #$02A0
         jsr   CharWrt
         inx
         inx
         ldy   #$02B0     ; Draw UR corner
         jsr   CharWrt
         lda   Tmp3
         sta   MsH
         lda   MsV
         clc
         adc   #$0500
         sta   MsV

]lp2     lda   MsH
         asl
         adc   MsV
         tax
         ldy   #$0320     ; Draw L side
         jsr   CharWrt
         inc   MsH

         ldy   #$0000
         inx
         inx
]lp      jsr   CharWrt
         inx
         inx              ; Draw blank bar
         inc   MsH
         lda   MsH
         cmp   Tmp
         bne   ]lp

         jsr   CharWrt
         inx
         inx
         ldy   #$0330     ; Draw R side
         jsr   CharWrt
         lda   Tmp3
         sta   MsH
         lda   MsV
         clc
         adc   #$0500
         sta   MsV

         ldx   MsHm
         lda   Tmp4       ; Set SCB
         stal  #$E19d00,x
         stal  #$E19d02,x
         stal  #$E19d04,x
         stal  #$E19d06,x
         txa
         clc
         adc   #$0008
         sta   MsHm

         cmp   Tmp2
         bcc   ]lp2

         lda   MsH
         asl
         adc   MsV
         tax
         ldy   #$02C0
         jsr   CharWrt
         inx
         inx
         ldy   #$02D0     ; Draw BL corner
         jsr   CharWrt
         inc   MsH
         inc   MsH

         ldy   #$0310
         inx
         inx
]lp      jsr   CharWrt
         inx
         inx
         inc   MsH        ; Draw bottom line
         lda   MsH
         cmp   Tmp
         bne   ]lp

         ldy   #$02E0
         jsr   CharWrt
         inx
         inx
         ldy   #$02F0     ; Draw BR corner
         jsr   CharWrt

         ldx   MsHm
         lda   Tmp4       ; Set SCB
         stal  #$E19d00,x
         stal  #$E19d02,x
         stal  #$E19d04,x
         stal  #$E19d06,x
         stz   MsH
         stz   MsV
         rts

CharWrt  phb
         pea   #>Char
         plb
         plb
         lda   Char+8,y
         and   MsAND      ; Special characters:
         stal  $E12280,x  ; FE = Carriage return
         lda   Char+10,y  ; FF = Command character
         and   MsAND
         stal  $E12320,x
         lda   Char+6,y
         and   MsAND
         stal  $E121e0,x
         LDa   Char,y     ; Command list:
         and   MsAND      ; (All preceded by an $FF)
         stal  $E12000,x  ; We're writing to the SUB screen ;)
         LDA   Char+2,y   ; 00 = set Htab byte, Vtab byte   (2)
         and   MsAND      ; 01 = set AND mask value         (2)
         stal  $E120a0,x  ; 02 = set character data offset  (2)
         LDA   Char+4,y   ; 03 = set horizontal left margin (1)
         and   MsAND      ; 04 = draw window, set scanlines (5)
         stal  $E12140,x  ; FF = end of message             (1)
         lda   Char+12,y
         and   MsAND
         stal  $E123c0,x
         lda   Char+14,y
         and   MsAND
         stal  $E12460,x
         plb
         rts
