         LST   ON
*  Merryo Trolls loader v1.31n
*  Merryo Trolls player v1.8
*       (c) Garote '2024
*
         LST   OFF

         TR    ADR
         LSTDO OFF
*         CAS   SE  ; Merlin32 is case-sensitive by default and does not support this pseudo-opcode
         MX    %00

* We used to ask for the World we were building by waiting for keyboard input
* during assembly in Merlin 16.  KBD is not supported in Merlin32.
*World    KBD   "World number compiling for (1-7)"

* We used to define build flags by performing a calculation on the World number,
* using the result to trigger conditional code inclusion.
* Merlin32's compile sequence is different and cannot do this,
* so instead we stitch a WORLD#.S file to the beginning of this one before building.
*  DO    World-2/-1 ; Happy land
* BF_BlkComp  =     1
* ...
*  FIN
* DO    World-3/-1 ; Unhappy land
* ...
*  FIN

Debugger =     1

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

         PUT   LIB/MEMORYMAP
         TYP   $69
         ORG   ThisProg

         jmp   ProgBegn


* Zero page declared in TROLLS.System, and used during level building 
]ZPSys   =     $00

* Zero page for play mode, defined here in MAIN.S
]ZPPlay  =     $00

         DUM   ]ZPSys
WldNumb  DS    2          ; Globals
WldSect  DS    2          ; Map bundle # (maps are kept in bundles of 4)
WldIndx  DS    2          ; Map index # (0-3)
LevLet   DS    2          ; Level letter
LevSect  DS    2          ; Level section letter
WldLives DS    2          ; Initial lives
WldScore ds    8          ; Initial score
WldCndtn ds    2          ; Condition (0-3)
WldStats ds    2          ; Initial status (form)
TmpB     DS    2
]ZPSys   =     *
         DEND

         PUT   LIB/SPRITEMAKER

         DO    BF_BlkComp ; If we're compiling blocks, include the block maker
         PUT   LIB/BLOCKMAKER
         FIN

* Zero page while playing

         DUM   ]ZPPlay
ST               DS    2          ; Stack storage

MapIndex DS    2          ; Starting position for troll
Tmp      DS    2          ; Temporary storage
Tmp2     DS    2          ; More Temporary storage
Tmp3     DS    2          ; Even more
Tmp4     DS    2          ; Yet more!
DCnt     DS    2          ; Update quantity reg counter

WinXEdgeBlk      DS    2  ; Play window _right_edge_ X position on level map, in blocks
WinXBlkIDsPtr    DS    2  ; WinXEdgeBlk x12, used as a pointer into the level map IDs
WinXEdgeBlkFifth DS    2  ; Play window _right_edge_ X offset into one block, in fifths (0-4)
WinXEdgeTotalFifths DS 2  ; WinXEdgeBlk x 5 plus WinXEdgeBlkFifth, for sprites

GPositionXScreenFifth DS 2 ; Number of block fifths Guido is from the left edge of the _screen_
GPositionXBlk   DS    2   ; Horizontal block location on map, leftmost=0
GPositionXFifth DS    2   ; Horizontal sub-block location, in fifths (0-4) leftmost=0
GPositionYBlk   DS    2   ; Vertical block location, bottom=0
GPositionYSlice DS    2   ; Vertical sub-block location, bottom=0
GVelocityX      DS    2   ; Horiz velocity (+) = right (-) = left
GVelocityY      DS    2   ; Vertical velocity (+) = down, (-) = up
NoFall   DS    2          ; Block under the moron flag 0=air 1=srfc
Yaxs     DS    2          ; Y axis (vertical!!!) offset storage
Xaxs     DS    2          ; X axis (Horizontal!) offset storage

JoystkHLev DS    2        ; Horiz joystick level meter (+) = r (-) = l
JoystkHDir DS    2        ; Horiz joystick dir (0=LF,1=L,2=M,3=R,4=RF)
JoyZ     DS    2          ; Joystick hold-down flag
Jcnt     DS    2          ; Joystick from-jump counter
JoystkReadX DS 2          ; Joystick X axis read result
JoystkReadY DS 2          ; Joystick Y axis read result

WindowedPEA DS 2          ; Windowed blitter routine PEA origin
WindowedGuido DS 2        ; Windowed blitter routine Guido drawing location
JoystkBtns01 DS 2         ; Status of buttons 0 and 1 this cycle (bits7,8)

Lupe     DS    2          ; Minor update loop byte(s)
Acnt     DS    2          ; Animation flags counter
GCurrentSpr_Head     DS 2 ; Sprite for head
GCurrentSpr_Mouth    DS 2 ; Sprite for mouth
GCurrentSpr_Eye      DS 2 ; Sprite for eye
GCurrentSpr_RArm     DS 2 ; Sprite for right arm
GCurrentSpr_LArm     DS 2 ; Sprite for left arm
GCurrentSpr_Belly    DS 2 ; Sprite for belly
GCurrentSpr_LegA     DS 2 ; Sprite for feet
GCurrentSpr_LegB     DS 2 ; Sprite for body section B
GBodyFlg_Tongue   DS    2 ; Flag for mouth
GBodyFlg_Facing   DS    2 ; Bit 1: Guido's body. (1=Facing left)
Itm      DS    2          ; Item check temporary holder
Itm2     DS    2          ; Item check temporary storage 2
ErAc     DS    2          ; Number of active on-screen sprites
SpritesActiveCnt DS 2     ; Number of active sprites
ErCn     DS    2          ; On-screen sprite currently processing
SpCn     DS    2          ; Active sprite currently processing
IMsp     DS    2          ; Left-scroll location in the map Sprite List
         DO    BF_ScrlLft
DMsp     DS    2          ; Right-scroll location in the map Sprite List
         FIN
OVRt     DS    2          ; Blox over temp (for sprites)
DWNt     DS    2          ; Blox down temp (for sprites)
SizTotal DS    2          ; Total length of PEA field
SizStack DS    2          ; Initial entry point for stack when blitting
GameFlags DS   2          ; Flags for activating in-game extra features (1=twist, 7=NoPole, 8=auto)
Pal      DS    2          ; QM Palette cycle pointer
Pal2     DS    2          ; Logo palette cycle pointer
Score1   DS    8          ; Current score
Score2   DS    8          ; Amount to add to score
Time1    DS    3          ; Current time
Time2    DS    4          ; Amount to add to time + delay counter
Flashing DS    2          ; Flashing(hurt) Guido timer
         DO    BF_VrtFunk
FunkFlag DS    2          ; The vertical funk flag
FunkReg  DS    2          ; The vertical funk value reg
         FIN
         DO    BF_Slopes
SlopeFlg DS    2
         FIN
         DO    BF_HeatWav
HeatCnt  DS    2
HeatSync DS    2
AcidIndx DS    2
         FIN
]ZPPlay  =     *
         DEND             ; Nifty, huh?

         PUT   LIB/CHARGEN

         PUT   LIB/FADER

         PUT   LIB/PALUP

         DO    BF_TVScrns
         PUT   LIB/TVSCRNS
         FIN

*
* Various constants
*

EsqA            EQU $01C03E  ; Ensoniq Address reg
EsqC            EQU $01C03C  ; Ensoniq Control reg
EsqD            EQU $01C03D  ; Ensoniq Data reg

PalNum            EQU $10  ; Standard number of palletes to fade.
GVelocityHWalking EQU $82  ; Horizontal movement lower level (walking)
GVelocityHRunning EQU $86  ; Horizontal movement upper level (running)

* A key for interpreting the block IDs in the level map

BlkId_Empty       EQU $00  ; Clear invisible space i.d
BlkId_Sprt1       EQU $01  ; 1st clear sprite-activatior i.d
BlkId_Sprt8       EQU $08  ; 8th clear sprite-activatior i.d
BlkId_EmptyDeadly EQU $10  ; Clear deady block i.d
BlkId_Door        EQU $11  ; Clear door space i.d
BlkId_Pltfm       EQU $14  ; Straight platform i.d
BlkId_RevPltfm    EQU $15  ; Straight reverse platform i.d
         DO    BF_Slopes
BlkId_SlopeLeft   EQU $16  ; Left sloped platform i.d
BlkId_SlopeRight  EQU $17  ; Right sloped platform i.d
         FIN
BlkId_CoinA       EQU $1C  ; Coin with block $00 under
BlkId_FoodA       EQU $1D  ; Food with block $00 under
BlkId_CoinB       EQU $1E  ; Coin with block $A0 under
BlkId_FoodB       EQU $1F  ; Food with block $A0 under
BlkId_HiddenSld1  EQU $21  ; 1st hidden action solid i.d
BlkId_HiddenSld10 EQU $2A  ; 10th hidden action solid i.d
BlkId_PipeDown    EQU $2C  ; Entry down i.d (all solids past here)(usually)
BlkId_PipeUp      EQU $2D  ; Entry up i.d
BlkId_PipeRight   EQU $2E  ; Entry right i.d
BlkId_PipeLeft    EQU $2F  ; Entry left i.d
BlkId_Solid       EQU $30  ; Solid i.d
BlkId_SolidActn1  EQU $31  ; 1st action solid i.d
BlkId_SolidActn10 EQU $3A  ; 10th action solid i.d
         DO    BF_Buttons
BlkId_ButtonHalf  EQU $3B  ; Half-height button i.d , only useful if BF_Buttons = 1
         FIN
BlkId_SolidDeadly EQU $3F  ; Solid deadly block i.d

BlkPic_SolidEmpty EQU $48  ; Standard starting location of blank solids in blox MOD

* A key for the standard layout of Guido sprites/erasers in his set

GuidoSprId_LegB        EQU 16
GuidoSprId_Belly       EQU 25
GuidoSprId_ArmCarry    EQU 27
GuidoSprId_LeftArm     EQU 28
GuidoSprId_RightArm    EQU 36
GuidoSprId_HeadNormal  EQU 40
GuidoSprId_Horns       EQU 41
GuidoSprId_Shades      EQU 43
GuidoSprId_Beanie      EQU 44
GuidoSprId_MouthNormal EQU 48
GuidoSprId_TongueOut   EQU 51
GuidoSprId_EyesNormal  EQU 56
GuidoSprId_EyesClosed  EQU 57

* Animation frames for the standard Guido walk animation

GuidoWalk_LArm    DB    28,29,28,00,00,00,00,00
GuidoWalk_LegA    DB    00,01,02,03,04,05,06,07
GuidoWalk_LegB    DB    16,17,18,19,20,21,22,23
GuidoWalk_RArm    DB    36,35,36,37,38,39,38,37


ProgBegn SEC
         XCE
         SEP   #$30

]lp      LDA   $C02E
         CMP   #$F0
         BNE   ]lp        ; Wait 'till end of screen refresh
         STZ   $C035      ; Standard bank settings
         LDA   #$C1
         STA   $C029      ; Standard linear mapped SHR on
         CLC
         XCE
         REP   #$30

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
         lda   #World-1*2+$f
         jsl   Loader     ; Level sprites
         lda   #Zpl
         tcd

         jsr   MsgPrint
         HEX   FF001E0A               ; C:H=26,V=10
         HEX   FF01FFFF               ; C:col=3
         HEX   FF020010               ; C:data offset = $0000
         HEX   44456A6B52535859484952535C5D4E4F ; "BUILDING"  (16)[16]
         HEX   FF020000               ; C:data offset = $0000
         HEX   FFFF                   ; Command:finish

         rep   #$30
         lda   #ShelPage
         tcd
         stz   NumDone
         lda   #^SprLevel+$1000000
         sta   SprMkBnk
         jsr   SpriteMk
         rep   #$30
         LDA   #$7FFF     ; move level sprites out
         LDX   #SprProg
         LDY   #SprLevel
         MVN   SprProg,SprLevel
         LDA   #$7FFF     ; move level erasers out
         LDX   #ErsProg
         LDY   #ErsLevel
         MVN   ErsProg,ErsLevel
         LDA   #$03FF     ; move level sprite jumps out
         LDX   #SprTable
         LDY   #SprLevTb
         MVN   SprTable,SprLevTb
         LDA   #$03FF     ; move level eraser jumps out
         LDX   #ErsTable
         LDY   #ErsLevTb
         MVN   ErsProg,ErsLevTb
         pea   #>ThisProg
         plb
         plb
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
         lda   #World-1*2+$10
         jsl   Loader     ; Guido sprites

         lda   #Zpl
         tcd
         jsr   MsgPrint
         HEX   FF001E0B               ; C:H=26,V=10
         HEX   FF01FFFF               ; C:col=3
         HEX   FF020010               ; C:data offset = $1000
         HEX   44456A6B52535859484952535C5D4E4F ; "BUILDING"  (16)[16]
         HEX   FF020000               ; C:data offset = $0000
         HEX   FFFF                   ; Command:finish
         rep   #$30
         lda   #ShelPage
         tcd

         lda   #$00A0
         sta   NumDone
         lda   #^SprGuido
         sta   SprMkBnk
         jsr   SpriteMk
         rep   #$30
         LDA   #$7FFF     ; move level sprites out
         LDX   #SprProg
         LDY   #SprGuido
         MVN   SprProg,SprGuido
         LDA   #$7FFF     ; move level erasers out
         LDX   #ErsProg
         LDY   #ErsGuido
         MVN   ErsProg,ErsGuido
         LDA   #$03FF     ; move level sprite jumps out
         LDX   #SprTable
         LDY   #SprGuiTb
         MVN   SprTable,SprGuiTb
         LDA   #$03FF     ; move level eraser jumps out
         LDX   #ErsTable
         LDY   #ErsGuiTb
         MVN   ErsProg,ErsGuiTb
         pea   #>ThisProg
         plb
         plb
         lda   #Zpl
         tcd

         jsr   MsgPrint
         HEX   FF00200C               ; C:H=32,V=12
         HEX   FF01FFFF               ; C:col=3
         HEX   FF020010               ; C:data offset = $1000
         HEX   58595E5F4243484952535C5D4E4F00 ; "LOADING "  (21)[21]
         HEX   FF020000               ; C:data offset = $0000
         HEX   8BC4D5C4CB0081CBCEC2CAD2 ; "Level blocks" (12)[33]
         HEX   FFFF                   ; Command:finish
         rep   #$30
         lda   #ShelPage
         tcd

         lda   #World-1
         jsl   Loader     ; Blocks

         DO    BF_BlkComp
         lda   #World-1+8
         jsl   Loader     ; Block Table
         lda   #Zpl
         tcd
         jsr   MsgPrint
         HEX   FF001E0C               ; C:H=26,V=10
         HEX   FF01FFFF               ; C:col=3
         HEX   FF020010               ; C:data offset = $1000
         HEX   44456A6B52535859484952535C5D4E4F ; "BUILDING"  (16)[16]
         HEX   FF020000               ; C:data offset = $0000
         HEX   FFFF                   ; Command:finish
         rep   #$30
         lda   #ShelPage
         tcd
         jsr   BlokMakr   ; Build the blocks
         rep   #$20
         FIN

         DO    BF_HeatWav
         lda   #$0040
         jsl   Loader     ; Acid land patterns
         FIN

         DO    BF_SFXCode
         lda   #$0048
         jsl   Loader     ; Sound effects data
         FIN

         clc
         xce
         rep   #$30
         lda   #Zpl
         tcd
         lda   #40
         sta   GCurrentSpr_Head       ; Guido: head
         LDA   #48
         sta   GCurrentSpr_Mouth       ; Guido: mouth

NewPack  rep   #$20
         lda   #World-1*2+$21
         jsl   Loader     ; Map
         clc
         xce
         rep   #$30
         lda   #Zpl
         tcd

         DO    BF_SFXCode
         jsr   SFXsetup
         FIN

TrolPlay sep   #$20
         lda   #$00
         stal  $e1c022
         JSR   WaitSync
         LDa   #$41
         STAl  $e1c029    ; SHR off
         rep   #$31
         ldal  WldIndx+ShelPage-1
         and   #$0300     ;x$100
         ASLS  6          ;x$4000
         adc   #$3FFE
         tax
         ldy   #$3FFE
]lp      ldal  Slots,x    ; Transfer in an unaltered copy
         sta   MapBl,y    ; of the map from it's slot
         dex
         dex
         dey
         dey
         bpl   ]lp
         stz   WinXEdgeBlk ; Blank ONLY THE NEEDED zero page areas
         stz   WinXBlkIDsPtr
         stz   WinXEdgeBlkFifth
         stz   DCnt
         stz   GPositionXScreenFifth
         stz   GPositionXBlk
         stz   GPositionYSlice
         stz   GBodyFlg_Facing
         stz   JoyZ
         stz   Jcnt
         stz   JoystkBtns01
         stz   Acnt
         stz   GBodyFlg_Tongue
         stz   Pal
         stz   Pal2
         stz   Time2
         stz   Time2+2
         lda   #GuidoSprId_EyesNormal
         sta   GCurrentSpr_Eye       ; Guido: eye
         DO    BF_VrtFunk
         stz   FunkFlag
         stz   FunkReg
         FIN
         DO    BF_Slopes
         stz   SlopeFlg
         FIN
         sep   #$20
         lda   #$00
         STal  $e1C035    ; Shadow flags set
         ldal  LevLet+ShelPage
         ora   #$80
         stal  AreaRef    ; Show area letter
         rep   #$30
         ldal  WldLives+ShelPage
         clc
         adc   #$7474
         xba
         stal  LivesRef   ; Show lives
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
         sta   ShrB+$7E1E ; Make white text
         sta   ShrB+$7E16
         sta   ShrB+$7E0E
         sta   ShrB+$7E06
         pea   #>ThisProg
         plb
         plb

         jsr   MsgPrint
         HEX   FF002407               ; C:H=36,V=7
         HEX   FF01FFFF               ; C:col=3
         HEX   FF020000               ; C:data offset = $1000
         HEX   84CDD3C4D1C8CDC648     ; "Entering:" (9)[9]
         HEX   FF020010               ; C:data offset = $1000 MOD
         PUT   LIB/WORLDNAMES
         HEX   FF00250B   ; C:H=37,V=11
         HEX   FF020000   ; C:data offset = $0000
         HEX   80D1C4C000 ; "AREA " (5)[5]
AreaRef  HEX   7448       ; "#:"    (2)[7]
         HEX   FF00240f   ; C:H=36,V=15
         HEX   FF020000   ; C:data offset = $0000
         HEX   A6B4A8A3AE00d7         ; "GUIDO x" (7)[7]
LivesRef HEX   7474       ; "##"   (2)[9]
         HEX   FFFF       ; Command:finish

         rep   #$30
         lda   #$001f
         sta   Tmp
         ldx   #$416e
]lp      ldy   Tmp
         lda   GenInfo,y  ; Display area name
         and   #$00FF
         ASLS  4
         tay
         jsr   CharWrt
         dex
         dex
         dec   Tmp
         bpl   ]lp

         JSR   WaitSync
         sep   #$20
         LDa   #$C1
         STAl  $e1c029    ; SHR on
         rep   #$30

         ldy   #$0010     ; pause to show name
]lp2     ldx   #$0000
]lp      dex
         bne   ]lp
         dey
         bne   ]lp2

         sep   #$30
         JSR   WaitSync
         LDa   #$41
         STAl  $e1c029
         REP   #$30
         lda   #$0000
         ldx   #$7FFE
]lp      stal  $e12000,x
         dex              ; Blank the SHR screen,
         dex              ; Every scanline 320 mode
         bpl   ]lp        ; pointing to blank pallette 0.
         LDA   #^ForeFld
         STAl  PeaJumpPtr+2       ; Set the PEA bank jump address correctly
         stz   GameFlags  ; GameFlags all set standard off for now
         stz   MapIndex   ; MapIndex initially at first entry
         stz   GPositionXFifth
         lda   #$0A
         sta   Time2+3    ; Set timer delay
         lda   #GuidoSprId_LeftArm
         sta   GCurrentSpr_LArm       ; Guido: left arm
         stz   GCurrentSpr_LegA       ; Guido: leg section A
         lda   #GuidoSprId_LegB
         sta   GCurrentSpr_LegB       ; Guido: leg section B
         lda   #GuidoSprId_Belly
         sta   GCurrentSpr_Belly       ; Guido: belly
         lda   #GuidoSprId_RightArm
         sta   GCurrentSpr_RArm       ; Guido: right arm

         lda   #$0080     ; V and H velocity set to "Still"
         STA   GVelocityY
         STA   GVelocityX
         STA   JoystkHLev

         phd
         lda   #ShelPage  ; Switch back to shelpage quickly
         tcd              ; to load more starting info
         sep   #$30
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
         rep   #$21
         lda   #$1716     ; Display initial condition
         ldy   #$00
         ldx   WldCndtn
         beq   :Br1
]lp      sta   ConditnM,y
         iny
         iny
         dex
         bne   ]lp
:Br1     cpy   #$06
         beq   PostCond
         lda   #$1514
]lp      sta   ConditnM,y
         iny
         iny
         cpy   #$06
         bne   ]lp
PostCond pld
         sep   #$30
         ldx   #$07
]lp      ldal  WldScore+ShelPage,x  ; General Info:
         sta   Score1,x   ; $0-$1F:  Area Title
         adc   #$74       ; $20-$22: Initial calories
         sta   ScoreM,x
         stz   Score2,x   ; (blank score adder)
         dex
         bpl   ]lp
         ldx   #$00
         ldy   #$02
]lp      lda   GenInfo+$20,x
         sta   Time1,x
         clc
         adc   #$74
         sta   TimeM,y
         inx
         dey
         bpl   ]lp

         jsr   MsgPrint   ; Print the status bar:

         HEX   FF000000          ; C:H=0,V=0
         HEX   FF0300FF020010    ; C:Hm=0 C:data offset = $1000
         HEX   FF015555          ; C:col=funky
         HEX   26271a1c28290000          ; "SSMMTT  "   (8)[8]
         HEX   FF01FFFFFF020000          ; C:col=white C:offset=$0000
         HEX   92c2ced1c448              ; "Score:"     (6)[14]
ScoreM   HEX   7474747474747474000088d3c4ccd248 ; "00000000  Items:" (16)[30]
         HEX   3e5c3e5c3e5c3e5c0000      ; "=-=-=-=-  " (10)[40]
         HEX   82c0cbced1c8c4d248        ; "Calories:"  (9)[49]
TimeM    HEX   7474740000020348          ; "000  @@:"   (8)[57]
LivesM   HEX   747474740000464748        ; "()()  HH:"  (9)[66]
ConditnM HEX   1617161716170000          ; "()()()  "   (8)[74]
         DFB   World*2+$60,World*2+$61   ; "##"         (2)[76]
         HEX   5CFF020010                ; "-"          (1)[77] C:data offset = $1000
LevelM   HEX   8283       ; "##" (2)[79]
         HEX   FF020000   ; C:data offset = $0000
         HEX   C0         ; "a" (1)[80]
         HEX   FFFF       ; Command:finish

NewLoc2  rep   #$30
         stz   WinXEdgeBlkFifth
         stz   Flashing
         lda   #BF_SizLine*$C0 ; x192
         sta   SizTotal
         lda   #$9cff
         sta   SizStack
         sep   #$20
         lda   #$41
         stal  $e1c029    ; Turn off SHR for now
         rep   #$30
         ldx   #$0000
]lp      lda   LevPal,x   ; Move up the level's scb info
         stal  $019d00,x  ; and pals
         inx
         inx
         cpx   #$0300
         bne   ]lp
         sep   #$20
         ldx   MapIndex
         LDA   Connects+3,x
         STA   GPositionYBlk
         lda   Connects+5,x
         and   #$07
         sta   GPositionXFifth
         DO    BF_HeatWav
         lda   Connects+6,x
         asl
         sta   AcidIndx+1
         FIN
         lda   Connects+2,x
         STA   GPositionXBlk  ; Coordinates at MapIndex
         sec
         sbc   Connects+4,x
         sta   Tmp
         ASLS  2
         adc   Tmp
         adc   GPositionXFifth
         sta   GPositionXScreenFifth ; Calculate from H coordinate, window, and GPositionXFifth
         rep   #$20
         lda   Connects+4,x ; window location
         and   #$00FF
         sta   WinXEdgeBlk
         asl              ; x2
         tax
         adc   WinXEdgeBlk ; x3
         ASLS  2          ; x12
         sta   WinXBlkIDsPtr
         txa
         asl              ; x4
         adc   WinXEdgeBlk ; x5
         sta   WinXEdgeTotalFifths

         stz   SpritesActiveCnt ; Kill all sprites
         stz   ErAc
         stz   IMsp       ; This takes the WinXEdgeBlk value
         ldx   #$0000
]lp      lda   MapSpr,x   ; And runs through the sprite list
         and   #$00FF
         beq   Bonk     ; until it hits something with a
         cmp   WinXEdgeBlk
         bcs   Bonk     ; window value equal or higher.
         inc   IMsp
         txa              ;  - So the sprite handler is
         clc
         adc   #$0009     ; at the right starting point
         tax
         bra   ]lp

         DO    BF_ScrlLft
Bonk     lda   IMsp
         sta   DMsp
         stz   Lupe
         ELSE
Bonk     stz   Lupe
         FIN

* Unless the screen is at the start of level,
         lda   WinXEdgeBlk
         beq   :CantDo

* Decrement the starting screen column by one block fifth
* so the initial screen draw comes out complete.
         lda   WinXEdgeBlkFifth
         dec
         bpl   :WasntZero
         dec   WinXEdgeBlk
         lda   WinXBlkIDsPtr
         sec
         sbc   #$000C
         sta   WinXBlkIDsPtr
         lda   #$0004
:WasntZero sta   WinXEdgeBlkFifth
         dec   WinXEdgeTotalFifths
         inc   Lupe

:CantDo lda   GPositionXBlk
         ASLS  4
         sec
         sbc   GPositionXBlk ; x15
         eor   #$FFFF
         sec
         sbc   #$d7ff     ; result same as subtracting it from 2800
         tax
         stal  PeaJumpPtr ; according to the horizontal block
         phb
         pea   #>ForeFld
         plb
         plb
         ldy   #$1e00     ; being started at,
         clc
]lp      LDA   #$11F4     ; set up the two PEA feilds
         STA   ForeFld,x  ; (that is, the foreground one
         STAL  BackFld,x  ;  and the background one.)
         XBA
         STA   ForeFld+2,x ; and their jump locations.
         STAL  BackFld+2,x
         txa
         adc   #$0006
         tax
         dey
         bne   ]lp
         plb    ; 02/105F

         DO    BF_HeatWav
         stz   HeatCnt
         stz   HeatSync
         FIN

         lda   #$004F
         clc
         adc   Lupe
         sta   Lupe
]lp      JSR   PeaInc     ; pre-draw a full screen of
         dec   Lupe       ; grafix, a strip at a time
         bne   ]lp

         rep   #$30
         jsr   DraTrol    ; draw the skumbucket prior to fade-in
         lda   SpritesActiveCnt ; if there were any sprites,
         beq   *+5
         jsr   SprUp      ; Update them once
         lda   ErAc
         beq   *+5
         JSR   DraEm      ; draw active sprites
         JSR   PeaBlit    ; then blit to shr

         rep   #$30
         ldx   #$01FE
]lp      ldal  $e19e00,x  ; pull palette from screen, so any
         stal  FadeDat,x  ; sprite-based palette changes stick
         dex
         dex
         bpl   ]lp
         lda   #$0000
         ldx   #$01fe
]lp      stal  $019e00,x  ; Make pals zero again before
         dex              ; turning on SHR
         dex
         bpl   ]lp
         lda   #$0001
         sta   FadeRate
         SEP   #$30
         LDA   #$C1
         STAl  $e1C029    ; turn on SHR
         jsr   FadeLoop   ; Fade everything in (phew! now we can start!)
         DO    BF_TVScrns
         stz   TVcntr     ; Temporary check to see if it works
         FIN

MainPlayLoop rep   #$20
         lda   Flashing
         and   #$0001
         bne   *+7
         jsr   DraTrol    ; draw the skumbucket (unless flashing)
         rep   #$20
         lda   ErAc
         beq   *+5
         JSR   DraEm      ; Draw active sprites, if any
         DO    BF_HeatWav
         lda   HeatCnt
         inc
         cmp   #22
         bne   *+5
         lda   #$0000
         sta   HeatCnt
         FIN
         JSR   PeaBlit    ; blit dat screen!
         rep   #$20
         lda   Flashing
         beq   :Br1
         dec   Flashing
         and   #$0001
         bne   *+5
:Br1     jsr   DraTrol    ; draw the skumbucket
         jsr   ZapTrol    ; Erase Guido, now that we've blitted
         rep   #$20
         lda   ErAc
         beq   *+5
         JSR   ZapEm      ; Erase sprites, if any

* Interpret keyboard signals

         sep   #$20
         ldal  $e1c000
         bmi   *+5
         jmp   NoKeyIsDown

         cmp   #"Q"       ; check for quit
         bne   NotQuit
         jmp   GameOver
NotQuit = *

         cmp   #$9B       ; ESC
         bne   NotPause
         DO    Debugger
         jsr   DebugWin
         ELSE
]lp      jsr   WaitKey    ; Freeze and do nothing, until ESC is hit again
         cmp   #$9B
         bne   ]lp
         FIN
         jmp   HandledKey
NotPause = *

         DO    BF_Recordr
         MX    %10
         cmp   #"r"       ; Check for instigation of recorder
         bne   NotRecordStart
         rep   #$30
         lda   SpritesActiveCnt
         ASLS  3          ; x8
         adc   SpritesActiveCnt ; x9
         tax              ; in X
         lda   #IDRecorder
         sta   SprI,x     ; Sets recorder ID
         lda   #$0000
         sta   SprI+1,x   ; Resets index
         lda   #$0069
         sta   SprI+5,x   ; Sets "first cycle" flag
         inc   SpritesActiveCnt
         sep   #$20
         lda   #$FF
         sta   SprI+8,x   ; M: Sets non-level I.D.
         jmp   HandledKey
NotRecordStart = *

         cmp   #"p"
         bne   NotPlaybackStart
         rep   #$30
         lda   SpritesActiveCnt
         ASLS  3          ; x8
         adc   SpritesActiveCnt ; x9
         tax              ; in X
         lda   #IDPlayer
         sta   SprI,x     ; Sets playback ID
         lda   #$0000
         sta   SprI+1,x   ; Resets index
         lda   #$0069
         sta   SprI+5,x   ; Sets "first cycle" flag, index to "demo"
         inc   SpritesActiveCnt
         sep   #$20
         lda   #$80       ; Set autopilot indicator flag
         tsb   GameFlags
         lda   #$FF
         sta   SprI+8,x   ; M: Sets non-level I.D.
         bra   HandledKey
NotPlaybackStart = *
         FIN              ; FIN BF_Recordr 

         sta   Tmp
         lda   GameFlags    ; Skip arrow key reads if autopilot is running
         bmi   HandledKey
         lda   Tmp

         cmp   #$95
         bne   NotRightArrow
         lda   #$04
         sta   JoystkHDir
         bra   HandledKey
NotRightArrow = *

         cmp   #$88
         bne   NotLeftArrow
         lda   #$00
         sta   JoystkHDir
         bra   HandledKey
NotLeftArrow = *

         cmp   #$A0
         bne   NotSpacebar
         lda   #$02
         sta   JoystkHDir
NotSpacebar = *

HandledKey = *
         lda   #$00       ; Clear the keyboard here
         stal  $e1c010    ; since we're skipping over HandledKey
         jmp   SkipJoystickRead

NoKeyIsDown = *

         lda   GameFlags    ; Skip joystick reads if autopilot is running
         bmi   SkipJoystickRead

         PUT   LIB/JOYSTICKREAD

SkipJoystickRead = *

         sep   #$30
         ldx   #$40
         ldal  $00c062
         bmi   :Button1
         ldx   #$00
:Button1 stx   JoystkBtns01
         ldal  $00c061
         and   #$80
         tsb   JoystkBtns01

         PUT   LIB/MOVEMENT

         rep   #$30       ; all this does
         JSR   PalUpdate  ; is update the palette.
         DO    BF_TVScrns
         jsr   DrawScrn   ; Temporary check to see if it works
         FIN
         sep   #$20
         dec   Time2+3    ; Is timer delay over?
         bne   DoneTime
         lda   #$0A       ; Then check time.
         sta   Time2+3

         rep   #$30
         lda   Time1
         bne   TimeDec    ; If counter is zero,
         lda   Time1+1    ; Guido dies, no flip to 999.
         bne   TimeDec
         jmp   Die

TimeDec  rep   #$10       ; Decrease timer:
         ldy   #$0004
         ldx   #$0000
         sep   #$20
         phb
         pea   #>SHR
         plb
         plb
]lp      lda   Time1,x
         dec
         bpl   MeepMeep
         lda   #$09       ; If it skips over,
         sta   Time1,x    ; save a nine and draw,
         jsr   TimeDraw
         inx
         dey
         dey
         bpl   ]lp        ; If the counter flips from 0 to 999
         plb              ; (Which should never happen),
         jmp   Die        ; kill Guido for good measure

MeepMeep sta   Time1,x
         jsr   TimeDraw
         plb

DoneTime sep   #$20
         lda   GVelocityX
         cmp   #$80       ; this sets GBodyFlg_Facing 0=Forwards
         beq   :Continue     ; and 1=Backwards, if Guido is not
         cmp   #$80       ; standing still.  Otherwise the value
         bcc   :ToLeft  ; is left as-is.
         lda   #$01
         trb   GBodyFlg_Facing
         bra   :Continue
:ToLeft  lda   #$01
         tsb   GBodyFlg_Facing

:Continue rep   #$10       ; Set the anal Xaxs value
         lda   GVelocityX
         eor   #$80
         sta   Xaxs
         sep   #$20       ; check the vertical axis

         DO    BF_Slopes
         lda   GPositionYBlk ; if it is above or below the screen
         beq   JumpEr
         cmp   #$0d       ; It's always empty.
         bcs   JumpEr
         rep   #$31
         lda   GPositionXBlk
         asl
         adc   GPositionXBlk
         ASLS  2
         adc   #$000b
         sec
         sbc   GPositionYBlk ; Subtract in the vertical location
         tax
         ldy   #$0000
         sep   #$20
         lda   GPositionYSlice
         beq   Barney     ; If not on the bottom of the block, check slope.

         DO    BF_Buttons
         cmp   #$08       ; Step 8 half-height button check
         bne   Burger
         lda   MapBl,x
         cmp   #BlkId_ButtonHalf
         beq   ScrewMe
         lda   GPositionXFifth ; GPositionXFifth = 0>2?
         cmp   #$03
         bcc   Burger
         rep   #$21
         txa
         adc   #$000c
         tax
         sep   #$20
         lda   MapBl,x
         cmp   #BlkId_ButtonHalf  ; Next block over
         beq   ScrewMe
Burger   =     *
         FIN    ; FIN BF_Buttons

         lda   MapBl,x
         cmp   #BlkId_SlopeLeft   ; Immediate slope check
         beq   Keifer
         cmp   #BlkId_SlopeRight
         beq   Suthrlnd
         lda   GPositionXFifth
         cmp   #$03
         bcc   Buttock
         lda   MapBl+$C,x
         cmp   #BlkId_SlopeLeft   ; To right slope check
         beq   Keifer
         cmp   #BlkId_SlopeRight
         bne   Buttock
Suthrlnd ldy   #$0005
Keifer   rep   #$21
         tya
         adc   GPositionXFifth
         tay              ; Make a height-check index
         sep   #$20
         lda   SlopLeft,y
         cmp   GPositionYSlice
         beq   ScrewMe    ; If no match, Guido falls
JumpEr   jmp   Buttock
Barney   inx              ; one extra block down

         ELSE

         DO    BF_Buttons
         lda   GPositionYSlice
         beq   PayUp
         cmp   #$08       ; Step 8 half-height button check
         bne   PayUp-2    ; (Buttock)
         lda   GPositionYBlk
         cmp   #$0d       ; It's always empty.
         bcs   PayUp-2
         rep   #$31
         lda   GPositionXBlk
         asl
         adc   GPositionXBlk
         ASLS  2
         adc   #$000b
         sec
         sbc   GPositionYBlk
         tax
         sep   #$20
         lda   MapBl,x
         cmp   #BlkId_ButtonHalf
         beq   ScrewMe
         lda   GPositionXFifth  ; GPositionXFifth = 0>2?
         cmp   #$03
         bcc   Buttock
         lda   MapBl+$c,x
         cmp   #BlkId_ButtonHalf  ; Next block over
         beq   ScrewMe
         bra   Buttock

PayUp    =     *          ; normal 'below' check

         ELSE
         lda   GPositionYSlice
         bne   Buttock    ; If not on the bottom of the block, drop.
         lda   GPositionYBlk ; if it is above or below the screen
         beq   Buttock
         cmp   #$0d       ; It's always empty.
         bcs   Buttock
         FIN    ; FIN BF_Buttons

         rep   #$31
         lda   GPositionXBlk
         asl
         adc   GPositionXBlk
         ASLS  2
         adc   #$000c     ; Extra block down
         sec
         sbc   GPositionYBlk
         tax
         sep   #$20

         FIN    ; FIN BF_Slopes

         lda   MapBl,x

         DO    BF_Buttons
         cmp   #BlkId_ButtonHalf
         beq   :Br1
         cmp   #BlkId_PipeDown
         bcs   ScrewMe
         cmp   #BlkId_Pltfm
         beq   ScrewMe
:Br1     lda   GPositionXFifth
         ELSE
         cmp   #BlkId_PipeDown
         bcs   ScrewMe
         cmp   #BlkId_Pltfm
         beq   ScrewMe
         lda   GPositionXFifth
         FIN    ; FIN BF_Buttons

         cmp   #$03
         bcc   Buttock
         lda   MapBl+$c,x ; Next row of blocks

         DO    BF_Buttons
         cmp   #BlkId_ButtonHalf
         beq   Buttock
         FIN

         cmp   #BlkId_Pltfm
         bcc   Buttock
ScrewMe  lda   #$01
         sta   NoFall
         lda   JoyZ       ; If the button has not been "reset", no jump
         bne   Twinkie
         lda   JoystkBtns01
         bpl   Twinkie
         inc   JoyZ
         lda   #$74
         sta   GVelocityY
         lda   #$05
         sta   Jcnt
         DO    BF_SFXCode    ; MOD for jump sfx
         jsr   PlaySFX
         FIN
         lda   Xaxs       ; If horiz. velocity is "fast", add to jump height
         cmp   #$FF       ; That is, if Xaxs's offset is more than 2
         beq   Twinkie
         cmp   #$02       ; - opposite direction
         bcc   Twinkie
         inc   Jcnt
         inc   Jcnt
         bra   Twinkie
Buttock  stz   NoFall
         inc   GVelocityY
         inc   GVelocityY
         inc   GVelocityY

Twinkie  lda   Jcnt
         beq   GenrlBoy   ; If Jcnt has a value,
         lda   JoyZ
         beq   :Br1       ; and the button is down,
         dec   GVelocityY        ; then we add to Guido's upward velocity,
         dec   GVelocityY
         dec   GVelocityY
:Br1     dec   Jcnt       ; and decrement Jcnt.
         bne   GenrlBoy
         inc   GVelocityY

GenrlBoy lda   Xaxs
         clc
         adc   GPositionXScreenFifth
         dec
         cmp   #$c0      ; this checks to see if the bozo is trying
         bcc   Fester   ; to go off the left border of the screen
         ldy   #$0080
         sty   GVelocityX
]lp      inc   Xaxs       ; and corrects it.
         inc
         bne   ]lp
         bra   CheckDoorDown

Fester   cmp   #$4b
         bcc   CheckDoorDown       ; And this is a similar check for the
         ldy   #$0080     ; right border
         sty   GVelocityX
]lp      dec   Xaxs
         dec
         cmp   #$4a
         bne   ]lp

CheckDoorDown sep   #$20
         lda   JoystkReadY       ; If joystick is down,
         cmp   #80
         bcc   CheckDoorRight
         lda   GVelocityX        ; And horiz velocity is still,
         cmp   #$80
         bne   CheckDoorRight
         lda   GVelocityY        ; And vertical velocity is still,
         cmp   #$80
         bne   CheckDoorRight
         lda   GPositionXFifth
         cmp   #$02       ; And slice is not 0 or 1
         bcc   CheckDoorRight
         rep   #$31       ; map loc in X...
         lda   GPositionXBlk
         asl
         adc   GPositionXBlk
         ASLS  2
         adc   #$000c     ; 1 extra down
         sec
         sbc   GPositionYBlk
         tax
         sta   MapLocWrite+1   ; (Save that map location)
         sep   #$20
         lda   MapBl,x
         cmp   #BlkId_PipeDown ; And there is a down pipe under Merry-Man,
         bne   CheckDoorRight
         lda   MapBl+$C,x
         cmp   #BlkId_PipeDown
         bne   CheckDoorRight ; AND there is a down pipe right of Guido,
         lda   GPositionYBlk  ; SHOVE HIS ASS OFF!! 8)
         cmp   #$0c
         bcs   *+8        ; If vertical is off map, no draw :(
         rep   #$20
         jsr   DoorCompute
         jsr   DownOut
         jmp   DoorGo

         MX    %10
CheckDoorRight lda   Xaxs       ; If joystick is right,
         cmp   #$80
         bcs   CheckDoorLeft
         lda   GVelocityY        ; And vertical velocity is still,
         cmp   #$80
         bne   CheckDoorLeft
         lda   GPositionXFifth
         cmp   #$02       ; And slice is in 2
         bne   CheckDoorLeft
         rep   #$31       ; map loc in X...
         lda   GPositionXBlk
         asl
         adc   GPositionXBlk
         ASLS  2          ; x12
         adc   #$0017     ; +23 (1 extra line right, plus 1 extra line to subtract vertical offset from)
         sec
         sbc   GPositionYBlk
         tax
         sta   MapLocWrite+1   ; (Save that map location)
         lda   MapBl,x
         and   #$00FF
         cmp   #BlkId_PipeRight      ; And there is a pipe right of Merry-Man,
         bne   CheckDoorLeft
         lda   MapBl-1,x
         and   #$00FF
         cmp   #BlkId_PipeRight
         bne   CheckDoorLeft   ; AND there is a pipe up&right of Mr.Man,

         jsr   DoorCompute   ; Shove his heine in.
         jsr   RSideOut
         jmp   DoorGo

CheckDoorLeft sep   #$20
         lda   Xaxs       ; If joystick is left,
         cmp   #$80
         bcc   CheckDoorUp
         lda   GVelocityY        ; And vertical velocity is still,
         cmp   #$80
         bne   CheckDoorUp
         lda   GPositionXFifth ; And slice is in 0
         cmp   #$00
         bne   CheckDoorUp
         rep   #$31       ; map loc in X...
         lda   GPositionXBlk
         asl
         adc   GPositionXBlk
         ASLS  2          ; One extra line left (no sec)
         sbc   GPositionYBlk
         tax
         sta   MapLocWrite+1   ; (Save that map location)
         lda   MapBl,x
         and   #$00FF
         cmp   #BlkId_PipeLeft ; And there is a pipe left of Guido,
         bne   CheckDoorUp
         lda   MapBl-1,x
         and   #$00FF
         cmp   #BlkId_PipeLeft
         bne   CheckDoorUp   ; AND there is a pipe up&left of Mr.Man,
         jsr   DoorCompute   ; Shove his ass out
         jsr   LSideOut
         jmp   DoorGo

CheckDoorUp sep   #$20
         lda   JoystkReadY       ; If joystick is up,
         cmp   #23
         bcs   Wralf
         lda   GVelocityX        ; And horiz velocity is still,
         cmp   #$80
         bne   Wralf
         lda   GVelocityY        ; And vertical velocity is still,
         cmp   #$80
         bne   Wralf
         lda   GPositionXFifth ; And horiz strip=1 (block-aligned visually)
         dec
         bne   Wralf
         rep   #$31       ; map loc in X...
         lda   GPositionXBlk
         asl
         adc   GPositionXBlk
         ASLS  2
         adc   #$000b
         sec
         sbc   GPositionYBlk
         tax
         sta   MapLocWrite+1   ; (Save location for later)
         lda   MapBl,x
         and   #$00FF
         cmp   #BlkId_Door      ; And there is a door behind Merry-Man,
         beq   *+5
Wralf    jmp   Worf
         lda   GPositionYBlk ; VANISH HIS ASS!! 8)
         cmp   #$000c
         bcs   *+8        ; If vertical is off map, no vanish :(
         jsr   DoorCompute
         jsr   DownOut
         jmp   DoorGo

         MX    %11
]lp      lsr
         ora   #$C0
         bra   Smurf

Worf     sep   #$30
         lda   GVelocityY ; Define this cycle's vertical
         bpl   ]lp        ; update amount from GVelocityY
         lsr
         and   #$3F
Smurf    sta   Yaxs

Boingg  sep   #$30
         lda   Xaxs       ; check the Xaxs
         bne   HopHop     ; skip if finished
]lp      jmp   Larry      ; Long branch to end
HopHop   cmp   #$80
         bcs   *+5        ; go to second routine if offset positive
         jmp   Stimpy
         inc   Xaxs
         dec   GPositionXFifth
         dec   GPositionXScreenFifth
         lda   GPositionXFifth
         cmp   #$FF
         bne   ]lp
         dec   GPositionXBlk
         rep   #$31
         lda   GPositionXBlk ; get map location
         asl
         adc   GPositionXBlk
         ASLS  2
         adc   #$000a     ; up 1 block
         sec
         sbc   GPositionYBlk
         tax
         sep   #$20
         lda   GPositionYBlk ; If he's offscreen, the bastard is
         cmp   #$0b       ; automatically clear-
         bcc   :Br1
         ldy   GPositionXBlk
         lda   ClmInfo,y  ; -unless the solid above bit is set
         and   #$20
         beq   Smooth
         bra   Flesh
:Br1     lda   MapBl,x
         cmp   #BlkId_PipeDown ; Solid?
         bcs   Flesh
         jsr   ChItem     ; Check the block directly in front.
         lda   GPositionYBlk ; If off screen, branch
         cmp   #$0a
         beq   Smooth
         inx
         lda   MapBl,x
         cmp   #BlkId_PipeDown ; If this block is solid, do one more
         bcs   Laffer     ; special check before giving up.
         jsr   ChItem
         lda   GPositionYSlice
         cmp   #$04       ; If bozorina is not near the bottom,
         bcc   Smooth     ; Check the third block
         lda   GPositionYBlk ; If off screen,
         cmp   #$09       ; skip check
         bcs   Smooth
         dex
         dex
         lda   MapBl,x
         cmp   #BlkId_PipeDown
         bcs   Flesh
         jsr   ChItem
Smooth   lda   #$04
         sta   GPositionXFifth
         jmp   Larry
Laffer   lda   GPositionYSlice
         cmp   #$0f
         bne   Flesh
         dex
         dex              ; Move to block 2 above
         lda   MapBl,x
         cmp   #BlkId_PipeDown
         bcs   Flesh           ; If it's not solid, move Guido up
         stz   GPositionYSlice ; into the space-
         inc   GPositionYBlk   ; result: he can "catch" a block
         bra   Smooth          ; when only one pixel down from the top
Flesh    inc   GPositionXBlk
         inc   GPositionXScreenFifth
         stz   GPositionXFifth
         lda   #$80
         sta   GVelocityX
         sta   JoystkHLev
         stz   Xaxs
         jmp   Larry

Stimpy   dec   Xaxs       ; second routine
         inc   GPositionXScreenFifth
         inc   GPositionXFifth
         lda   GPositionXFifth
         cmp   #$03
         beq   Poopy
         cmp   #$05
         bne   Godflesh-2
         inc   GPositionXBlk
         stz   GPositionXFifth
         jmp   Larry
Poopy    rep   #$31
         lda   GPositionXBlk ; get map location
         asl
         adc   GPositionXBlk
         ASLS  2
         adc   #$0016     ; Up one block + 1 GPositionXBlk value
         sec
         sbc   GPositionYBlk
         tax
         sep   #$20
         lda   GPositionYBlk ; Bastard-offscreen check
         cmp   #$0b
         bcc   :Br1
         ldy   GPositionXBlk
         lda   ClmInfo+1,y ; -unless the solid above bit is set
         and   #$20
         beq   Larry
         bra   Drugs
:Br1     lda   MapBl,x
         cmp   #BlkId_PipeDown
         bcs   Drugs
         jsr   ChItem     ; Second up block:
         lda   GPositionYBlk ; If off screen, branch
         cmp   #$0a
         bcs   Larry
         inx
         lda   MapBl,x
         cmp   #BlkId_PipeDown
         bcs   Godflesh
         jsr   ChItem
         lda   GPositionYSlice ; If the bloated sack is not near
         cmp   #$04       ; the bottom, check the 3rd block
         bcc   Larry
         lda   GPositionYBlk ; If off the screen, no check either
         cmp   #$09
         bcs   Larry
         dex
         dex
         lda   MapBl,x
         cmp   #BlkId_PipeDown
         bcs   Drugs
         jsr   ChItem
         bra   Larry
Godflesh lda   GPositionYSlice
         cmp   #$0f
         bne   Drugs
         dex
         dex              ; Move to block 2 above
         lda   MapBl,x
         cmp   #BlkId_PipeDown
         bcs   Drugs           ; If it's not solid, move Guido up
         stz   GPositionYSlice ; into the space-
         inc   GPositionYBlk   ; result: he can "catch" a block
         bra   Larry           ; when only one pixel down from the top
Drugs    dec   GPositionXScreenFifth
         lda   #$80
         sta   GVelocityX
         sta   JoystkHLev
         lda   #$02
         sta   GPositionXFifth
         stz   Xaxs

Larry    sep   #$30
         lda   Yaxs       ; check the Yaxs
         beq   Freem      ; skip if finished to end.
         cmp   #$80
         bcs   :Br1       ; go to second routine if offset positive
         jmp   Juicy
:Br1     inc   Yaxs
         inc   GPositionYSlice
         lda   GPositionYSlice
         cmp   #$10       ; check for edge of block increment
         bne   Lips
         lda   #$00
         sta   GPositionYSlice
         inc   GPositionYBlk
Freem    jmp   Uranus
Lips     cmp   #$02       ; MORE space!!
         bne   Freem
         lda   GPositionYBlk ; If he's offscreen, no check
         cmp   #$0a
         bcs   Round      ; Besides, the check would come up wrong!
         rep   #$31
         lda   GPositionXBlk ; get map location
         asl
         adc   GPositionXBlk
         ASLS  2
         adc   #$0009     ; Two blocks extra up.
         sec
         sbc   GPositionYBlk
         tax
         sep   #$20
         lda   GPositionXFifth
         cmp   #$04       ; If the slice is 4 (was 3 or more),
         bcs   Check2nd   ; check the rightmost block >first< for
         lda   MapBl,x    ; a solid
         cmp   #BlkId_HiddenSld1
         bcs   HitSolidAbove
         cmp   #BlkId_RevPltfm
         beq   HitSolidAbove ; Or if reverse platform...
         jsr   ChItem
         lda   GPositionXFifth ; Does GPositionXFifth = 0>2?
         cmp   #$03
         bcc   Round      ; If so, we only need to check 1 block
Check2nd stx   :SavedMapSpot+1  ; Save original so we don't have to subtract
         rep   #$21
         txa
         adc   #$000c
         tax
         sep   #$20
         lda   MapBl,x    ; next column
         cmp   #BlkId_HiddenSld1      ; check the second block
         bcs   HitSolidAbove
         cmp   #BlkId_RevPltfm
         beq   HitSolidAbove ; Or if reverse platform...
         jsr   ChItem
         lda   GPositionXFifth
         cmp   #$03       ; was 2
         bcc   Round
:SavedMapSpot ldx   #$0000     ; Restore that val.
         lda   MapBl,x    ; This column
         cmp   #BlkId_HiddenSld1      ; check the second block
         bcs   HitSolidAbove
         cmp   #BlkId_RevPltfm
         beq   HitSolidAbove ; Or if reverse platform...
         jsr   ChItem
Round    jmp   Uranus
HitSolidAbove  inc   GPositionYSlice
         stx   Itm
         jsr   ChSolid    ; Check for affecting block
         sep   #$20
         stz   Yaxs
         lda   GVelocityY
         eor   #$FF
         sta   GVelocityY
         inc   GBodyFlg_Tongue ; Tongue out when hitting a brick :)
         stz   Jcnt       ; Not adding for a jump anymore
         jmp   Uranus

Juicy    dec   Yaxs       ; second routine
         DO    BF_Buttons
         lda   GPositionYSlice
         bne   *+5
         jmp   TopHat
         cmp   #$08       ; Step 8 half-height button check
         bne   Elsa
         lda   GPositionYBlk
         cmp   #$0d
         bcs   Elsa
         rep   #$31
         lda   GPositionXBlk ; get map location
         asl
         adc   GPositionXBlk
         ASLS  2          ; x12
         adc   #$000b     ; One block extra down.
         sec
         sbc   GPositionYBlk
         tax
         sep   #$20
         lda   MapBl,x
         cmp   #BlkId_ButtonHalf
         beq   NotElsa
         lda   GPositionXFifth ; GPositionXFifth = 0>2?
         cmp   #$03
         bcc   Elsa
         rep   #$21
         txa
         adc   #$000c
         tax
         sep   #$20
         lda   MapBl,x
         cmp   #BlkId_ButtonHalf   ; Next block over
         bne   Elsa
NotElsa  inc   GPositionYSlice
         lda   #$01
         sta   NoFall     ; Obviously not falling anymore
         stz   Jcnt       ; Not adding for a jump anymore
         stz   Yaxs
         lda   GVelocityY
         cmp   #$87
         bcc   NoPress
         stx   Itm
         stz   MapBl,x
         inc   MapVl,x    ; Compiled blockset only!
         lda   MapVl,x    ; MOD
         sta   Tmp3       ; (BlokZap uses Tmp3 for replace)
         stz   Tmp3+1
         jsr   BlokZap    ; replace button
         sep   #$20
         rep   #$10
         inc   Itm
         ldx   Itm
         inc   MapVl,x
         lda   MapVl,x    ; MOD
         sta   Tmp3
         jsr   BlokZap    ; replace stand
         sep   #$20
         rep   #$10
         ldx   Itm        ; Restore the variables
         lda   #$02       ; Rest of code goes here
         sta   GPositionYSlice
NoPress  lda   #$80       ; Vertical descent stopped
         sta   GVelocityY
Elsa     =     *
         ELSE
         lda   GPositionYSlice
         beq   TopHat
         FIN
         dec   GPositionYSlice
         bra   Uranus
TopHat   lda   GPositionYBlk ; Bastard-offscreen check
         beq   Panties
         cmp   #$0d
         bcs   Panties
         rep   #$31
         lda   GPositionXBlk ; get map location
         asl
         adc   GPositionXBlk
         ASLS  2
         adc   #$000c     ; One block extra down.
         sec
         sbc   GPositionYBlk
         tax
         sep   #$20
         lda   MapBl,x

         DO    BF_Buttons
         cmp   #BlkId_ButtonHalf
         beq   Br1
         cmp   #BlkId_PipeDown
         bcs   Kitties
         cmp   #BlkId_Pltfm
         beq   Kitties
         jsr   ChItem
Br1      =     *
         ELSE
         cmp   #BlkId_PipeDown
         bcs   Kitties
         cmp   #BlkId_Pltfm
         beq   Kitties
         jsr   ChItem
         FIN

         lda   GPositionXFifth ; GPositionXFifth = 0>2?
         cmp   #$03
         bcc   Panties
         rep   #$21
         txa
         adc   #$000c
         tax
         sep   #$20
         lda   MapBl,x

         DO    BF_Buttons
         cmp   #BlkId_ButtonHalf
         beq   Panties
         FIN

         cmp   #BlkId_PipeDown      ; Next block over
         bcs   Kitties
         cmp   #BlkId_Pltfm
         beq   Kitties
         jsr   ChItem
Panties  lda   #$0F
         sta   GPositionYSlice
         dec   GPositionYBlk
         bra   Uranus
Kitties  lda   #$00
         sta   GPositionYSlice
         inc
         sta   NoFall     ; Obviously not falling anymore
         stz   Jcnt       ; Not adding for a jump anymore
         stz   Yaxs
         lda   #$80       ; Vertical descent stopped
         sta   GVelocityY

Uranus   sep   #$30       ; Go back if both axes are not 0
         lda   Yaxs
         bne   Beefy
         lda   Xaxs
         bne   Beefy

         lda   GPositionYBlk ; for now, if the asshole falls off,
         cmp   #$FE       ; we go straight to death.
         bcs   Mono1
         cmp   #$F8       ; Two blocks off, then the dead zone.
         bcc   Mono1
         jmp   Die        ; Guido death?

Beefy    jmp   Boingg    ; Not finished

Mono1    lda   GPositionXScreenFifth ; Check screen loc.
         cmp   #$34       ; Right border of center range where scrolling doesn't trigger
         bcc   UpThere
         sbc   #$33       ; Right border -1
         sta   DCnt
Nested   ldx   WinXEdgeBlk
         lda   ClmInfo,x
         and   #$80
         bpl   UpDwn      ; If column no-scroll-left flag is set, stop
         lda   WinXEdgeBlkFifth
         cmp   #$04
         beq   UpHere
UpDwn    JSR   PeaInc
         sep   #$20
         dec   DCnt
         bne   Nested
UpHere   lda   #$33       ; Right border -1
         clc
         adc   DCnt
         sta   GPositionXScreenFifth

         DO    BF_ScrlLft
UpThere  lda   GPositionXScreenFifth ; Check screen loc.
         cmp   #$1C       ; Left border of center range where scrolling doesn't trigger
         bcs   DirtClod
         lda   #$1C
         sec
         sbc   GPositionXScreenFifth ; Left border
         sta   DCnt
Chuck    ldx   WinXEdgeBlk
         lda   ClmInfo-15,x
         and   #$40
         beq   Babe       ; If column no-scroll-right flag is set, stop
         lda   WinXEdgeBlkFifth
         cmp   #$04
         beq   Eediot
Babe     JSR   PeaDec
         sep   #$20
         dec   DCnt
         bne   Chuck
Eediot   lda   #$1C       ; Left border
         sec
         sbc   DCnt
         sta   GPositionXScreenFifth

DirtClod sep   #$30
         ELSE
UpThere  sep   #$30
         FIN
         lda   #$00
         xba              ; Clear out the B reg
         inc   Acnt       ; Increment animation counter
         lda   #GuidoSprId_MouthNormal
         sta   GCurrentSpr_Mouth
         lda   GBodyFlg_Tongue
         beq   AnimSk1
         lda   #GuidoSprId_TongueOut ; Display the tongue one time only
         sta   GCurrentSpr_Mouth
         stz   GBodyFlg_Tongue
AnimSk1  lda   GCurrentSpr_Eye       ; If eyes are closed,
         cmp   #GuidoSprId_EyesClosed        ; open them
         bne   AnimSk4
         lda   #GuidoSprId_EyesNormal
         sta   GCurrentSpr_Eye
AnimSk4  lda   Acnt
         and   #$3f       ; If counter hits 64 cycle mark,
         cmp   #$3f
         bne   AnimSk2
         lda   GVelocityX
         cmp   #$80       ; and GVelocityX is neutral,
         bne   AnimSk2
         lda   GVelocityY
         cmp   #$80       ; and GVelocityY is neutral,
         bne   AnimSk2
         lda   GCurrentSpr_Eye
         cmp   #GuidoSprId_EyesNormal ; and eyes are open (no shades,etc)
         bne   AnimSk2
         lda   #GuidoSprId_EyesClosed ; make him blink.
         sta   GCurrentSpr_Eye
AnimSk2  rep   #$10       ; Guido's walking and belly
         ldy   #6         ; - directional modification is not
         lda   NoFall
         beq   AnimSk3
         ldy   #0
         lda   GVelocityX ; dealt with in the animation here,
         cmp   #$80       ; DraTrol does that.
         beq   AnimSk3
         lda   Acnt
         and   #$07
         tay
AnimSk3  lda   GuidoWalk_LArm,y    ; Left arm
         sta   GCurrentSpr_LArm
         lda   GuidoWalk_RArm,y    ; Right arm
         sta   GCurrentSpr_RArm
         lda   GuidoWalk_LegB,y    ; Lower belly section
         sta   GCurrentSpr_LegB
         lda   GuidoWalk_LegA,y    ; Legs
         sta   GCurrentSpr_LegA
         lda   #GuidoSprId_Belly
         sta   GCurrentSpr_Belly

         lda   SpritesActiveCnt
         beq   *+5        ; If there are any sprites,
         jsr   SprUp      ; Update sprite list
         jmp   MainPlayLoop

         DO    BF_Slopes
         DB    0          ; Subtract 1 for lower limit check values
SlopLeft DB    2,5,8,11,14
SlopRght DB    14,11,8,5,2
         DB    0          ; Add 1 " " "
         FIN

Verdict  sep   #$20       ; For now, he dies no matter what.
         lda   Flashing
         bne   AlreadyF   ; If already flashing, no check.
         ldal  WldCndtn+ShelPage ; Guido life
         bne   :Br1
         lda   #$68       ; (kills him)
         rts
:Br1     rep   #$20
         and   #$0003
         dec
         stal  WldCndtn+ShelPage
         ASLS  2
         phx
         tax
         LDA   #$0000
         stal  $012140+133,x
         stal  $0121e0+133,x
         stal  $012280+133,x
         plx
         lda   #$0020
         sta   Flashing
         sep   #$20
AlreadyF lda   #$69
         rts

Die      rep   #$30       ; Mario death routine so far!
         pea   #>ThisProg
         plb
         plb
         ldx   #$01FE     ; Fader data=red parts of current pallette
]lp      ldal  $e19e00,x  ; (as long as FadeDat is in prog bank)
         and   #$0F00
         stal  FadeDat,x
         dex
         dex
         bpl   ]lp
         lda   #$0001
         sta   FadeRate
         jsr   FadeLoop   ; Fade the game screen to red parts
         rep   #$30
         ldx   #$01FE     ; Fader data to 0's
         lda   #$0000
]lp      stal  FadeDat,x
         dex
         dex
         bpl   ]lp
         stz   FadeRate
         jsr   FadeLoop   ; Fade it out to black
         rep   #$20       ; Decrease lives:
         ldal  WldLives+ShelPage
         sep   #$20
         dec
         bpl   :Br1
         lda   #$09
         xba
         dec
         bpl   *+5
         jmp   GameOver    ; If both skip over, game over
         xba
:Br1     rep   #$20
         stal  WldLives+ShelPage
         lda   #$0001
         stal  WldCndtn+ShelPage ; Guido life reset
         lda   #GuidoSprId_HeadNormal
         sta   GCurrentSpr_Head       ; Guido: head: normal
         LDA   #GuidoSprId_MouthNormal
         sta   GCurrentSpr_Mouth       ; Guido: mouth: normal
         jmp   TrolPlay

* Scroll "forward":
* Extend the PEA field down in memory, making room for another 4 pixels on the
* right edge of the screen, and draw a stripe of graphics there.
PeaInc   SEP   #$30
         DO    BF_VrtFunk
         lda   GameFlags
         and   #$01
         beq   IncBr2
         lda   FunkFlag   ; Here on to there
         beq   IncBr1
         dec   FunkReg
         lda   FunkReg
         cmp   #$FF
         bne   IncBr2     ; Is the funkflag vertical twist code.
         lda   #$01
         sta   FunkReg
         inc   FunkFlag
         bra   IncBr2
IncBr1   inc   FunkReg
         lda   FunkReg
         cmp   #$08
         bne   IncBr2
         dec   FunkFlag
         lda   #$06
         sta   FunkReg    ; there
IncBr2   =     *
         FIN
         REP   #$31
         inc   WinXEdgeTotalFifths
         ldal  PeaJumpPtr
         sbc   #$0002
         stal  PeaJumpPtr
         taX
         LDA   #$01F4     ; Make new PEA
         STAL  ForeFld,X
         STAL  BackFld,x
         INC   WinXEdgeBlkFifth
         LDA   WinXEdgeBlkFifth
         CMP   #$0005     ; Not gone a block?
         DO    BF_ScrlLft
         BNE   IncBr4     ; Don't check new sprites.
         ELSE
         bne   IncBr3
         FIN
         STZ   WinXEdgeBlkFifth
         INC   WinXEdgeBlk
         LDA   WinXBlkIDsPtr
         CLC
         ADC   #$000C
         STA   WinXBlkIDsPtr
]lp      lda   IMsp
         ASLS  3          ; x8
         adc   IMsp       ; x9
         tax
         LDA   MapSpr,x
         and   #$00ff
         beq   IncBr3     ; If it's a 0, end of list.
         cmp   WinXEdgeBlk
         bne   IncBr3     ; If it's >, can't add yet.
         inc   IMsp
         lda   SpritesActiveCnt
         beq   IncBr5
         ASLS  3
         adc   SpritesActiveCnt
         tay
         sep   #$20
]lp2     lda   SprI-1,y
         inc
         cmp   IMsp
         beq   IncBr3
         LUP   9
         dey
         --^
         bne   ]lp2
         rep   #$21
         lda   SpritesActiveCnt
IncBr5   ASLS  3          ; x8
         adc   SpritesActiveCnt ; x9
         tay
         lda   MapSpr+1,x ; Move in the new sprite
         sta   SprI,y
         lda   MapSpr+3,x
         sta   SprI+2,y
         lda   MapSpr+5,x
         sta   SprI+4,y
         lda   MapSpr+7,x
         sta   SprI+6,y
         sep   #$20
         lda   IMsp
         dec
         sta   SprI+8,y   ; Stick sprite i.d. onto end of data.
         rep   #$20
         inc   SpritesActiveCnt
         bra   ]lp
         DO    BF_ScrlLft
IncBr3   jmp   IncBr3B
IncBr4   rep   #$30
         ELSE
IncBr3   rep   #$30
         FIN
         LDA   #$000B
         STA   Tmp
         DO    BF_VrtFunk
         lda   GameFlags
         and   #$0001
         beq   TwistSk
         lda   FunkReg
         ASLS  4
         sec
         sbc   FunkReg
         ASLS  4
TwistSk  clc
         ADCl  PeaJumpPtr
         ELSE
         ldal  PeaJumpPtr
         FIN
         tay
         DO    BF_HeatWav
         phb
         pea   #>ForeFld
         plb
         plb
]lp      =     BF_SizLine-BF_SizCode
]lp2     =     0
         LUP   #128
         lda   #]lp2*$100+$e5 ; sbc ##
         sta   ForeFld+]lp,y
]lp      =     ]lp+BF_SizLine
]lp2     =     ]lp2+2
         --^
]lp2     =     0
         LUP   #62
         lda   #]lp2*$100+$f5 ; sbc ##,x    Using X to reach beyond the direct page
         sta   ForeFld+]lp,y
]lp      =     ]lp+BF_SizLine
]lp2     =     ]lp2+2
         --^
         lda   #$f41b     ; tcs, pea #$xxxx
]lp      =     BF_SizLine-BF_SizCode+2
         LUP   #190
         sta   ForeFld+]lp,y
]lp      =     ]lp+BF_SizLine
         --^
         plb
         FIN
         DO    BF_BlkComp
         LDA   Tmp
         CLC
         ADC   WinXBlkIDsPtr
         sta   Tmp3
]lp      ldx   Tmp3
         lda   WinXEdgeBlkFifth-1
         sep   #$20
         LDAl  MapVl,x
         rep   #$21
         JSL   Box
         tya
         clc
         adc   #$0f00
         tay
         DEC   Tmp3
         DEC   Tmp
         bpl   ]lp
         ELSE             ; Non-compiled-set routine:
         phb
         pea   #>Blok
         plb
         plb
         LDA   WinXEdgeBlkFifth
         asl
         sta   Tmp3       ; Prepare a WinXEdgeBlkFifth x 2
         lda   WinXBlkIDsPtr
         asl
         adc   #$0016
         sta   Tmp4
]lp      ldx   Tmp4
         LDAl  MapVl,x
         ADC   Tmp3       ; I've optimized this code here
         TYX              ; at least four times.
         TAY
         JSR   Box        ; Tell me if I've missed anything.
         txa
         clc
         adc   #$0f00
         tay
         DEC   Tmp4
         DEC   Tmp4
         DEC   Tmp
         LDA   Tmp
         bpl   ]lp
         plb
         FIN
         RTS
         DO    BF_ScrlLft
IncBr3B  rep   #$30
         lda   DMsp
         ASLS  3          ; x8
         adc   DMsp       ; x9
         tax
         sep   #$21
         lda   WinXEdgeBlk
         sbc   #$10
         cmp   MapSpr,x   ; -So we can check it.
         beq   *+5
         jmp   IncBr4
         inc   DMsp
         rep   #$21
         bra   IncBr3B
         FIN

* Scroll "backward":
* Extend the PEA field up in memory, making room for another 4 pixels on the
* left edge of the screen, and draw a stripe of graphics there.
         DO    BF_ScrlLft
PeaDec   REP   #$31       ; Draw grafix 1st, in the dec routine
         LDA   #$000B
         STA   Tmp
         DO    BF_VrtFunk
         lda   GameFlags
         and   #$0001
         bne   TwistS3
         lda   #$00f0
         bra   TwistS2
TwistS3  adc   FunkReg
         ASLS  4
         sec
         sbc   FunkReg
         ASLS  4
TwistS2  clc
         ELSE
         lda   #$00F0
         clc
         FIN
         ADCl  PeaJumpPtr
         tay
         DO    BF_BlkComp
         LDA   Tmp        ; Compiled-set routine:
         CLC
         ADC   WinXBlkIDsPtr
         sta   Tmp3
]lp      lda   Tmp3
         TAX
         lda   WinXEdgeBlkFifth-1
         sep   #$20
         LDAl  MapVl-$C0,x
         rep   #$20
         JSL   Box
         tya
         clc
         adc   #$0f00
         tay
         DEC   Tmp3
         DEC   Tmp
         bpl   ]lp
         ELSE
         phb              ;   Non-compiled-set routine:
         pea   #>Blok
         plb
         plb
         LDA   WinXEdgeBlkFifth
         asl
         sta   Tmp3       ; Prepare a WinXEdgeBlkFifth x 2
         lda   WinXBlkIDsPtr
         asl
         ADC   #$0016
         sta   Tmp4
]lp      ldx   Tmp4
         LDAl  MapVl-$180,x ; Back a screen :)
         CLC
         ADC   Tmp3
         TYX
         TAY
         JSR   Box
         txa
         clc
         adc   #$0f00
         tay
         DEC   Tmp4
         DEC   Tmp4
         DEC   Tmp
         LDA   Tmp
         bpl   ]lp
         plb
         FIN
         SEP   #$30       ; THEN do computing:
         DO    BF_VrtFunk
         lda   GameFlags
         and   #$01
         beq   DecBr2
         lda   FunkFlag   ; Here on to there
         beq   DecBr1
         dec   FunkReg
         lda   FunkReg
         cmp   #$FF
         bne   DecBr2     ; Is the funkflag vertical twist code.
         lda   #$01
         sta   FunkReg
         inc   FunkFlag
         bra   DecBr2
DecBr1   inc   FunkReg
         lda   FunkReg
         cmp   #$08
         bne   DecBr2
         dec   FunkFlag
         lda   #$06
         sta   FunkReg    ; there
         FIN
DecBr2   REP   #$31
         dec   WinXEdgeTotalFifths
         ldal  PeaJumpPtr
         tay
         adc   SizTotal   ; Add total size to get to end of stack
         tax
         tya
         inc
         inc
         inc              ; Increase PeaJumpPtr for new location
         stal  PeaJumpPtr
         sep   #$20
         LDA   #$F4
         STAL  ForeFld,X  ; Don't mess up the new data!
         STAL  BackFld,x
         rep   #$20       ; Note: this is kind of unstable,
         LDA   WinXEdgeBlkFifth ; since we drew the grafix BEFORE
         BEQ   DecBr3     ; we ran this variable adjustment
         DEC   WinXEdgeBlkFifth ; routine
         bra   DecBr5
DecBr3   lda   #$04
         sta   WinXEdgeBlkFifth
         DeC   WinXEdgeBlk
         LDA   WinXBlkIDsPtr
         seC
         sbC   #$000C
         STA   WinXBlkIDsPtr
]lp      lda   DMsp
         beq   DecBr4     ; Not at 0th entry in list!
         ASLS  3          ; x8
         adc   DMsp       ; x9
         tax
         sep   #$21
         lda   WinXEdgeBlk
         sbc   #$10
         cmp   MapSpr-9,x ; -So we can check it.
         bne   DecBr4
         rep   #$21
         dec   DMsp
         lda   SpritesActiveCnt
         beq   DecBr6
         ASLS  3
         adc   SpritesActiveCnt
         tay
         sep   #$20
]lp2     lda   SprI-1,y
         cmp   DMsp
         beq   DecBr4
         LUP   9
         dey
         --^
         bne   ]lp2
         rep   #$21
         lda   SpritesActiveCnt
DecBr6   ASLS  3          ; x8
         adc   SpritesActiveCnt ; x9
         tay
         lda   MapSpr-8,x ; Move in a new sprite
         sta   SprI,y
         lda   MapSpr-6,x
         sta   SprI+2,y
         lda   MapSpr-4,x
         sta   SprI+4,y
         lda   MapSpr-2,x
         sta   SprI+6,y
         sep   #$20
         lda   DMsp
         sta   SprI+8,y
         rep   #$20
         inc   SpritesActiveCnt
         bra   ]lp
DecBr5   RTS
DecBr4   rep   #$20
]lp      lda   IMsp
         ASLS  3          ; x8
         adc   IMsp       ; x9
         tax
         LDA   MapSpr-9,x
         and   #$00ff
         beq   DecBr5     ; If it's a 0, end of list.
         cmp   WinXEdgeBlk
         bne   DecBr5     ; If it's >, can't add yet.
         dec   IMsp
         bra   ]lp
         FIN

PeaBlit  phb
         php
         rep   #$31
         tsc
         sta   ST         ; Save stack
         LDa   SizTotal
         adcl  PeaJumpPtr   ; Starts as 26e6 , total dae6
         tax
         LDA   #PeaCR*$100+$5C ; Return Jump
         STAL  ForeFld,x
         LDA   #>PeaCR
         STAL  ForeFld+2,x
         DO    BF_HeatWav
         LDA   HeatSync
         clc
         adc   SizStack
         tcs
         lda   HeatCnt
         asl
         adc   #AcidPtrn  ; Direct page to wave + offset
         adc   AcidIndx   ; Which direct page to use
         tcd
         ldx   #$0100
         tsc
         ELSE
         LDA   SizStack
         tcs
         FIN
         sep   #$21
         STAl  $e1C005
         STAl  $e1C005    ; Writes to bank 1
         REP   #$30
         JML   [PeaJumpPtr]    ; JML () doesn't compile correctly in Merlin32. Need to use JML []

PeaCR    SEP   #$20
         STAl  $e1C004
         STAl  $e1C004    ; Writes back to bank 0
         rep   #$20
         lda   #Zpl
         tcd
         lda   ST
         TCS              ; Recover stack
         DO    BF_HeatWav
         lda   HeatCnt
         asl
         adc   AcidIndx
         tax
         LDA   HeatSync
         sec
         sbcl  AcidPtrn,x ; Add in the initial Sync offset
         clc
         adc   #$00A0
         sta   HeatSync
         FIN
         plp
         plb
         RTS

DraEm    rep   #$30
         lda   #SprLevTb
         bra   Bouncy

ZapEm    rep   #$31
         lda   #ErsLevTb
Bouncy   sta   DaSpot+1
         inc
         sta   DaSpotB+1
         lda   ErAc
Earlobe  dec
         sta   ErCn
         asl
         adc   ErCn
         tax
         lda   DraW+1,x
         asl
         adc   DraW+1,x
         sec
         adcl  PeaJumpPtr
         sta   Tmp
         lda   DraW,x
         and   #$00FF
         tay
         phb
         pea   #>ForeFld
         plb
         plb
         jsr   FukinDra
         plb
         rep   #$31
         lda   ErCn
         bne   Earlobe
Whoah    rts

ZapTrol  sep   #$30
         lda   #>ErsGuiTb ; Erase jump values
         bra   Organism   ; Jump to animation routine entry

DraTrol  sep   #$30
         lda   #>SprGuiTb
Organism sta   DaSpot+2
         sta   DaSpotB+2
         ldx   #SprGuiTb
         lda   GBodyFlg_Facing
         and   #$01
         beq   Toad
         ldx   #SprGuiTb+$C0 ; second sprite set
Toad     txa
         sta   DaSpot+1
         inc
         sta   DaSpotB+1
         lda   GPositionYBlk
         cmp   #$0c
         bcs   Whoah      ; If vertical is off map, no draw
         REP   #$30
         lda   GPositionYBlk ; Vertical block comp. with reversal
         Xba
         and   #$0F00
         sta   Tmp2
         lda   GPositionYSlice
         ASLS  4
         adc   Tmp2
         sta   Tmp2       ; Saved for later
         ASLS  4
         sec
         sbc   Tmp2       ; Vertical computed
         sec
         sbc   GPositionXScreenFifth
         sec
         sbc   GPositionXScreenFifth
         sec
         sbc   GPositionXScreenFifth
         sec              ; adds 1 as well
         adcl  PeaJumpPtr ; (i.e. no this is not a mistake!)
         inc
         inc              ; in one slice for left overlap
         inc

DrawGuidoHere sec
         sbc   #BF_SizLine   ; Down 1 line
         sta   Tmp        ; Horitontal computed
         phb              ; (entry point for pipes)
         pea   #>ForeFld
         plb
         plb
         ldy   GCurrentSpr_LArm       ; The bastard's left arm
         beq   Dinkle
         jsr   FukinDra
Dinkle   ldy   GCurrentSpr_LegA       ; The bastard's leg A
         jsr   FukinDra
         ldy   GCurrentSpr_LegB       ; The bastard's leg B
         jsr   FukinDra
         ldy   GCurrentSpr_Belly      ; The bastard's belly
         jsr   FukinDra
         ldy   GCurrentSpr_RArm       ; The bastard's right arm
         jsr   FukinDra
         lda   #$0f00
         clc
         adc   Tmp        ; up one full block
         sta   Tmp
         ldy   GCurrentSpr_Head       ; The bastard's head
         jsr   FukinDra
         ldy   GCurrentSpr_Mouth       ; The bastard's mouth
         jsr   FukinDra
         ldy   GCurrentSpr_Eye       ; The bastard's eyes
         jsr   FukinDra
         plb
         rts

         MX    %00
FukinDra tya
         sta   Tmp2
         asl
         adc   Tmp2
         tax
DaSpot   ldal  SprGuiTb,x
         stal  FukDra+1
DaSpotB  ldal  SprGuiTb+1,x
         AND   #$0FFf
         stal  FukDra+2
         ldx   Tmp
FukDra   jsl   $080000
         rep   #$30       ; Set things back from possible 8-bit
Thwonk   rts              ; sprite drawing

         lst   on
*
* Sprite activation/item checker v0.2
         lst   off

         MX    %10
ChItem   cmp   #BlkId_Sprt8+1    ; If sprite activating:
         bcs   ChItem2
         cmp   #BlkId_Sprt1
         bcc   ChItem2
         stx   Itm
         sta   Itm2
         rep   #$30
         and   #$00FF
         sec
         sbc   #BlkId_Sprt1
         asl
         tax
         jsr   (ActList,x)
NonAct   rep   #$10
         sep   #$20
         ldx   Itm
         lda   Itm2
         rts
         MX    %10
ChItem2  cmp   #BlkId_EmptyDeadly  ; If deadly:
         beq   ClrHurt
         cmp   #BlkId_CoinA
         bcc   Thwonk     ; If takable:
         cmp   #BlkId_FoodB+1
         bcs   Thwonk
         stx   Itm
         sta   Itm2       ; Store the variables
         cmp   #BlkId_CoinB      ; If it's in group II,
         bcs   *+6        ; replace with and draw block $01
         lda   #$00       ; instead of $00
         bra   *+4
         lda   #$01
         sta   MapVl,x    ; MOD
         stz   MapBl,x    ; Stick in clear block i.d
         sta   Tmp3       ; (BlokZap uses Tmp3 for replace)
         stz   Tmp3+1
         jsr   BlokZap    ; Erase it
         sep   #$20
         lda   #$05
         sta   Score2+1   ; 50 points awarded
         jsr   ScoreAdd
         sep   #$20
         lda   Itm2
         cmp   #BlkId_CoinA
         beq   Dimwit     ; If it's a consumable item,
         cmp   #BlkId_CoinB      ; Add to the timer as well.
         beq   Dimwit
         lda   #$01
         sta   Time2+1
         jsr   TimeAdd
Dimwit   sep   #$20
]lp      rep   #$10
         ldx   Itm        ; And restore the variables
         lda   Itm2
         rts

ClrHurt  stx   Itm        ; Hurt Guido
         sta   Itm2
         jsr   Verdict    ; Verdict must return with A: 8 bit
         cmp   #$69
         beq   ]lp
         pla
         pla
         jmp   Die

         MX    %00
         ldx   Itm
BlokZap  rep   #$31
         ldy   #$0000
         txa
         adc   #$00C0
         sec
         sbc   WinXBlkIDsPtr ; subtract the calculated column
         cmp   #$000b     ; if the remainder is initially below one column,
         bcc   Kissem     ; set up a partial erasure
]lp      cmp   #$000b
         bcc   Bitem
         sec
         sbc   #$000c
         iny
         bra   ]lp
Bitem    ldx   #$0005
         stx   Tmp2
         bra   Chompem
Kissem   tax
         lda   #$0004
         sec
         sbc   WinXEdgeBlkFifth
         sta   Tmp2
         txa
Chompem  sta   DWNt       ; Store the blox down for safekeeping
         eor   #$F
         sec
         sbc   #$4        ; Like subtracting it from $b
         sta   Tmp
         ASLS  4
         sec
         sbc   Tmp
         XBA              ; xF
         and   #$FF00     ; xF00
         ORA   #$00F0     ; Add in a 1 line offset to subract H loc into
         tax
         tya
         sta   Tmp
         sta   OVRt       ; store the blox over for later
         ASLS  4
         sec
         sbc   Tmp        ; blox over x15
         sta   Tmp
         txa
         sec
         sbc   Tmp
         tax
         lda   WinXEdgeBlkFifth
         asl
         adc   WinXEdgeBlkFifth ; Sub-block offset, x3
         eor   #$0F
         sec
         sbc   #$03
         sta   Tmp        ; inverted, from $C
         txa
         sec
         sbc   Tmp        ; - the total
         clc
         adcl  PeaJumpPtr ; + the current offset
         DO    BF_BlkComp
         tay
         lda   #$0400
         ORA   Tmp3
]lp      sta   Tmp
         jsl   Box
         iny
         iny
         iny
         lda   Tmp
         sec
         sbc   #$0100
         dec   Tmp2
         bne   ]lp
         ELSE
         tax
         lda   #$0008
         clc
         adc   Tmp3
         tay
         phb
         pea   #>Blok
         plb
         plb
]lp      jsr   Box
         inx
         inx
         inx
         dey
         dey
         dec   Tmp2
         bne   ]lp
         plb
         FIN
         sep   #$20       ; Back the way you found it!
         rts

* Calculate a location in the screen memory (and place in y)
* Calculate a location in the PEA field (and place in x)
* These locations correspond to a corner of where Guido is standing,
* and can be used to perform animations in a contained space,
* e.g. moving Guido vertically down in the space until he's outside
* it, which will naturally clip Guido off at the edge of the
* space, so it appears he's going down a pipe that's already present
* on the screen below the space.
DoorCompute REP   #$30
         lda   GPositionYBlk ; Vertical block comp. with reversal
         Xba
         and   #$0F00
         sta   Tmp2
         lda   GPositionYSlice
         ASLS  4
         adc   Tmp2
         sta   Tmp2       ; Saved for later
         eor   #$0FFF     ; just like subtracting it from $BF0
         sec
         sbc   #$040F
         sta   Tmp3
         ASLS  2
         adc   Tmp3
         clc              ; xA, plus screen offset x2
         adc   GPositionXScreenFifth
         asl
         adc   #SHR+$A7   ; MOD 3 less than location for left-overlap
         tay              ; =SHR screen location
         lda   Tmp2
         ASLS  4
         sec
         sbc   Tmp2       ; Vertical done
         sta   Tmp2
         ldal  PeaJumpPtr
         sec
         sbc   GPositionXScreenFifth
         sec
         sbc   GPositionXScreenFifth
         sec
         sbc   GPositionXScreenFifth
         clc
         adc   Tmp2
         sec
         sbc   #$000c     ; Subtract 13 bytes- that is, 4 PEAs
         tax              ; (including left edge overlap for Guido)
         rts

         MX    %00
LSideOut stx   WindowedPEA       ; Frame in PEA field
         txa
         clc
         adc   #$000f
         sta   WindowedGuido ; DraTrol's in PEA field
         sty   SizStack   ; Screen location
         lda   #$0006
         sta   Lupe
]lp      jsr   WaitSync
         jsr   WaitSync
         jsr   WaitSync
         jsr   WindowedBlit
         lda   WindowedGuido
         inc
         inc
         inc
         sta   WindowedGuido
         dec   Lupe
         bne   ]lp
         stz   WindowedPEA
         rts

RSideOut stx   WindowedPEA       ; Frame in PEA field
         txa
         clc
         adc   #$000f
         sta   WindowedGuido       ; DraTrol 's in PEA field
         sty   SizStack   ; Screen location
         lda   #$0006
         sta   Lupe
]lp      jsr   WaitSync
         jsr   WaitSync
         jsr   WaitSync
         jsr   WindowedBlit
         lda   WindowedGuido
         dec
         dec
         dec
         sta   WindowedGuido
         dec   Lupe
         bne   ]lp
         stz   WindowedPEA
         rts

DownOut  txa              ; Frame in PEA field
         clc
         adc   #BF_SizLine
         sta   WindowedPEA
         txa
         clc
         adc   #$000f
         sta   WindowedGuido       ; DraTrol's in PEA field
         tya
         sec
         sbc   #$00A0
         sta   SizStack   ; Screen location
         tay
         phb
         pea   #>SHR
         plb
         plb
         ldal  ForeFld+1,x ; Erase Guido's feet, which would otherwise remain outside the window,
         sta   $009F,y     ; because when Guido is standing on a block, he is drawn with his feet
         ldal  ForeFld+4,x ; overlapping the block below by 1 pixel.
         sta   $009D,y
         ldal  ForeFld+7,x
         sta   $009B,y
         ldal  ForeFld+10,x
         sta   $0099,y
         ldal  ForeFld+13,x
         sta   $0097,y
         plb
         lda   #$001f
         sta   Lupe
]lp      jsr   WaitSync
         jsr   WindowedBlit
         lda   WindowedGuido
         sec
         sbc   #BF_SizLine
         sta   WindowedGuido
         dec   Lupe
         bne   ]lp
         stz   WindowedPEA
         rts

WindowedBlit sep   #$30
         lda   #>SprGuiTb
* JSR ahead to the part of this windowing code that draws/erases, to draw Guido.
* When it returns, we draw the frame and blit it, then run into the same code
* to erase Guido, where the RTS will return us to the caller. 
         jsr   SkipAheadToDraw  ; Jump ahead 
         MX    %00
         lda   WindowedPEA
         stal  PeaJumpPtr
         tax
         ldy   #$0021
]lp      lda   #$a0e9       ; Replace PEA instructions
         stal  ForeFld+$F,x ; with some stack pointer math (SBC #$00A0, TCS)
         lda   #$1b00       ; and a BRL to the next line
         stal  ForeFld+$11,x
         lda   #BF_SizLine-$16*$100+$82
         stal  ForeFld+$13,x ; Establish frame
         lda   #$0000
         stal  ForeFld+$15,x
         txa
         clc
         adc   #BF_SizLine
         tax
         dey
         bne   ]lp
         clc
         adc   #$000F
         sec
         sbcl  PeaJumpPtr
         sta   SizTotal
         jsr   PeaBlit    ; Blit frame
         sep   #$30
         lda   #>ErsGuiTb ; Erase him

SkipAheadToDraw sta   DaSpot+2
         sta   DaSpotB+2
         ldx   #SprGuiTb
         lda   GBodyFlg_Facing
         and   #$01
         beq   :Br1
         ldx   #SprGuiTb+$C0
:Br1     txa
         sta   DaSpot+1
         inc
         sta   DaSpotB+1
         rep   #$30
         lda   WindowedGuido
         inc
         jmp   DrawGuidoHere

DoorGo =     *
         DO    BF_DeRezz
         jsr   RezzOut
         ELSE
* If we're not doing the de-rezz, fade the screen out.
         rep   #$30
         ldx   #$01FE     ; Fader data to 0's
         lda   #$0        ; (as long as FadeDat is in prog bank)
]lp      stal  FadeDat,x
         dex
         dex
         bpl   ]lp
         stz   FadeRate
         jsr   FadeLoop
         FIN
* Connect for doorway (pipe, etc):
* 0-1: Compiled location of door
* 2:   Horz destination location
* 3: Vert destination location
* 4: Horz window destination location
* 5: Horz strip on block (GPositionXFifth)
* 6:
* 7: 0 Internal   + letter
*    1 New area   + 0-3
*    2 New packet + 0-15
*    3 New world  + 1-9
         rep   #$30
         ldx   #$0
]lp      lda   Connects,x
MapLocWrite cmp   #$0   ; Map location we're comparing against is written into here earlier.
         beq   :Br1
         txa
         clc
         adc   #$0008
         tax
         cmp   #$0100
         bne   ]lp
         ldx   #$0        ; Not found?  Use start of level connect.
:Br1     stx   MapIndex
         lda   Connects+7,x
         and   #$0003     ; 6: Acid Land: Table number for heat wave
         asl
         txy
         tax
         jmp   (Bowie,x)

Bowie    DA    NewLoc2,NewArea,NewPack2,0

NewArea  stz   MapIndex
         lda   Connects+7,y
         and   #$0030
         LSRS  4
         stal  WldIndx+ShelPage
         jmp   TrolPlay
NewPack2 stz   MapIndex
         lda   #$0000
         stal  WldIndx+ShelPage
         lda   Connects+7,y
         and   #$00F0
         LSRS  4
         stal  WldSect+ShelPage
         jmp   NewPack

GameOver clc
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
         beq   :Yes   ; player again.
         cmp   #"y"
         bne   *+5
:Yes     jmp   TrolPlay
         brk   00
         brk   00

         DO    BF_BlkComp
Box      =     $030000    ; Block set
         ELSE
Box      =     *          ; OR block drawing subroutine
]lp2     =     0
]lp      =     $e11
         LUP   16
         lda   Blok+]lp2,y
         STAl  ForeFld+]lp,x
         STAl  BackFld+]lp,x
]lp      =     ]lp-$F0
]lp2     =     ]lp2+$A
         --^
         RTS
         FIN

         PUT   LIB/SCOREADD

         PUT   LIB/TIMEADD

         PUT   LIB/LIVESINC

         PUT   LIB/WAITSYN

         PUT   LIB/WAITKEY

         PUT   LIB/CHSOLID

ActList  =     *
]lp      =     0

         DO    BF_S_Flowr
         DA    Flower10,Flower01,Flower11
]lp      =     ]lp+3
         FIN

         LUP   6-]lp
         DA    NonAct
         --^
         DA    FlagTop,FlagPole

         lst   on
*
* Sprite updater v0.03
         lst   off

SprUp    rep   #$30
         lda   SpritesActiveCnt
         sta   SpCn
         stz   ErAc
TopSpr   dec   SpCn
         lda   SpCn
         ASLS  3          ; sprite current x9
         adc   SpCn
         tax
         lda   ErAc
         asl
         adc   ErAc       ; Onscreen current x3
         tay
         lda   SprI,x
         stx   Tmp        ; Temporarily save X-
         and   #$00FF
         asl
         tax              ; So we can use an index.
         sep   #$20
         jsr   (SpritePointers,x)
         rep   #$30
         lda   SpCn
         bne   TopSpr
         rts

KillMe   ldx   Tmp
KillDis  sep   #$20       ; REMOVE the current sprite
         dec   SpritesActiveCnt
         beq   KillRet
         lda   SpritesActiveCnt
         cmp   SpCn
         beq   KillRet
         rep   #$20
         lda   SpritesActiveCnt
         ASLS  3          ; x8
         adc   SpritesActiveCnt ; x9
         tay
         lda   SprI,y     ; Shift the last
         sta   SprI,x     ; on the list
         lda   SprI+2,y
         sta   SprI+2,x   ; to the empty slot
         lda   SprI+4,y
         sta   SprI+4,x
         lda   SprI+6,y
         sta   SprI+6,x
         lda   SprI+7,y
         sta   SprI+7,x
KillRet  rts

SpritePointers = *
         DA    KillMe
IDBrickBits = {*-SpritePointers} / 2
         DA    AnBrik
         DA    Flag
IDPuffSmoke = {*-SpritePointers} / 2
         DA    PuffSmoke
IDMushroom = {*-SpritePointers} / 2
         DA    Mushey
IDCoinGet = {*-SpritePointers} / 2
         DA    CoinGet
         DO    BF_S_Turtl
         DA    TurtleSp
         DA    Shell
         FIN
         DO    BF_S_Flowr
* Without using {} here, Merlin32 gets the precedence wrong.
* {} are supported by Merlin16 so this remains compatible.
IDFlower =     {*-SpritePointers} / 2
         DA    SH_Flower
         FIN
         DO    BF_S_Snail
         DA    SH_Snail
         FIN
         DO    BF_S_Chstr
         DA    SH_Chester
         FIN
         DO    BF_Recordr
IDRecorder =   {*-SpritePointers} / 2
         DA    Recorder
         FIN
IDPlayer =     {*-SpritePointers} / 2
         DA    SH_Player

         PUT   LIB/BRIKBITS

         PUT   LIB/FLAGPOLE

         PUT   LIB/PUFFSMOK

         PUT   LIB/MUSHROOM

         PUT   LIB/COINGET

         DO    BF_S_Turtl
         PUT   LIB/TURTLE
         FIN

         DO    BF_S_Flowr
         PUT   LIB/FLOWER
         FIN

         DO    BF_S_Snail
         PUT   LIB/SLIMBAL
         FIN

         DO    BF_S_Chstr
         PUT   LIB/CHESTER
         FIN

         DO    BF_Recordr
         PUT   LIB/RECORDER
         FIN

         PUT   LIB/PLAYER

         DO    BF_SFXCode
         PUT   LIB/PLAYSFX
         FIN

         DO    BF_DeRezz
         PUT   LIB/DEREZZ
         FIN

         DO    Debugger
         PUT   LIB/DEBUGGER
         FIN

         lst   on
*
*  Thanx to: Alex, Andy, Brad, Bradley, Brent,
*            Emily, Fred, Jon, Justin, Mike, Peter,
*  Petrea, Phil, Skot, Tara, Tuna, and Zach
*
*  Special special thanx to: The FTA
*               No thanx to: GS/OS
*
*  With a compliment to the author of this
*  incredible assembler, Glen Bredon.
*
*     :)
         lst   off
