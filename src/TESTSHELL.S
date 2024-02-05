         LST   OFF
PeaJumpPtr =     $000800    ; Long jump location (Important)
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
SprGuiTb =     $027000    ; MainChar sprites jmp table
SprLevTb =     SprGuiTb+$400 ; Other sprites jmp table
ErsGuiTb =     SprGuiTb+$800 ; MainChar eraser jmp table
ErsLevTb =     ErsGuiTb+$400 ; Other eraser jmp table
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

SprLevel =     $060000
ErsLevel =     $068000

BackFld  =     $070000    ; Background feild bank

ForeFld  =     $080000    ; Foreground field bank
SpriRaw  =     $081000    ; Original sprite pics
Blox     =     $080000    ; Original block set
Table    =     $08F000    ; Original table of block locations
TrashTbl =     $08f400    ; Table for duplicate checking

ShrB     =     $E12000

         DUM   $00
ST       DS    2          ; Stack storage
CLM      DS    2          ; Window column # on map
CLMs     DS    2          ; Window column # on map for MapBl
BK       DS    2          ; Strip pointer (0-4)
ClBk     DS    2          ; Block x 5 plus strip, for sprites
MapIndex DS    2          ; Starting position for troll
Tmp      DS    2          ; Temporary storage
Tmp2     DS    2          ; More Temporary storage
Tmp3     DS    2          ; Even more
Tmp4     DS    2          ; Yet more!
DCnt     DS    2          ; Update quantity reg counter
Mbl      DS    2          ; Main guy screen offset vsl
Mhb      DS    2          ; Horiz block location, leftmost=0
Mhs      DS    2          ; Horiz section location, leftmost=0
MhJ      DS    2          ; Horiz joystick level meter (+) = r (-) = l
MhK      DS    2          ; Horiz joystick dir (0=LF,1=L,2=M,3=R,4=RF)
Mhv      DS    2          ; Horiz velocity (+) = rigt (-) = left
Mvb      DS    2          ; Vertical block location, bottom=0
Mvs      DS    2          ; Vertical section location, bottom=0
Mvv      DS    2          ; Vertical velocity (+) = down, (-) = up
Mdir     DS    2          ; Bit 1=Troll dir.flag, Bit 7=Scroll dir.flag
NoFall   DS    2          ; Block under the moron flag 0=air 1=srfc
Yaxs     DS    2          ; Y axis (vertical!!!) offset storage
Xaxs     DS    2          ; X axis (Horizontal!) offset storage
JoyZ     DS    2          ; Joystick hold-down flag
Jcnt     DS    2          ; Joystick from-jump counter
VARX     DS    2          ; Joystick X axis read result
VARY     DS    2          ; Joystick Y axis read result
But01    DS    2          ; Status of buttons 0 and 1 this cycle (bits7,8)
Lupe     DS    2          ; Minor update loop byte(s)
Acnt     DS    2          ; Animation flags counter
Ahed     DS    2          ; Sprite for head
Alrm     DS    2          ; Sprite for left arm
Awlb     DS    2          ; Sprite for body section B
Artm     DS    2          ; Sprite for right arm
Awlk     DS    2          ; Sprite for feet
Amth     DS    2          ; Sprite for mouth
Ably     DS    2          ; Sprite for belly
Aeye     DS    2          ; Sprite for eye
Amtf     DS    2          ; Flag for mouth
AblC     DS    2          ; Flag for belly
Itm      DS    2          ; Item check temporary holder
Itm2     DS    2          ; Item check temporary storage 2
ErAc     DS    2          ; Number of active on-screen sprites
SpAc     DS    2          ; Number of active sprites
ErCn     DS    2          ; On-screen sprite currently processing
SpCn     DS    2          ; Active sprite currently processing
IMsp     DS    2          ; Left-scroll location in the map Sprite List
DMsp     DS    2          ; Right-scroll location in the map Sprite List
OVRt     DS    2          ; Blox over temp (for sprites)
DWNt     DS    2          ; Blox down temp (for sprites)
SizTotal DS    2          ; Total length of PEA field
SizStack DS    2          ; Initial entry point for stack when blitting
ExStats  DS    2          ; The extras flags (1=twist, 7=NoPole, 8=auto)
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
