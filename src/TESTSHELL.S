         LST   OFF
PeaJumpPtr =   $000800    ; Long jump location (Important)
ShelPage =     $001000    ; Shell/loader zero page
Zpl      =     $001100    ; Zero page location
AcidPtrn =     $001600    ; Acid land wave patterns
Loader   =     $009000

FadeDat  =     $010800
FadeWork =     $010a00
FadeVals =     $010d00
SHR      =     $012500    ; ShrA start of PEA window (standard)
ShrA     =     $012000

Char     =     $025000    ; Character set
GuidoSpriteJumpTable =     $027000    ; MainChar sprites jmp table
LevelSpriteJumpTable =     GuidoSpriteJumpTable+$400 ; Other sprites jmp table
GuidoEraserJumpTable =     GuidoSpriteJumpTable+$800 ; MainChar eraser jmp table
LevelEraserJumpTable =     GuidoEraserJumpTable+$400 ; Other eraser jmp table
MapBl    =     $028000    ; Map
MapSpr   =     MapBl+$C00 ; Map sprite list
MapVl    =     MapBl+$1000 ; Map call #'s
Connects =     MapBl+$2800 ; Map door connects
ClmInfo  =     MapBl+$2900 ; Map column flags
GenInfo  =     MapBl+$2A00 ; Map general info- time, name, etc.
LevPal   =     MapBl+$2d00 ; Map initial SCB arrangement and palette
MsgList  =     MapBl+$3000 ; Map message list
SprI     =     $02F000    ; Sprite data list
DraW     =     $02FC00    ; On-screen to-draw list

DestBnk  =     $030000
DestTabl =     $030100    ; Destination table
Dest     =     $030B00    ; Destination block set
Blok     =     $030000

Slots    =     $040000    ; Storage slots for levels

SprProg  =     $050000    ; These should match the spritemaker
SprGuido =     $050000
ErsProg  =     $058000    ; And the bank should match the one for
ErsGuido =     $058000
SprTable =     $05f800    ; Guido's sprites.
ErsTable =     $05fC00

LevelSprites = $060000
LevelErasers = $068000

BackgPeaField  =     $070000    ; Background feild bank

ForegPeaField  =     $080000    ; Foreground field bank
SpriRaw  =     $081000    ; Original sprite pics
Blox     =     $080000    ; Original block set
Table    =     $08F000    ; Original table of block locations
TrashTbl =     $08f400    ; Table for duplicate checking

ShrB     =     $E12000

         DUM   $00
ST       DS    2          ; Stack storage
WinXEdgeBlk DS    2       ; Window column # on map
WinXBlkIDsPtr DS    2     ; Window column # on map for MapBl
WinXEdgeBlkFifth DS    2  ; Strip pointer (0-4)
WinXEdgeTotalFifths DS 2  ; Block x 5 plus strip, for sprites
MapIndex DS    2          ; Starting position for troll
Tmp      DS    2          ; Temporary storage
Tmp2     DS    2          ; More Temporary storage
Tmp3     DS    2          ; Even more
Tmp4     DS    2          ; Yet more!
DCnt     DS    2          ; Update quantity reg counter
GPositionXScreenFifth DS 2 ; Main guy screen offset vsl
GPositionXBlk   DS 2      ; Horiz block location, leftmost=0
GPositionXFifth DS 2      ; Horiz section location, leftmost=0

JoystkHLev DS    2          ; Horiz joystick level meter (+) = r (-) = l
JoystkHDir DS    2          ; Horiz joystick dir (0=LF,1=L,2=M,3=R,4=RF)

GVelocityX      DS 2      ; Horiz velocity (+) = rigt (-) = left
GPositionYBlk   DS 2      ; Vertical block location, bottom=0
GPositionYSlice DS 2      ; Vertical section location, bottom=0
GVelocityY      DS 2      ; Vertical velocity (+) = down, (-) = up
GOnSolidGround  DS    2          ; Block under the moron flag 0=air 1=srfc
GYVectorRemaining     DS    2          ; Y axis (vertical!!!) offset storage
GXVectorRemaining     DS    2          ; X axis (Horizontal!) offset storage

Button0StillDown      DS    2          ; Joystick hold-down flag
JumpSustainCounter    DS    2          ; Joystick from-jump counter
JoystkReadX DS 2          ; Joystick X axis read result
JoystkReadY DS 2          ; Joystick Y axis read result
WindowedPEA DS 2          ; Windowed blitter routine PEA origin
WindowedGuido DS 2        ; Windowed blitter routine Guido drawing location
JoystkBtns01 DS 2         ; Status of buttons 0 and 1 this cycle (bits7,8)

Lupe     DS    2          ; Minor update loop byte(s)
Acnt     DS    2          ; Animation flags counter
GCurrentSpr_Head     DS 2 ; Sprite for head
GCurrentSpr_LArm     DS 2 ; Sprite for left arm
GCurrentSpr_LegB     DS 2 ; Sprite for body section B
GCurrentSpr_RArm     DS 2 ; Sprite for right arm
GCurrentSpr_LegA     DS 2 ; Sprite for feet
GCurrentSpr_Mouth    DS 2 ; Sprite for mouth
GCurrentSpr_Belly    DS 2 ; Sprite for belly
GCurrentSpr_Eye      DS 2 ; Sprite for eye
GBodyFlg_Tongue      DS 2 ; Flag for mouth
GBodyFlg_Facing      DS 2 ; Bit 1=Troll dir.flag, Bit 7=Scroll dir.flag
ItemCheckerTmp      DS    2          ; Item check temporary holder
ItemCheckerTmp2     DS    2          ; Item check temporary storage 2
SpritesOnScreenCnt     DS    2          ; Number of active on-screen sprites
SpritesActiveCnt DS 2     ; Number of active sprites
ErCn     DS    2          ; On-screen sprite currently processing
SpCn     DS    2          ; Active sprite currently processing
IMsp     DS    2          ; Left-scroll location in the map Sprite List
DMsp     DS    2          ; Right-scroll location in the map Sprite List
OVRt     DS    2          ; Blox over temp (for sprites)
DWNt     DS    2          ; Blox down temp (for sprites)
SizTotal DS    2          ; Total length of PEA field
PEAInitialStackPtr   DS 2 ; Initial entry point for stack when blitting
GameFlags DS   2          ; Flags for activating in-game extra features (1=twist, 7=NoPole, 8=auto)
Pal      DS    2          ; QM Palette cycle pointer
Pal2     DS    2          ; Logo palette cycle pointer
Score1   DS    8          ; Current score
Score2   DS    8          ; Amount to add to score
Time1    DS    3          ; Current time
Time2    DS    4          ; Amount to add to time + delay counter
FunkFlag DS    2          ; The vertical funk flag
FunkReg  DS    2          ; The vertical funk value reg
SlopeFlg DS    2
HeatCnt  DS    2
HeatSync DS    2
AcidIndx DS    2
         FIN
         DEND             ; Nifty, huh?

         LST   ON
* Testing shell v0.1 (c) garote 1994
         LST   OFF

ThisProg =     $002000

ASLS     MAC
         lup   ]1
         asl
         --^
         EOM

LSRS     MAC
         lup   ]1
         lsr
         --^
         EOM

         ORG   ThisProg
         LST   OFF

         CLC
         XCE
         SEP   $30

         lda   #$00
         sta   $c035
         LDA   #$80
         TSB   $C036
         LDA   #$C1
         TSB   $C029

         rep   #$30
         lda   #Zpl
         tcd
         ldx   #$7FFE
]lp      ldal  $012000,x
         stal  $090000,x
         dex
         dex
         bpl   ]lp

Aigh     PHP
         sep   #$20
         stal  $e1c010
]lp      ldal  $e1c000
         bpl   ]lp
         plp

         jsr   TestThis

         rep   #$30
         ldx   #$7FFE
]lp      ldal  $090000,x
         stal  $012000,x
         dex
         dex
         bpl   ]lp
         jmp   Aigh

         rep   #$30
         PEA   0000
         plb
         plb
         lda   #$0000
         Tcd
         sep   #$30
         sec
         xce
         rts

         MX    %00
         LST   ON
*
* currently testing:
         LST   OFF

TestThis =     *
         PUT   LIB/DEREZZ
