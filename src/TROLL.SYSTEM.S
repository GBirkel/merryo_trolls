               LST        ON
* Trolls pre-loader v0.1e2
* (c) Garote '94
*
         LST   OFF

         XC
         XC
         MX    %00

         TYP   $FF

]Z0      =     $00

         DUM   ]Z0        ; Zpage for all other programs
WldNumb  DS    2          ; Globals
WldSect  DS    2          ; Map packet #
WldIndx  DS    2          ; Map index # (0-3)
LevLet   DS    2          ; Level letter
LevSect  DS    2          ; Level section letter
WldLives DS    2          ; Initial lives
WldScore ds    8          ; Initial score
WldCndtn ds    2          ; Initial condition (0-3)
WldStats ds    2          ; Initial status (form)
Tmp      DS    2
Tmp2     DS    2
Tmp3     DS    2
Tmp4     DS    2
]Z0      =     *
         DEND

*------------------------------- Macros

BORD     MAC
         DO    BordTime
         php
         sep   #$20
         lda   #]1
         stal  $e1c034
         plp
         FIN
         EOM

DIR      MAC
N0       STR   ]1
N1
         DS    13-N1+N0
         ADR   ]2
         EOM

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

_Err     MAC
         BCC   *+8
         xce
         lda   #]1
         JSR   SysDeth
         EOM

*------------------------------- Build-time flags

BordTime =     1

DoBlComp =     1          ; Assemble compiled blockset
GdRecord =     1          ; Include joystick path recorder
Slope    =     1          ; Include platform slopes
VertFunk =     1          ; Vertical "funky" effect
ScrlLeft =     1          ; Whether the screen can scroll left
HeatWave =     1

         PUT   PRG/BITS/MEMORYMAP

BootProg =     $002000

TitleStr =     $030000

Blok     =     $030000    ; an ELSE command normally renders this undefined

KQVSlot  =     $030000    ; Kq program scene slot
KQVDirec =     $040000    ; initial destination for KQV-clone format

         ORG   BootProg
         jmp   RealBegn

         PUT   PRG/BITS/CHARGEN

         PUT   PRG/BITS/FADER

         PUT   PRG/BITS/WAITSYN

         PUT   PRG/BITS/MOUSE

TxtClr   HEX   00000002000002060001050104090C0A

RealBegn clc              ; VERY FIRST action, move the loader.
         xce              ; -so prefix addresses are present
         REP   #$30

         lda   #$8096
         sta   $c035

         ldx   #LoadMove
         ldy   #Loader
         lda   #OpenBuf-Loader
         mvn   #LoadMove,#Loader

         JSL   $FE0000
         rep   #$30
         LDA   #0
         tcd
         STAL  $E115FE
         LDX   #$0105     ; ToolLocator Reset
         JSL   $E10000
         lda   #$ff59     ;reset -> monitor
         sta   $03f2

         sec
         xce
         JSR   $BF00
         DFB   $C7        ; GetPrefix
         DA    PfxParm    ; Save it for the main prog
         _Err  0

         LDA   #$FF
         EOR   #$A5
         STA   $03F4
         LDX   #$17
]lp      STZ   $BF57,X
         dex
         Bne   ]lp
         LDA   #1
         STA   $BF6F

         LDA   #$41
         STA   $C029      ; Standard linear mapped ShrA (not on)
         ldx   #3         ;fade text screen to black
]lp      jsr   WaitSync
         lda   $c034
         and   #$0f
         tay
         lda   TxtClr,y
         sta   $c034
         lda   $C022
         and   #$0f
         tay
         lda   TxtClr,y
         sta   $00
         lda   $C022
         and   #$f0
         LSRS  4
         tay
         lda   TxtClr,y
         ASLS  4
         ora   $00
         sta   $C022
         jsr   WaitSync   ; Fuck it up pigface
         jsr   WaitSync
         dex
         bne   ]lp

         STA   $C000
         STA   $C00C      ; 80Col Off - display 40 columns
         LDY   #$12       ;uuhhhhhhhhhh
         JSR   $FEB4
         JSR   $FB2F      ; "Initialize system"
         JSR   $FE89      ; "Reset input to keyboard"
         JSR   $FE93      ; "Reset I/O to slots"?
         JSR   $FC58      ; "Home cursor and clear screen"

         JSR   $BF00
         DFB   $C6        ; [SetPrefix] to where THIS prog is
         DA    PfxParm
         _Err  0

         clc
         xce
         REP   #$30

         lda   #$0041
         jsl   Loader     ; Load the splash screen
         SEP   #$30
         JSR   WaitSync
         LDa   #$C1
         STA   $c029      ; Turn on ShrA to show it
         rep   #$30
         lda   #$0042
         jsl   Loader     ; Character set
         lda   #$0043
         jsl   Loader     ; TROLLS title screen
         lda   #ShelPage  ; Wipe zero page clean before use
         tcd
         ldx   #$00FE
]lp      stz   Zpl,x
         stz   $00,x
         dex
         dex
         bpl   ]lp
         lda   #$0000
         ldx   #$1FE
]lp      stal  FadeDat,x
         dex
         dex
         bpl   ]lp
         stz   FadeRate
         jsr   FadeLoop
         rep   #$30
         phb
         pea   #>TitleStr
         plb
         plb
         ldx   #$7dc6
]lp      lda   TitleStr,x
         stal  ShrA,x
         dex
         dex
         bpl   ]lp
         ldx   #$01fe
]lp      lda   TitleStr+$7E00,x
         stal  FadeDat,x
         dex
         dex
         bpl   ]lp
         plb
         jsr   FadeLoop   ; fade in title screen
         rep   #$30

         lda   #190/2+4   ; Mouse setup
         sta   MouseY
         lda   #312/2+3
         sta   MouseX
         stz   Button
         stz   OldMIndx

         jsr   MsgPrint
         HEX   FF0300                       ; C:Left margin=0
         HEX   FF000000                     ; C:H=0,V=0
         HEX   FF020010                     ; C:data offset = $1000
         HEX   FF01FFFF                     ; C:col=3
         HEX   AeAfcacbd8d9c6c7dedfdadbcacb ; "WWeellccoommee"      (14)[14]
         HEX   00a8a9dedf00                 ; " TToo "               (6)[20]
         HEX   FF01AAAA1a1b1c               ; C:col=2 "MMM"          (3)[23]
         HEX   FF01555502030c251213060900   ; C:col=1 "AARRIIOO "    (9)[32]
         HEX   FF01AAAA40411f               ; C:col=2 "TTT"          (3)[35]
         HEX   FF0155550c250609181918192627 ; C:col=1 "RROOLLLLSS"  (10)[45]
         HEX   FF020000                     ; C:data offset = $0000
         HEX   FFFF                         ; C:return

         sep   #$20
ClearIt  stal  $01c010
UpdtLoop jsr   DoMouse
         rep   #$30
         lda   Button     ; If the button is not down,
         AND   #$0002     ; don't check the location
         beq   :Br1
         lda   MouseY
         cmp   #$0018
         bcs   :Br1
         jmp   Start
:Br1     sep   #$20       ; If no key
         ldal  $e1c000
         bpl   UpdtLoop   ; Skip check
         stal  $e1c010
         ora   #$80
         ldx   #ButtnJmp-DrLetter-1
]lp      cmp   DrLetter,x
         bne   NoKeyFnd
         rep   #$21
         txa
         asl
         tax
         lda   #$0000
         jmp   (ButtnJmp,x)
NoKeyFnd dex
         bpl   ]lp
         bra   ClearIt

DrLetter ASC   "SsCcIiTt12345678"

ButtnJmp DA    Start,Start,Continue,Continue,Info,Info,Settings,Settings
         DA    Run1,Run2,Run3,Run4,Run5,Run6,Run7,Run8

Run8     inc
Run7     inc
Run6     inc
Run5     inc
Run4     inc
Run3     inc
Run2     inc
Run1     inc
         bra   RunBran

Continue =     *
Info     =     *
Settings =     *
Start    =     *
         MX    %00
         lda   #$0001
RunBran  sta   WldNumb
         sep   #$30
         lda   #$00
         sta   WldSect
         lda   #$00
         sta   WldIndx

         lda   WldSect
         ASLS  2
         adc   WldIndx
         sta   LevSect

         rep   #$30
         stz   WldScore   ; Score to 0,
         stz   WldScore+2
         stz   WldScore+4
         stz   WldScore+6
         lda   #$0003     ; Lives to 3,
         sta   WldLives
         lda   #$0001     ; Condition to 1,
         sta   WldCndtn
         lda   #$005F
         clc
         adc   WldNumb
         jsl   Loader     ; Main Prog

         JML   ThisProg   ; And run it!

*------------------------------------------------------------------------

LoadMove =     *

         LST   ON
* DGOD file-loader v0.1b
* Modified from Trolls P8 loader routine
* Modified from FTA's Bouncin'Ferno P8 Loader
* Garote '93
*
         LST   OFF

LoadSize =     $4000

         DUM   $00        ; Zpage
PtrLoad  DS    4
PntList  DS    2
         DEND

         MX    %00

         ORG   Loader

ReadBuf  =     *-LoadSize

         phb              ; Must be JSLd to
         phd              ;in full native mode
         PEA   #$0000     ; Direct page and bank to 0
         plb
         plb
         PEA   #$0000
         pld
         and   #$00FF
         ASLS  4
         adc   #List
         sta   PntList
         sta   FileName   ; Store the address
         sec              ; of the record in FileName
         xce              ; To non native mode, for prodos calls

Open     JSR   $BF00
         DFB   $C8        ; [Open] the file with a prodos call
         DA    OpenParm
         BCC   FndFile

         LDA   (PntList)
         TAY
         LDA   (PntList),Y
         CMP   #'.'          ; look and see if the name in the
         BNE   TryComp       ; list has a ".C" suffix.  If it does,
         sec
         _Err  2

TryComp  INY
         LDA   #'.'
         STA   (PntList),Y  ; add a ".C" suffix to the entry name
         TYA
         STA   (PntList)
         BRA   Open

FndFile  LDA   Ref
         STA   ReadRef    ; Spread the file reference #
         STA   CloseRef   ; to the other routines
         LDY   #13
         LDA   (PntList),Y
         STA   PtrLoad
         INY                 ; Get the file's load pointer
         LDA   (PntList),Y   ; into PtrLoad
         STA   PtrLoad+1
         INY
         LDA   (PntList),Y
         STA   PtrLoad+2

Moreload JSR   $BF00
         DFB   $CA        ; [Read] a block
         DA    ReadParm
         BCC   NoErr      ; If no error, or if the error was $4C,
         CMP   #$4C       ; Go ahead.  If not, crash!
         BEQ   NoErr
         sec
         _Err  1

NoErr    LDA   TransCnt
         ORA   TransCnt+1
         BEQ   EndLoad
         clc
         xce
         REP   #$31
         LDA   TransCnt
         BIT   #1
         Bne   NoOdd
         DEC
NoOdd    DEC
         TAY
]lp      LDA   ReadBuf,Y    ; Move up the file data from the buffer,
         STA   [PtrLoad],Y  ; and put it in it's proper place
         DEY
         DEY
         BPL   ]lp
         lda   TransCnt
         ADC   PtrLoad    ; Increment the destination point
         STA   PtrLoad    ; By how much we've already moved
         bcc   *+4
         inc   PtrLoad+2
         LDA   TransCnt
         CMP   #LoadSize       ; If this last move is complete, and still
         sec
         xce
         BEQ   Moreload         ; no file end, load more.

EndLoad  JSR   $BF00
         DFB   $CC        ; [Close] the file
         DA    ClosePrm
         _Err  1

         LDA   (PntList)
         TAY
         LDA   (PntList),Y
         CMP   #'.'         ; If the file has the ".C" suffix,
         clc
         xce
         BNE   NoCompac

         REP   #$31       ; native mode
         LDY   #13
         LDA   (PntList),Y
         TAX
         INY                ; give the decruncher the address,
         INY
         LDA   (PntList),Y
         AND   #$00FF
         TAY
         JSR   Decrunch   ; and decrunch the file.

NoCompac rep   #$30
         pld
         plb
         rtl

         PUT   PRG/BITS/DECOMPACT

         MX    %11

SysDeth  ASLS  4
         ora   #$0F
         tax
         lda   #$41
         stal  $e1c029
         LDA   #$F0
         STA   $e1c022
         lda   #$00
         stal  $e1c035    ; Attempt to make the
         stz   $c054      ; text screen visible
         stz   $c051
         pha
         plb
         ldy   #16        ; Print error msg
]lp      lda   ErrMsg,x
         sta   $05B3,y
         dex
         dey
         bne   ]lp
         clc
         xce
         rep   #$20
         pla              ; Pull JSR value into A reg

         brk   00
         brk   00         ; CrashTime!

ErrMsg   FLS   "VOLUME NOT FOUND"
         FLS   " DISK I/O ERROR "
         FLS   " FILE NOT FOUND "
         FLS   "    YOU SUCK    "

PfxParm  HEX   01
         DA    $0300      ; Standard prefix location

OpenParm HEX   03
FileName DA    0
         DA    OpenBuf
Ref      DFB   0

ReadParm HEX   04
ReadRef  DFB   0
         DA    ReadBuf
         DA    LoadSize   ; How much to load
TransCnt DA    0

ClosePrm HEX   01
CloseRef DFB   0

ListDA   DA    List
         DS    */$10+1*$10-*     ; Make a gap to the nearest $10 in memory

List     DIR   'BLKS/WD11';Blox ; Wd1 Blocks             00
         DIR   'BLKS/WD21';Blok ; Wd2 Blocks             01
         DIR   'BLKS/WD31';Blox ; Wd3 Blocks             02
         DIR   'BLKS/WD41';Blok ; Wd4 Blocks             03
         DIR   'BLKS/WD51';Blox ; Wd5 Blocks             04
         DIR   'BLKS/WD61';Blox ; Wd6 Blocks             05
         DIR   'BLKS/WD71';Blok ; Wd7 Blocks             06
         DIR   'BLKS/WD91';Blok ; Special World Blocks   07

         DIR   'BLKS/WD11t';Table ; Wd1 Blockmaker table 08
         DIR   'ERROR';0  ; Empty slot                   09
         DIR   'BLKS/WD31t';Table ; Wd3 Blockmaker table 0A
         DIR   'ERROR';0  ; Empty slot                   0B
         DIR   'BLKS/WD51t';Table ; Wd5 Blockmaker table 0C
         DIR   'BLKS/WD61t';Table ; Wd6 Blockmaker table 0D
         DIR   'ERROR';0  ; Empty slot                   0E

         DIR   'SPR/SPR1';SpriRaw ; Wd1 Level sprites    0F
         DIR   'SPR/SPR1G';SpriRaw ; Wd1 Guido sprites   10
         DIR   'SPR/SPR2';SpriRaw ; Wd2 Level sprites    11
         DIR   'SPR/SPR2G';SpriRaw ; Wd2 Guido sprites   12
         DIR   'SPR/SPR3';SpriRaw ; Wd3 Level sprites    13
         DIR   'SPR/SPR3G';SpriRaw ; Wd3 Guido sprites   14
         DIR   'SPR/SPR4';SpriRaw ; Wd4 Level sprites    15
         DIR   'SPR/SPR4G';SpriRaw ; Wd4 Guido sprites   16
         DIR   'SPR/SPR5';SpriRaw ; Wd5 Level sprites    17
         DIR   'SPR/SPR5G';SpriRaw ; Wd5 Guido sprites   18
         DIR   'SPR/SPR6';SpriRaw ; Wd6 Level sprites    19
         DIR   'SPR/SPR6G';SpriRaw ; Wd6 Guido sprites   1A
         DIR   'SPR/SPR7';SpriRaw ; Wd7 Level sprites    1B
         DIR   'SPR/SPR7G';SpriRaw ; Wd7 Guido sprites           1C
         DIR   'SPR/SPR9';SpriRaw ; Special World Level sprites  1D
         DIR   'SPR/SPR9G';SpriRaw ; Special World Guido sprites 1E
         DIR   'SPR/SPR1';SpriRaw ; Wd8 Level sprites (so far)   1F
         DIR   'BLKS/WD81';KQVDirec ; Wd8 Guido sprites          20

         DIR   'MAPS/WD1A';Slots ; Wd1 Map block A 21
         DIR   'MAPS/WD1B';Slots ; Wd1 Map block B 22
         DIR   'MAPS/WD2A';Slots ; Wd2 Map block A 23
         DIR   'MAPS/WD2B';Slots ; Wd2 Map block B 24
         DIR   'MAPS/WD3A';Slots ; Wd3 Map block A 25
         DIR   'MAPS/WD3B';Slots ; Wd3 Map block B 26
         DIR   'MAPS/WD4A';Slots ; Wd4 Map block A 27
         DIR   'MAPS/WD4B';Slots ; Wd4 Map block B 28
         DIR   'MAPS/WD5A';Slots ; Wd5 Map block A 29
         DIR   'MAPS/WD5B';Slots ; Wd5 Map block B 2A
         DIR   'MAPS/WD6A';Slots ; Wd6 Map block A 2B
         DIR   'MAPS/WD6B';Slots ; Wd6 Map block B 2C
         DIR   'MAPS/WD7A';Slots ; Wd7 Map block A 2D
         DIR   'MAPS/WD7B';Slots ; Wd7 Map block B          2E
         DIR   'MAPS/WD9A';Slots ; Secret World Map block A 2F

         DIR   'KQD/KQ.PIC1';KQVSlot ; Wd8 Beginnig scene block 30
         DIR   'ERROR';0  ; Empty slot                          31
         DIR   'ERROR';0  ; Empty slot 32
         DIR   'ERROR';0  ; Empty slot 33
         DIR   'ERROR';0  ; Empty slot 34
         DIR   'ERROR';0  ; Empty slot 35
         DIR   'ERROR';0  ; Empty slot 36
         DIR   'ERROR';0  ; Empty slot 37
         DIR   'ERROR';0  ; Empty slot 38
         DIR   'ERROR';0  ; Empty slot 39
         DIR   'ERROR';0  ; Empty slot 3A
         DIR   'ERROR';0  ; Empty slot 3B
         DIR   'ERROR';0  ; Empty slot 3C
         DIR   'ERROR';0  ; Empty slot 3D
         DIR   'ERROR';0  ; Empty slot 3E
         DIR   'ERROR';0  ; Empty slot 3F

         DIR   'SPEC/ACIDPT';AcidPtrn ; Acid land wave patterns 40
         DIR   'PX/SPLASH';ShrA ; Splash screen   41
         DIR   'CHARSET';Char ; Chracter set      42
         DIR   'PX/TITLE';TitleStr ; Title page   43
         DIR   'PRG/CREDITS';ThisProg ; Main Prog 44
         DIR   'SPEC/CRDF1';$024000 ; Credits font 1 45
         DIR   'SPEC/CRDF1';$028000 ; Credits font 2 46
         DIR   'ERROR';0  ; Empty slot 47

         DIR   'SFX/HADOU';SFXdata ; Sound effects for world 1 48
         DIR   'ERROR';0  ; Empty slot 49
         DIR   'ERROR';0  ; Empty slot 4A
         DIR   'ERROR';0  ; Empty slot 4B
         DIR   'ERROR';0  ; Empty slot 4C
         DIR   'ERROR';0  ; Empty slot 4D
         DIR   'ERROR';0  ; Empty slot 4E
         DIR   'ERROR';0  ; Empty slot 4F

         DIR   'ERROR';0  ; Empty slot 50
         DIR   'ERROR';0  ; Empty slot 51
         DIR   'ERROR';0  ; Empty slot 52
         DIR   'ERROR';0  ; Empty slot 53
         DIR   'ERROR';0  ; Empty slot 54
         DIR   'ERROR';0  ; Empty slot 55
         DIR   'ERROR';0  ; Empty slot 56
         DIR   'ERROR';0  ; Empty slot 57
         DIR   'ERROR';0  ; Empty slot 58
         DIR   'ERROR';0  ; Empty slot 59
         DIR   'ERROR';0  ; Empty slot 5A
         DIR   'ERROR';0  ; Empty slot 5B
         DIR   'ERROR';0  ; Empty slot 5C
         DIR   'ERROR';0  ; Empty slot 5D
         DIR   'ERROR';0  ; Empty slot 5E
         DIR   'ERROR';0  ; Empty slot 5F

         DIR   'PRG/TROLL1';ThisProg ; Main Prog 60
         DIR   'PRG/TROLL2';ThisProg ; Main Prog 61
         DIR   'PRG/TROLL3';ThisProg ; Main Prog 62
         DIR   'PRG/TROLL4';ThisProg ; Main Prog 63
         DIR   'PRG/TROLL5';ThisProg ; Main Prog 64
         DIR   'PRG/TROLL6';ThisProg ; Main Prog 65
         DIR   'PRG/TROLL7';ThisProg ; Main Prog 66
* DIR 'PRG/TROLL8';ThisProg ; Main Prog 67
         DIR   'PRG/CREDITS';ThisProg ; Main Prog 67 (test)

         DS    \
OpenBuf  =     *
