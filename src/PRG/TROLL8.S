         LST   ON
*  Trolls World 8 framework/shell v0.1d
*  Trolls World 8 player type [KQ] v0.1c
*  for world 8
*       (c) Garote '94
*
         lst   off
* type: KQ = Special 3-D PEA-cutting mode

         TR    ADR
         XC
         XC
         MX    %00

DoBlComp =     0          ; This has to show up in any TROLL# file
Flower   =     0          ; to remain compatible with all the PUT
Turtle   =     0          ; code objects.
BChester =     0
Snail    =     0
GdRecord =     0
Slope    =     0
VertFunk =     0
ScrlLeft =     0
HeatWave =     0
SizLine  =     $F0
CodeSiz  =     $00

]Z1      =     $00
]Z2      =     $00

         DUM   ]Z1        ;Zpage for all shell programs
WldNumb  DS    2          ; Globals
WldSect  DS    2          ; Map packet #
WldIndx  DS    2          ; Map index # (0-3)
LevLet   DS    2          ; Level letter
LevSect  DS    2          ; Level section letter
WldLives DS    2          ; Initial lives
WldScore ds    8          ; Initial score
WldCondt ds    2          ; Initial condition (0-3)
WldStats ds    2          ; Initial status (form)
TmpB     DS    2
]Z1      =     *
         DEND

         DUM   ]Z2
Tmp      DS    2          ; Temporary storage
Tmp2     DS    2          ; More Temporary storage
Tmp3     DS    2          ; Even more
Tmp4     DS    2          ; Shit, that's a lot...
Tmp5     ds    2          ; ...Or is it?
Tmp6     ds    2          ; Might be...
BackMask ds    2          ; Data mask storage
Pal2     DS    2          ; Logo palette cycle pointer
Score1   DS    8          ; Current score
Score2   DS    8          ; Amount to add to score
Time1    DS    3          ; Current time
Time2    DS    4          ; Amount to add to time + delay counter
AnimHed  DS    2          ; Status of head
AnimLeg  ds    2          ; Animation stage for leg
Face     DS    2          ; Current direction Guido faces
VARX     ds    2          ; Raw joystick X read
VARY     ds    2          ; Raw joystick Y read
FunkX    DS    2          ; Location of Guido on map X
FunkY    DS    2          ; Location of Guido on map Y
NewX     ds    2          ; Potential new Guido X location
NewY     ds    2          ; Potential new Guido Y location
FlagX    ds    2          ; Guido X location change flag
FlagY    ds    2          ; Guido Y location change flag
ColrStat ds    16         ; Flags for color transparency
]Z2      =     *
         DEND             ; Nifty, huh?

ASLS     MAC
         LUP   ]1
         asl
         --^
         EOM

LSRS     MAC
         LUP   ]1
         lsr
         --^
         EOM

PalNum   =     $10        ; Standard number of palletes to fade.

MMinXv   =     0          ; Full screen
MMaxXv   =     312        ; mouse window
MMinYv   =     8
MMaxYv   =     176

PA       =     $000800    ; Long jump location (Important)
ShelPage =     $001000    ; Shell/loader zero page
Zpl      =     $001100    ; Zero page location
Loader   =     $009000

SHR      =     $012500    ; ShrA start of PEA window (standard)
ShrA     =     $012000

ThisProg =     $020000
Char     =     $025000    ; Character set
FadeDat  =     $02FE00    ; Fader data

ForeFld  =     $030000    ; Storage slot for scene
RawSCB   =     $037D00    ; Scene SCB
RawPal   =     $037E00    ; Scene pallete
BackFld  =     $038000    ; Screen attributes field area
OverVals =     $03E400    ; background plane overlay values

SprGuido =     $040000

ShrB     =     $E12000

         TYP   $69

         ORG   ThisProg

         jmp   ProgBegn

]Z0      =     ]Z2
         PUT   BITS/CHARGEN

         PUT   BITS/MOUSE

         PUT   BITS/FADER
]Z2      =     ]Z0

ProgBegn SEC
         XCE
         SEP   #$30

]lp      LDA   $C02E
         CMP   #$F0
         BNE   ]lp        ; Wait 'till end of screen refresh
         LDA   #$00
         STA   $C035      ; Standard bank settings
         LDA   #$C1
         STA   $C029      ; Standard linear mapped SHR on
         CLC
         XCE
         REP   $30

         lda   #ShelPage
         tcd

         ldx   #$7FFe
         lda   #$0000     ; Blank SHR with zeros
]lp      stal  ShrA,x
         dex
         dex
         bpl   ]lp

         pea   #>ShrB
         plb
         plb
         ldx   #$7FFE
]lp      stz   ShrB,x     ; Blank screen, SCBs, pals
         dex
         dex
         bpl   ]lp
         lda   #$8080
         ldx   #$00C6
]lp      sta   ShrB+$7D00,x ; Make SBCs 640 mode
         dex
         dex
         bpl   ]lp
         lda   #$0FFF
         sta   ShrB+$7E1E ; White text
         sta   ShrB+$7E16
         sta   ShrB+$7E0E
         sta   ShrB+$7E06
         pea   #>ThisProg
         plb
         plb
         lda   #Zpl
         tcd
         jsr   MsgPrint
         HEX   FF00200A       ; C:H=32,V=10
         HEX   FF0300         ; C:Hm=0
         HEX   FF01FFFF       ; C:col=3
         HEX   FF020010       ; C:data offset = $1000
         HEX   58595E5F4243484952535C5D4E4F00 ; "LOADING "  (21)[21]
         HEX   FF020000                       ; C:data offset = $0000
         HEX   8B8495848B00D2CFD1C8D3C4D2 ; "LEVEL sprites" (13)[34]
         HEX   FFFF                       ; Command:finish

         rep   #$30
         lda   #ShelPage
         tcd
         lda   #$1F
         jsl   Loader     ; Level sprites
         lda   #Zpl
         tcd

         jsr   MsgPrint
         HEX   FF00200B               ; C:H=32,V=11
         HEX   FF01FFFF               ; C:col=3
         HEX   FF020010               ; C:data offset = $1000
         HEX   58595E5F4243484952535C5D4E4F00 ; "LOADING "  (21)[21]
         HEX   FF020000               ; C:data offset = $0000
         HEX   A6B4A8A3AE00D2CFD1C8D3C4D2 ; "GUIDO sprites" (13)[13]
         HEX   FFFF                   ; Command:finish

         rep   #$30
         lda   #ShelPage
         tcd
         lda   #$20
         jsl   Loader     ; Guido sprites

         rep   #$20
         lda   #$30
         jsl   Loader     ; 1st beef scene + background
         lda   #Zpl
         tcd
         rep   #$30

*-------------------------------Player

TrolPlay clc
         xce
         SEP   #$30
         pea   #>ThisProg
         plb
         plb
         rep   #$30
         lda   #Zpl
         tcd
         ldx   #$00FE
]lp      stz   $00,x      ; Clear the whole damn Zero Page
         dex
         dex
         bpl   ]lp
         lda   #$0A
         sta   Time2+3    ; Set timer delay
         lda   #MMinXv    ; Mouse setup
         sta   MMinX
         sta   MouseX
         lda   #MMaxXv
         sta   MMaxX
         lda   #MMinYv
         sta   MMinY
         sta   MouseY
         lda   #MMaxYv
         sta   MMaxY
         stz   Button
         lda   #$A0*MMinYv+MMinXv
         sta   OldMIndx

         lda   #ShelPage  ; Switch back to shelpage quickly
         tcd              ; to load more starting info
         sep   #$20
         lda   LevLet
         and   #$1f
         asl
         adc   #$82
         sta   LevelM
         inc
         sta   LevelM+1
         lda   WldLives
         and   #$0F
         asl
         adc   #$60
         sta   LivesM+2
         inc
         sta   LivesM+3
         lda   WldLives+1
         and   #$0F
         asl
         adc   #$60
         sta   LivesM
         inc
         sta   LivesM+1
         rep   #$30
         lda   #Zpl
         tcd
         sep   #$30
         ldx   #$00
]lp      ldal  WldScore+ShelPage,x  ; General Info:
         sta   Score1,x     ; $0-$1F:  Area Title
         clc                ; $20-$22: Initial calories
         adc   #$74
         sta   ScoreM,x
         inx
         cpx   #$08
         bne   ]lp
         ldx   #$00
         ldy   #$02
]lp      lda   #$09
         sta   Time1,x
         clc
         adc   #$74
         sta   TimeM,y
         inx
         dey
         bpl   ]lp

         lda   #$41       ; Pre-set SHR
         stal  #$E1C029
         lda   #$00
         stal  #$E1C035

         sep   #$20
         lda   #$01
         phb
         pha
         plb
         rep   #$30       ; Blank SHR
         ldx   #$7FFe
         lda   #$0000
]lp      sta   $2000,x
         dex
         dex
         bpl   ]lp
         plb

         rep   #$30       ; Move on screens
         ldx   #$63FE     ; ($A0 x 160) - 2
         phb
         pea   #>ForeFld
         plb
         plb
]lp      lda   ForeFld,x
         stal  SHR,x
         dex
         dex
         bpl   ]lp
         plb

         jsr   MsgPrint   ; Print the status bar:

         HEX   FF000000          ; C:H=0,V=0
         HEX   FF0300FF020010    ; C:Hm=0 C:data offset = $1000
         HEX   FF015555          ; C:col=funky
         HEX   26271a1c28290000          ; "SSMMTT  " (8)
         HEX   FF01FFFFFF020000          ; C:col=white C:offset=$0000
         HEX   92c2ced1c448                     ; "Score:" (6)
ScoreM   HEX   7474747474747474000088d3c4ccd248 ; "00000000  Items:" (16)
         HEX   3e5c3e5c3e5c3e5c0000           ; "=-=-=-=-  " (10)
         HEX   82c0cbced1c8c4d248               ; "Calories:" (9)
TimeM    HEX   7474740000020348          ; "000  @@:" (8)
LivesM   HEX   747474740000464748        ; "()()  HH:" (9)
DamageM  HEX   1617161716170000          ; "()()()  " (8)
WorldM   HEX   00005C                    ; "##-" (3)
         HEX   FF020010                  ; C:data offset = $1000
LevelM   HEX   8283       ; "##" (2)
         HEX   FF020000   ; C:data offset = $0000
         HEX   C0         ; "a" (1)
         HEX   FFFF       ; Command:finish

         rep   #$30
         ldx   #$01BE     ; Move in pallete data
]lp      ldal  RawPal,x   ; For picture
         sta   FadeDat,x
         dex
         dex
         bpl   ]lp

         ldx   #$0018     ; Make palette data
]lp      lda   #$0000         ; for font
         sta   FadeDat+$1e0,x
         lda   #$0555
         sta   FadeDat+$1e2,x
         lda   #$0AAA
         sta   FadeDat+$1e4,x
         lda   #$0FFF
         sta   FadeDat+$1e6,x
         txa
         sec
         sbc   #$0008
         tax
         bpl   ]lp

         ldx   #$009E     ; Move in scb data for picture
]lp      ldal  RawSCB,x
         stal  $019D08,x
         dex
         dex
         bpl   ]lp

         ldx   #$0006     ; Set SCBs for top text
         lda   #$8F8F
]lp      stal  $019d00,x
         dex
         dex
         bpl   ]lp

         ldx   #$001E     ; Set SCBs for bottom text
]lp      stal  $019da8,x
         dex
         dex
         bpl   ]lp

         lda   #$C1       ; Turn on SHR
         stal  #$E1C029
         jsr   FadeLoop

         rep   #$30
         lda   #40
         sta   FunkX
         lda   #80
         sta   FunkY
         lda   #$A0*8
         sta   AnimHed    ; Head
         lda   #$0000
         sta   AnimLeg    ; Feet

         sep   #$30
         ldx   #$0f
         lda   #$00
]lp      sta   ColrStat,x ; set up fake colrstat values
         dex
         bpl   ]lp
         rep   #$30

         lda   #$FFFF
         sta   ColrStat+7

]lp      jsr   JoyCrit    ; Update joystick, animation, & draw
         jsr   DoMouse
         jsr   PalUp
         rep   #$30
         lda   NewX
         sta   FunkX      ; Change movement
         lda   NewY
         sta   FunkY
         bra   ]lp

         rep   #$10
Hork2    sep   #$20
         stal  $e1c010
Hork     jsr   DoMouse
         jsr   PalUp
         sep   #$20
         ldal  $e1c000
         bpl   Hork
         cmp   #"q"
         bne   Hork2
         jmp   Quit


JoyCrit  rep   #$20
         STZ   VARX
         STZ   VARY
         SEP   $30
         LDAL  $E0C070
         LDY   #$60
]lp      LDAL  $E0C064
         BMI   *+6
         NOP              ; FTA's joystick routine
         NOP              ; /:)
         BRA   *+4
         INC   VARX
         LDAL  $E0C065
         BMI   *+6
         NOP
         NOP
         BRA   *+4
         INC   VARY
         LDAL  $E0C066
         BMI   *+6
         NOP
         NOP
         BRA   *+5
         NOP
         NOP
         NOP
         LDAL  $E0C067
         BMI   *+6
         NOP
         NOP
         BRA   *+5
         NOP
         NOP
         NOP
         BRA   *+2
         DEY
         BPL   ]lp

         rep   #$30
         LDA   VARX       ; Set X:
         ldx   #$FFFF
         cmp   #15        ; <-15--87->
         Bcc   Stork1     ; F Left
         inx
         cmp   #87
         Bcc   Stork1     ; Middle
         inx
Stork1   txa
         sta   FlagX
         clc
         adc   FunkX
         sta   NewX

         LDA   VARY       ; Set Y:
         ldx   #$FFFF
         cmp   #15        ; <-15--87->
         Bcc   Stork2     ; F Left
         inx
         cmp   #87
         Bcc   Stork2     ; Middle
         inx
Stork2   txa
         sta   FlagY
         clc
         adc   FunkY
         sta   NewY

         sep   #$30
         ldx   #$0F       ; Update background/foreground
]lp      ldy   #$FF       ; checks
         ldal  OverVals,x
         cmp   NewY
         bcs   NotLower
         ldy   #$00
NotLower tya
         sta   ColrStat,x
         dex
         bpl   ]lp
         rep   #$30

         lda   FlagX       ; Update animation
         beq   StillGuy
         inc
         beq   FaceCh
         lda   #$0A00
FaceCh   sta   Face       ; Change face
         lda   AnimLeg
         clc
         adc   #$00A0     ; Animate feet
         cmp   #$A0*8
         bne   StillGuy
         lda   #0
StillGuy sta   AnimLeg

         lda   FunkY      ; Draw Guido
         ASLS  2
         clc
         adc   FunkY
         ASLS  5
         clc
         adc   FunkX
         tax              ; FunkX + FunkY x$A0
         lda   AnimHed
         clc
         adc   Face
         tay
         phb
         pea   #>SprGuido
         plb
         plb
         lda   #$0001
         sta   Tmp3
]lp3     lda   #$000F
         sta   Tmp2
]lp2     lda   #$0004
         sta   Tmp
         ldal  ForeFld-$140C,x
         stal  SHR-$140C,x     ; Erase "window"

]lp      ldal  BackFld-$140A,x
         stx   Tmp4
         sty   Tmp5
         sta   Tmp6
         LDY   #$FFFF     ; Convert infronts to $0s,
         AND   #$F000     ; and behinds to $Fs
         xba
         LSRS  4
         tax
         lda   ColrStat,x ; if stat is zero
         and   #$00FF
         Beq   Thwack2    ; then object is behind
         TYA
         AND   #$0FFF
         TAY
Thwack2  lda   Tmp6
         and   #$0F00
         XBA
         tax
         lda   ColrStat,x
         and   #$00FF
         Beq   Chork3
         TYA
         AND   #$F0FF
         TAY
Chork3   lda   Tmp6
         AND   #$00F0
         LSRS  4
         tax
         lda   ColrStat,x
         and   #$00FF
         Beq   Smegma4
         TYA
         AND   #$FF0F
         TAY
Smegma4  lda   Tmp6
         AND   #$000F
         tax
         lda   ColrStat,x
         and   #$00FF
         Beq   Crocky5
         TYA
         AND   #$FFF0
         tay
Crocky5  sty   BackMask
         ldy   Tmp5
         ldx   Tmp4

         lda   SprGuido,y
         bne   NoCThru
         ldal  ForeFld-$140A,x ; Erase any residue
         bra   SeeThru
NoCThru  stx   Tmp4
         sty   Tmp5
         STA   Tmp6
         tax
         LDY   #$FFFF     ; Convert zeros to $0s,
         AND   #$F000     ; and nonzeros to $Fs
         Bne   Hack2
         TYA
         AND   #$0FFF
         TAY
Hack2    TXA
         AND   #$0F00
         Bne   Hork3
         TYA
         AND   #$F0FF
         TAY
Hork3    TXA
         AND   #$00F0
         Bne   Smek4
         TYA
         AND   #$FF0F
         TAY
Smek4    TXA
         AND   #$000F
         Bne   Croc5
         TYA
         AND   #$FFF0
         tay              ;  Sprite        Screen
Croc5    tya              ; #$0023>$00FF #$1113>$FFF0
         ldx   Tmp4

         and   BackMask
         tay
         eor   #$FFFF
         ANDL  ForeFld-$140A,x
         sta   Tmp4
         tya
         and   Tmp6
         ora   Tmp4
         ldy   Tmp5
SeeThru  STAL  SHR-$140A,x     ; This shouldn't >really< be here...
         iny              ; Boy I hope this works
         iny
         inx
         inx
         dec   Tmp
         bmi   Cuddly
         jmp   ]lp
Cuddly   ldal  ForeFld-$140A,x
         stal  SHR-$140A,x     ; Opposite edge of erase "window"
         txa
         clc
         adc   #$0096
         tax
         dec   Tmp2
         bmi   Furry
         jmp   ]lp2
Furry    lda   AnimLeg
         clc
         adc   Face
         tay
         dec   Tmp3
         bmi   Dammit
         jmp   ]lp3
Dammit   lda   #$0006
         sta   Tmp
]lp      ldal  ForeFld-$140C,x
         stal  SHR-$140C,x     ; Erase any residue in scanline
         inx                   ; immediately beneath Guido.
         inx
         dec   Tmp
         bpl   ]lp
         plb
         rts

Quit     clc
         xce
         rep   #$30
         lda   #ShelPage
         tcd
         pea   #>ShrB
         plb
         plb
         ldx   #$7FFE
]lp      stz   ShrB,x     ; Blank screen, SCBs, pals
         dex
         dex
         bpl   ]lp
         lda   #$8080
         ldx   #$00C6
]lp      sta   ShrB+$7D00,x ; Make SBCs 640 mode
         dex
         dex
         bpl   ]lp
         lda   #$0FFF
         sta   ShrB+$7E1E ; Attempt for white text
         sta   ShrB+$7E16
         sta   ShrB+$7E0E
         sta   ShrB+$7E06
         pea   #>ThisProg
         plb
         plb
         lda   #Zpl
         tcd

         jsr   MsgPrint
         HEX   FF00230B               ; C:H=35,V=11
         HEX   FF01FFFF               ; C:col=3
         HEX   FF020000               ; C:data offset = $1000
         HEX   E0E6E0E8ED5F00F85CED48 ; "AGAIN? Y-N:"        (11)[11]
         HEX   FFFF                   ; Command:finish
         rep   #$30
         lda   #ShelPage
         tcd
         sep   #$20
         LDa   #$C1
         STAl  $e1c029
         Jsr   WaitKey
         cmp   #"Y"       ; if yes, call Trolls
         beq   DuckPoop   ; player again.
         cmp   #"y"
         bne   *+5
DuckPoop jmp   TrolPlay
         brk   00
         brk   00

         lst   on
* World 8 pallete modifier v0.1b
         lst   off

PalUp    rep   #$30       ; SMT logo
         ldx   Pal2
         LDA   Palette+4,x
         phb
         pea   #$0101
         plb
         plb
         sta   $9FE2
         LDAl  Palette+2,x
         sta   $9FEA
         sta   $9FFA
         LDAl  Palette,x
         sta   $9FF2
         plb
         inc   Pal2
         inc   Pal2
         lda   Pal2
         cmp   #90
         bne   Dirk
         stz   Pal2
Dirk     RTS

Palette  DA    $80F,$81E,$82d,$83c,$84b,$85A,$869,$878
         DA    $887,$896,$8a5,$8b4,$8c3,$8d2,$8e1
         DA    $8F0,$8E0,$8d0,$8c0,$8b0,$8A0,$890,$880
         DA    $870,$960,$a50,$b40,$c30,$d20,$e10
         DA    $f00,$E01,$d02,$c03,$b04,$A05,$906,$807
         DA    $808,$809,$80A,$80B,$80C,$80D,$80E
         DA    $80F,$81E,$82d,$83c

         PUT   BITS/SCOREADD

         PUT   BITS/TIMEADD

         PUT   BITS/LIVESINC

         PUT   BITS/WAITSYN

         PUT   BITS/WAITKEY

         lst   on
*
*  Thanx to: Alex, Andy, Brad, Bradley, Brent, Emily, Fred,
*            Jon, Justin, Mike, Peter, Skot, Tara, and Zach.
*
*  Special special thanx to: The FTA
*
*  With a compliment to the author of this
*  incredible assembler, Glen Bredon.
*
*     :)
