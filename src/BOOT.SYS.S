         LST   ON
* Trolls framework/shell v0.3d
* (c) Garote '93
         LST   OFF

PreData  =     $000428    ; Current character data
ThisProg =     $002000

ScrnRaw  =     $012000

DataII   =     $020000    ; Special data for this world
SprGuiTb =     $025000    ; MainChar sprites jmp table
SprLevTb =     SprGuiTb+$400 ; Other sprites jmp table
ErsGuiTb =     SprGuiTb+$800 ; MainCher eraser jmp table
ErsLevTb =     ErsGuiTb+$400 ; Other eraser jmp table
TrollsEntry =  $02C000

Blok     =     $030000    ; Block set
Char     =     $038000    ; Character set

Slots    =     $050000    ; Storage slots for levels

SprProg  =     $070000    ; These should match the spritemaker
ErsProg  =     $078000    ; And the bank should match the one for
SprTable =     $07f800    ; Guido's sprites.
ErsTable =     $07fC00

SprGuido =     $070000
ErsGuido =     $078000

SprLevel =     $080000
ErsLevel =     $088000

ScrnRef  =     $E12000    ; Temporary location- later, offscreen
Shr      =     $E12000

         TYP   $FF

*------------------------------- Macros

DIR      MAC
         IF    ]1=#
         DS    13
         ADR   ]2
         ELSE
NAME_LG0 STR   ]1
NAME_LG1
         DS    13-NAME_LG1+NAME_LG0
         ADR   ]2
         FIN
         EOM

_Err     MAC
         BCC   *+5
         JSR   Whoopsie
         EOM

*------------------------ End of macros

         DUM   $00        ; Zpage
SingleEn DS    2          ; for Prodos lodaer
PtrLoad  DS    4
PntList  DS    2
PtrLevel DS    4
NbTime   DS    2
         DEND

         DUM   $00        ; Zpage
Msg      DS    2          ; for all other programs
MsH      ds    2
MsV      ds    2
MsAND    DS    2
MsOFF    ds    2
SprMkBnk DS    2
Prog     DS    2
Prog2    DS    2
JmpOff   DS    2
Row      DS    2
Column   DS    2
BlkCol   DS    2
BlkRow   DS    2
Work     DS    2
DCRow    DS    2
DCCol    DS    2
BankSet  DS    2
FlipFlag dS    2
Sps      DS    2
Data     DS    2
BkB      DS    2
Index    ds    2
Pass     ds    2
PixelFix ds    2
         DEND

         ORG   ThisProg
         SEC
         XCE
         SEP   #$30

         JSR   $BF00
         DFB   $C7        ; GetPrefix
         DA    PfxParm-MoveDest+MoveDeb ; Save it for the main prog
         Bcc   *+5
         JSR   Whoopsie-MoveDest+MoveDeb

         LDX   #0
]lp      STZ   $BF58,X
         INX
         CPX   #$17
         BNE   ]lp
         LDA   #1
         STA   $BF6F
         LDA   #$80
         TSB   $C036      ; IIgs to fast speed
]lp      LDA   $C02E
         CMP   #$F0
         BNE   ]lp        ; Wait 'till end of screen refresh
         LDA   #$41
         STA   $C029      ; Standard linear mapped SHR (not on)
         STZ   $C022      ; Screen colors to black on black
         STZ   $C034      ; Border to black
         LDA   #$FF
         STA   $03F3
         EOR   #$A5
         STA   $03F4
         LDA   #$59
         STA   $03F2
         STA   $C000
         STA   $C00C      ; 80Col Off - display 40 columns
         LDY   #$12
         JSR   $FEB4
         CLC
         XCE
         REP   $30
         LDA   #$01FF
         TCS              ; Standard stack
         LDA   #0
         TCD              ; Standard direct page
         STAL  $E115FE
         JSL   $FE0000
         REP   #$30
         LDX   #$0105     ; ToolLocator Reset
         JSL   $E10000
         SEC
         XCE
         JSR   $FB2F      ; "Initialize system"
         JSR   $FE89      ; "Reset input to keyboard"
         JSR   $FE93      ; "Reset I/O to slots"?
         JSR   $FC58      ; "Home cursor and clear screen"
         CLC
         XCE
         REP   $30

         ldx   #$7FFe
         lda   #$0000     ; Blank SHR with zeros
]lp      stal  Shr,x
         dex
         dex
         bpl   ]lp

         LDA   #MoveEnd-MoveDest
         LDX   #MoveDeb    ; Move what follows this segment
         LDY   #MoveDest   ; Up to where it should be
         MVN   MoveDeb,MoveDest
         JMP   MoveDest    ; Run the new routine

MoveDeb  =     *
         ORG   $9000      ; Wire the rest of the code for $9000
MoveDest =     *
ReadBuf  =     *-$2000
ZeroPage =     ReadBuf-$100

         SEC
         XCE
         SEP   $30
         JSR   $BF00
         DFB   $C6        ; [SetPrefix] to where THIS prog is
         DA    PfxParm
         _Err

NewMain  sep   #$30
         lda   #$0
         sta   SingleEn
         jsr   Single     ; Load the load screen
         clc
         xce
         SEP   #$30
         JSR   WaitSync
         LDa   #$C1
         STAl  $e1c029    ; Turn on SHR to show it
         jsr   Single     ; Character set
         jsr   Single     ; TROLLS main prog

         clc
         xce
         rep   #$30
         ldx   #$7FFE
         lda   #$0000
]lp      stal  Shr,x      ; Blank Screen
         dex
         dex
         bpl   ]lp
         ldx   #198
         lda   #$8080
]lp      stal  Shr+$7D00,x ; All 640 Mode
         dex
         dex
         bpl   ]lp
         ldx   #$18
]lp      lda   #$0FFF
         stal  Shr+$7E06,x ; Make Palz
         lda   #$0AAF
         stal  Shr+$7e04,x ;
         lda   #$0A8D
         stal  Shr+$7e02,x ;
         dex
         dex
         dex
         dex
         dex
         dex
         dex
         dex
         bpl   ]lp
         lda   #ZeroPage
         tcd
         jsr   MsgPrint
         HEX   FF00000C                     ; C:H=0,V=12
         HEX   FF020010                     ; C:data offset = $1000
         HEX   FF01FFFF                     ; C:col=3
         HEX   AeAfcacbd8d9c6c7dedfdadbcacb ; "WWeellccoommee"      (14)[14]
         HEX   00a8a9dedf00                 ; " TToo "               (6)[20]
         HEX   FF01AAAA1a1b1c               ; C:col=2 "MMM"          (3)[23]
         HEX   FF01555502030c251213060900   ; C:col=1 "AARRIIOO "    (9)[32]
         HEX   FF01AAAA40411f               ; C:col=2 "TTT"          (3)[35]
         HEX   FF0155550c250609181918192627 ; C:col=1 "RROOLLLLSS"  (10)[45]
         HEX   FF020000                     ; C:data offset = $0000
         HEX   FF00030EFF01FFFF             ; C:H=3,V=14 C:col=3
         HEX   F6EEF1EBE30057755C7c5848     ; "WORLD (1-8):"        (12)[12]
         HEX   FFFF                         ; Command:finish
         sep   #$20
         Jsr   WaitKey
         and   #$7F
         sta   Store1+8   ; Store choice in the blocks,
         sta   Store2+8   ; map,
         sta   Store3+8   ; level data,
         and   #$0F
         sta   PreData
         adc   #$73
         sta   BorkBork+1 ; Print the key
         rep   #$30
         jsr   MsgPrint
BorkBork HEX   0000FF00030F                 ; " " C:H=3,V=F       (2)[2]
         hex   E0F1E4E00057805C995848       ; "Area (A-Z):"
         HEX   FFFF                         ; Command:finish
         sep   #$20
         Jsr   WaitKey
         and   #$7F
         sta   Store2+9   ; Store in the file name
         and   #$1F
         dec
         sta   PreData+1
         clc
         adc   #$a0
         sta   EefEef+1   ; Print key
         rep   #$30
         jsr   MsgPrint
EefEef   HEX   0000       ; "  "  (2)[2]
         HEX   FFFF       ; Command:finish
         rep   #$10
         sep   #$20
         ldx   #$0000     ; Clear Score
         lda   #$00
]lp      sta   PreData+2,x
         inx
         cpx   #$0008
         bne   ]lp
         lda   #$00
         sta   PreData+$A ; Store in the section # to be called
         rep   #$20
         lda   #0
         tcd
         jsr   Single     ; Blocks
         jsr   Single     ; Map
         jsr   Single     ; Special level data

         jsr   Single     ; Level sprites
         clc
         xce
         rep   #$30
         lda   #ZeroPage
         tcd
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
         pea   #>MoveDest
         plb
         plb

         lda   #0
         tcd
         jsr   Single     ; Guido sprites
         clc
         xce
         rep   #$30
         lda   #ZeroPage
         tcd
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
         pea   #>MoveDest
         plb
         plb

         lda   #ZeroPage
         tcd
         sep   #$30
DuckSoup JSR   WaitSync
         LDa   #$41
         STAl  $e1c029
         jsl   TrollsEntry
         rep   #$30
         lda   #ZeroPage
         tcd
         lda   #$0FFF
         stal  $019EEE    ; Attempt for white text
         jsr   MsgPrint
         HEX   FF00000C                     ; C:H=0,V=12
         HEX   FF01FFFF                     ; C:col=3
         HEX   FF020000                     ; C:data offset = $0000
         HEX   E3E6E3E8ED00F875ED48 ; "AGAIN  Y-N:"        (11)[11]
         HEX   FFFF                         ; Command:finish
         sep   #$20
         LDa   #$C1
         STAl  $e1c029
         Jsr   WaitKey
         cmp   #"Y"
         beq   DuckSoup
         cmp   #"y"
         beq   DuckSoup
         jSR   Whoopsie

         LST   ON
* Trolls P8 file loader routine
* Modified from FTA's Bouncin'Ferno P8 Loader
* Garote '93
         LST   OFF

Single   clc
         xce
         rep   #$30
         lda   SingleEn
         and   #$00FF
         asl
         asl
         asl
         asl
         adc   #List
         sta   PntList
         sta   FileName   ; Store the address
         sep   #$31       ; of the record in FileName
         xce              ; To non native mode, for prodos calls

Retry    JSR   $BF00
         DFB   $C8        ; [Open] the file with a prodos call
         DA    OpenParm
         BCC   FndFile

         LDA   (PntList)
         DEC
         TAY
         LDA   (PntList),Y
         INY                 ; If that name is not found,
         CMP   #'.'          ; look and see if the name in the
         BNE   TryComp       ; list has a ".C" suffix.  If it does,
         LDA   (PntList),Y   ; and the file is gone, ErrorTime!
         CMP   #'C'
         BNE   TryComp
         Jsr   Whoopsie   ; What better way to crash? :)

TryComp  INY
         LDA   #'.'
         STA   (PntList),Y  ; add a ".C" suffix to the entry name
         INY                ; (for "compacted") and try again.
         LDA   #'C'
         STA   (PntList),Y
         TYA
         STA   (PntList)
         BRA   Retry

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
         Jsr   Whoopsie

NoErr    LDA   TransCnt
         ORA   TransCnt+1
         BEQ   EndLoad
         CLC
         XCE
         REP   #$30
         LDA   TransCnt
         PHA
         BIT   #1
         BEQ   NoOdd
         INC
NoOdd    DEC
         DEC
         TAY
]lp      LDA   ReadBuf,Y    ; Move up the file data from the buffer,
         STA   [PtrLoad],Y  ; and put it in it's proper place
         DEY
         DEY
         BPL   ]lp
         PLA
         CLC
         ADC   PtrLoad    ; Increment the destination point
         STA   PtrLoad    ; By how much we've already moved
         LDA   PtrLoad+2
         ADC   #0
         STA   PtrLoad+2
         SEC
         XCE
         SEP   $30
         LDA   TransCnt
         BNE   EndLoad
         LDA   TransCnt+1
         CMP   #$20             ; If this last move is complete, and still
         BEQ   Moreload         ; no file end, load more.

EndLoad  JSR   $BF00
         DFB   $CC        ; [Close] the file
         DA    CloseParm
         _Err

         LDA   (PntList)
         DEC
         TAY
         LDA   (PntList),Y
         CMP   #'.'         ; If the file has the ".C" suffix,
         BNE   NoCompact
         INY
         LDA   (PntList),Y
         CMP   #'C'
         BNE   NoCompact

         CLC
         XCE              ; go to native mode,
         REP   $30
         LDY   #13
         LDA   (PntList),Y
         TAX
         INY                ; give the decruncher the address,
         INY
         LDA   (PntList),Y
         AND   #$00FF
         TAY
         JSR   Decrunch   ; and decrunch the file.
         sep   #$31       ; After decrunching, continue...
         XCE

NoCompact inc  SingleEn   ; Auto-increment to next file in list
         rts

Whoopsie sep   #$30
         lda   #$41
         stal  $e1c029
         LDA   #$F0
         STA   $e1c022
         lda   #$00
         stal  $e1c035    ; Attempt to make the
         stal  $e1c054    ; text screen visible
         stal  $e1c051
         pha
         plb
         ldx   WhoopMsg   ; Print error msg
]lp      lda   WhoopMsg,x
         sta   $03FF,x
         dex
         bne   ]lp
         clc
         xce
         rep   #$20
         pla              ; Pull JSR value into A reg

         brk   00
         brk   00         ; CrashTime!

WhoopMsg STR   "Big nasty error- You're SCREWED! :)"

WaitSync PHP
         SEP   $20
]lp      LDAL  $E1C019
         BMI   ]lp
]lp      LDAL  $E1C019
         BPL   ]lp
         PLP
         RTS

WaitKey  PHP
         sep   #$20
         stal  $e1c010
]lp      lda   $e1c000
         bpl   ]lp
         plp
         rts

         MX    %11
RdMouse  LDAL  $E1C027
         BPL   NotAvail
         BIT   #%0000_0010
         BNE   AvailblY
         LDAL  $E1C024
AvailblY LDAL  $E1C024
         AND   #%1000_0000
         EOR   #%1000_0000
NotAvail RTS

PfxParm  HEX   01
         DA    $0300

OpenParm HEX   03
FileName DA    0
         DA    OpenBuf
Ref      DFB   0

ReadParm HEX   04
ReadRef  DFB   0
         DA    ReadBuf
         DA    $2000      ; How much to load
TransCnt DA    0

CloseParm HEX  01
CloseRef DFB   0

ListDA   DA    List
         DS    */$10+1*$10-*     ; Make a gap to the nearest $10 in memory

List     DIR   'PX/TITLE';Shr ; Title page/loading screen
         DIR   'CHARSET';Char ; Chracter set
         DIR   'TROLLS';TrollsEntry ; Main Prog
Store1   DIR   'MAPS/WD11';Blok ; Blocks
Store2   DIR   'MAPS/WD1A';Slots ; Map
Store3   DIR   'MAPS/WD12';DataII ; Special world data
         DIR   'SPR/SPR1';ScrnRaw ; Level sprites
         DIR   'SPR/SPRG';ScrnRaw ; Guido sprites

         DUM   $00        ; Here we have the decompactor
PrtDecom DS    4
PtrCrnch DS    4
Ptr_Len  DS    2          ; Zero page
Ptr_Dist DS    4
Buf_Read DS    1
Buf_Copy DS    1
CrntRnge DS    1
         DEND

         MX    %00
Decrunch PHD
         TSC
         SEC
         SBC   #$18
         TCS
         INC
         TCD
         STX   PrtDecom
         STX   Patch_End
         STY   PrtDecom+2
         SEP   $10
         STY   Patch_End2
         REP   $10
         LDA   #$80
         TSB   $C036
         LDY   #2
         LDA   [PrtDecom]
         CLC
         ADC   PrtDecom
         STA   PtrCrnch
         LDY   #2
         LDA   [PrtDecom],Y
         ADC   PrtDecom+2
         STA   PtrCrnch+2
         LDA   [PtrCrnch]
         STA   [PrtDecom]
         LDA   [PtrCrnch],Y
         STA   [PrtDecom],Y
         INY
         INY
         LDA   [PtrCrnch],Y
         SEP   $20
         STA   Last2Cpy
         XBA
         STA   Range_DC
         REP   $20
         INY
         INY
         LDA   [PtrCrnch],Y
         CLC
         ADC   PrtDecom+1
         STA   PrtDecom+1
         SEP   #$30
         JSR   GoDecomp
         REP   $30
         TSC
         CLC
         ADC   #$18
         TCS
         PLD
         RTS

         MX    %11
GoDecomp STZ   CrntRnge
         STZ   Ptr_Len+1
         LDA   #0
Last2Cpy =     *-1
]lp1     STA   Ptr_Len
prg1     JSR   rout1      ; recopy Ptr_Len bytes from crunch to decompact
]lp2     JSR   rout2      ; read a byte from crunch (includes test for done)
         BNE   more1
         LDA   #$01       ; if the byte is 0, we recopy an
         STA   Ptr_Len+1  ; entire page !!!
         LDA   #$00
         BRA   ]lp1

more1    STA   Buf_Read
         AND   #%00_111111
         STA   Ptr_Dist
         STA   Buf_Copy
         STZ   Ptr_Dist+1
         LDA   Buf_Read   ; if bit 7 is 1, goto more2
         BMI   more2
         ASL   Buf_Read   ; if bit 6 is 1, goto more3
         BMI   more3
         LDA   #$00       ; ig bit 7 is 0 and bit 6 is 0
         STA   Buf_Copy
         LDA   #$02       ; move 2 bytes
prg2     STA   Ptr_Len    ; move from (Ptr_Dist) to (PrtDecom+1)

prg3     =     *
         REP   $20
         CLC              ; where Ptr_Dist = displacement + dest
         LDA   Ptr_Dist
         ADC   PrtDecom
         STA   Ptr_Dist
         LDA   PrtDecom+2
         ADC   #0
         STA   Ptr_Dist+2
         SEP   $20
         JSR   rout3      ; recopy a string from decompact to decompact
         LDA   Buf_Copy
         STA   Ptr_Len
         BEQ   ]lp2       ; if F7=0 : we read another byte
         JMP   prg1

more3    JSR   rout2      ; if bit 6 is 1 and bit 7 is 0, read a byte from
         STA   Ptr_Dist   ; the source, so we jump over 8 bits
         LDA   #$03       ; and move 3 bytes
         JMP   prg2       ; recopy 3 bytes and tell me about it
more2    ASL   Buf_Read   ; (on 6 bits) if bit 7 is 1
         BMI   more4
         LDA   #$04       ; if bit 7 is 1 and bit 6 is 0
         STA   Ptr_Len    ; move 4 bytes
         LDA   Buf_Copy
         CMP   #$3F
         BNE   more5
prg4     JSR   rout2      ; if we jumped >$3F bytes, we read a byte
         STA   Buf_Copy
more5    JSR   rout2      ; read a byte
         STA   Ptr_Dist
         SEC
         LDA   Ptr_Dist
         SBC   CrntRnge
         BEQ   more6
         BCS   more7
more6    LDA   Ptr_Dist   ; relative position from 2 bytes
         STA   Ptr_Dist+1
         JSR   rout2
more7    STA   Ptr_Dist   ; relative position from only one
         JMP   prg3

more4    LDA   Buf_Copy   ; if bit 7 is 1 and bit 6 is 1
         CMP   #$05
         BCS   more8      ; jmp if >=$05
         STA   Ptr_Len+1  ; recopy several pages
         JSR   rout2
more8    STA   Ptr_Len    ; same story as when bit 7=1 and but 6=0
         JMP   prg4

rout3    SEC              ; rout3 recopies a block of memory
         LDA   PrtDecom   ; from (F8) to (FE), of Ptr_Len+1-FA bytes
         SBC   Ptr_Len    ; with decrementing
         STA   PrtDecom   ; move source-buffer to dest
         BCS   more9
         JSR   rout4      ; increment F6 read a value, decrement FF
more9    SEC
         LDA   Ptr_Dist
         SBC   Ptr_Len
         STA   Ptr_Dist
         BCS   more10
         LDA   Ptr_Dist+1
         BNE   No_Dec2
         DEC   Ptr_Dist+2
No_Dec2  DEC   Ptr_Dist+1
more10   LDY   Ptr_Len
more13   TYA
         ORA   Ptr_Len+1
         BNE   more11
         RTS              ; only if FA and FB are 0, Y=0 on exit

more11   TYA
         BNE   more12
         DEC   Ptr_Len+1  ; only if FA is 0
         LDA   Ptr_Dist+1
         BNE   No_Dec5
         DEC   Ptr_Dist+2
No_Dec5  DEC   Ptr_Dist+1
         JSR   rout4
more12   DEY              ; dumb way to copy a byte
         LDA   [Ptr_Dist],Y
         STA   [PrtDecom],Y
         JMP   more13

rout4    LDA   CrntRnge
         CMP   #0         ; added line
Range_DC =     *-1
         BCS   more14
         INC   CrntRnge
more14   =     *
         LDA   PrtDecom+1
         BNE   No_Dec3
         DEC   PrtDecom+2
No_Dec3  DEC   PrtDecom+1
         RTS

rout1    REP   $20
         LDA   PtrCrnch   ; move Ptr_Len+1-Ptr_Len bytes from (PtrCrnch)
         STA   Ptr_Dist   ; vers (PrtDecom+1), decrementing
         LDA   PtrCrnch+1
         STA   Ptr_Dist+1
         SEP   $20
         JSR   rout3
         REP   $20
         LDA   Ptr_Dist
         STA   PtrCrnch
         LDA   Ptr_Dist+1
         STA   PtrCrnch+1
         SEP   $20
         RTS

rout2    LDA   PtrCrnch   ; read a source byte
         BNE   more15
         LDA   PtrCrnch+1
         BNE   No_Dec4
         DEC   PtrCrnch+2
No_Dec4  DEC   PtrCrnch+1
more15   DEC   PtrCrnch   ; on entry : Y=0
         LDA   [PtrCrnch],Y
         PHA
         REP   $20
         LDA   PtrCrnch
         CMP   #0
Patch_End =    *-2
         SEP   $20
         LDA   PtrCrnch+2
         SBC   #0
Patch_End2 =   *-1
         PLA
         BCS   not_end
         PLA
         PLA
not_end  RTS

         LST   ON
* hokey 2x8 byte SHR character generator
* v.03 (c) Garote '93
         LST   OFF

MsgPrint rep   #$30
         pla
         sta   Msg
]lp      lda   (Msg)
         and   #$00ff
         cmp   #$00ff
         bne   CharSk1
         lda   (Msg)
         and   #$FF00
         inc   Msg
         inc   Msg
         cmp   #$FF00
         beq   CharRts
         cmp   #$0000
         beq   CharHV
         cmp   #$0100
         beq   CharAND
         cmp   #$0200
         beq   CharOFF
         bra   ]lp
CharSk1  asl
         asl
         asl
         asl
         adc   MsOFF
         tax
         lda   MsV
         asl
         asl
         clc
         adc   MsV
         XBA              ; Vertical location x5, x$100
         lsr
         clc
         adc   MsH        ; plus the horizontal location,
         asl              ; shifted up and back to make it x2
         tay
         phb
         pea   #>Shr
         plb
         plb
         jsr   CharWrt
         plb
         inc   MsH
         lda   MsH
         cmp   #$0050     ; Width of screen (80 columns)
         bne   Jerky
         stz   MsH
         inc   MsV
         lda   MsV
         cmp   #$0019     ; Length of screen (25 rows)
         bne   Jerky
         stz   MsV
Jerky  inc   Msg
         bra   ]lp

CharRts  lda   Msg
         dec
         pha
         rts

CharHV   lda   (Msg)
         and   #$00FF
         sta   MsH
         inc   Msg
         lda   (Msg)
         and   #$00FF
         sta   MsV
         inc   Msg
         bra   ]lp

CharAND  lda   (Msg)
         sta   MsAND
         inc   Msg
         inc   Msg
         jmp   ]lp

CharOFF  lda   (Msg)
         sta   MsOFF
         inc   Msg
         inc   Msg
         jmp   ]lp

CharWrt  LDal  Char,x     ; Command list:
         and   MsAND      ; (All commands preceded by an $FF)
         sta   Shr,y      ; We're writing to the SUB screen ;)
         LDAl  Char+2,x   ; 00 = set Htab byte, Vtab byte   (2)
         and   MsAND      ; 01 = set AND mask value         (2)
         sta   Shr+$a0,y  ; 02 = set character data offset  (2)
         LDAl  Char+4,x
         and   MsAND
         sta   Shr+$140,y
         ldal  Char+6,x
         and   MsAND
         sta   Shr+$1e0,y
         ldal  Char+8,x
         and   MsAND
         sta   Shr+$280,y
         ldal  Char+10,x
         and   MsAND
         sta   Shr+$320,y
         ldal  Char+12,x
         and   MsAND
         sta   Shr+$3c0,y
         ldal  Char+14,x
         and   MsAND
         sta   Shr+$460,y ; FF = marks end of message       (1)
         rts

         LST   ON
* spritemaker v.10-.2f  ace 1993
* spritemaker v.2f-.3f  Garote '93
* spritemaker v.3f-.45  ace 1993
* spritemaker v.46      Garote '93
         LST   OFF

SpriteMk REP   #$30
         LDA   #$7800     ;make working copy in e1
         LDX   #ScrnRaw
         LDY   #ScrnRef
         MVN   ScrnRaw,ScrnRef ; Sets bank, too!
         LDA   SprMkBnk   ;set by caller
         TAY
         AND   #$00FF
         STA   BankSet    ; bank to set jmp table for
         TYA
         XBA
         AND   #$00FF
         STA   FlipFlag   ;flip the sprites?
         STZ   Prog       ;start of code
         STZ   Prog2      ;start of erasers
         STZ   JmpOff     ;start of jmp tbls
         STZ   Pass       ;start of conversion
Start    LDA   #$0A00     ;16th row
         STA   Row
         LDA   #$000A     ;10th column
         STA   Column
         STZ   BlkCol     ;first block
         STZ   BlkRow     ;first block
NewBlock LDA   Pass
         BNE   Loop       ; Done all passes? No? Do em all!
         LDX   JmpOff
         LDA   Prog
         CLC
         ADC   #SprProg   ; Make a new jump table entry
         STAL  SprTable,X
         LDA   Prog2
         CLC
         ADC   #ErsProg
         STAL  ErsTable,X
         LDA   BankSet
         STAL  ErsTable+2,X
         STAL  SprTable+2,X
         INX
         INX
         INX
         STX   JmpOff
Loop     LDA   #$0A00
         SEC
         SBC   Row
         STA   Work
         LDA   #$00A0
         SBC   Column
         CLC
         ADC   Work
         STA   Work
         LSR
         ADC   Work
         STA   Sps
         LDA   Row        ;row offset
         ADC   Column     ;column offset
         ADC   BlkCol     ;blkcol offset
         ADC   BlkRow     ;blkrow offset
         STA   Index
         TAX
         LDA   $1F5E,X
         BNE   Exists
         JMP   Next
Exists   TAX
         STA   Data
         LDY   #$FFFF
         AND   #$F000
         BEQ   Chk2
         TYA
         AND   #$0FFF
         TAY
Chk2     TXA
         AND   #$0F00
         BEQ   Chk3
         TYA
         AND   #$F0FF
         TAY
Chk3     TXA
         AND   #$00F0
         BEQ   Chk4
         TYA
         AND   #$FF0F
         TAY
Chk4     TXA
         AND   #$000F
         BEQ   ChkD
         TYA
         AND   #$FFF0
         TAY
ChkD     LDX   Pass
         JMP   (PassTbl,X)

PassTbl  DA    Partial,Full,Par2,Full2

]NotYet  JMP   Next

Full     CPY   #$0000
         BNE   ]NotYet
         LDX   Index
         STZ   $1F5E,X
         LDX   Prog
         LDA   #$A9       ;A9 = lda const
         STAL  SprProg,X
         LDA   Data       ;data
         STAL  SprProg+1,X
         LDA   #$9D       ;9D = sta $000000,x
         STAL  SprProg+3,X
         LDA   Sps        ;store to $0000,x
         STAL  SprProg+4,X
         TXA
         CLC
         ADC   #$0006     ;6 bytes of code done
         STA   Prog
         LDX   Prog2
         LDA   #$BF
         STAL  ErsProg,X
         LDA   Sps
         STAL  ErsProg+1,X
         STAL  ErsProg+5,X
         LDA   #$9D06
         STAL  ErsProg+3,X
         TXA
         CLC
         ADC   #$0007
         STA   Prog2
         LDA   Row
         STA   DCRow
         LDA   Column
         STA   DCCol
NextDC   DEC   DCCol
         DEC   DCCol
         BNE   DupChk
         LDA   #$000A
         STA   DCCol
         LDA   DCRow
         SEC
         SBC   #$00A0
         STA   DCRow
         BNE   DupChk
         JMP   Next
DupChk   LDA   DCRow
         CLC
         ADC   DCCol
         ADC   BlkRow
         ADC   BlkCol
         TAX
         LDA   $1F5E,X
         CMP   Data
         BNE   NextDC
         STZ   $1F5E,X
         LDX   Prog
         LDA   #$009D
         STAL  SprProg,X
         LDA   #$0A00
         SEC
         SBC   DCRow
         STA   Work
         LDA   #$00A0
         SEC
         SBC   DCCol
         CLC
         ADC   Work
         STA   Work
         LSR
         ADC   Work
         STA   BkB
         STAL  SprProg+1,X
         TXA
         ADC   #$0003
         STA   Prog
         LDX   Prog2
         LDA   #$00BF
         STAL  ErsProg,X
         LDA   BkB
         STAL  ErsProg+1,X
         STAL  ErsProg+5,X
         LDA   #$9D06
         STAL  ErsProg+3,X
         TXA
         CLC
         ADC   #$0007
         STA   Prog2
         JMP   NextDC

Par2     CPY   #$FF0F
         BEQ   Okay
         CPY   #$FFF0
         BEQ   Okay
         CPY   #$0FFF
         BEQ   Switch
         CPY   #$F0FF
         BEQ   Switch
         JMP   Next
Switch   TYA
         XBA
         TAY
         LDA   Data
         XBA
         STA   Data
         INC   Sps
Okay     LDX   Index
         STZ   $1F5E,X
         LDX   Prog
         LDA   #$00BD     ;BD = lda $0000,x
         STAL  SprProg,X
         LDA   Sps        ;load from location
         STAL  SprProg+1,X
         LDA   #$0029     ;29 = and #$0000
         STAL  SprProg+3,X
         TYA              ;and with mask
         STAL  SprProg+4,X
         LDA   #$0009     ;09 = ora #$0000
         STAL  SprProg+5,X
         LDA   Data       ;ora with data
         STAL  SprProg+6,X
         LDA   #$009D     ;9D = sta $0000,x
         STAL  SprProg+7,X ;store to location
         LDA   Sps
         STAL  SprProg+8,X
         TXA
         CLC
         ADC   #$000A     ;10 bytes of code done
         STA   Prog
         LDX   Prog2
         LDA   #$00BF
         STAL  ErsProg,X
         LDA   Sps
         STAL  ErsProg+1,X
         STAL  ErsProg+5,X
         LDA   #$9D06
         STAL  ErsProg+3,X
         TXA
         CLC
         ADC   #$0007
         STA   Prog2

]NotYet  JMP   Next

Full2    CPY   #$FF00
         BEQ   Okay2
         LDA   Data
         XBA
         STA   Data
         INC   Sps
Okay2    LDX   Index
         STZ   $1F5E,X
         LDX   Prog
         LDA   #$A9       ;A9 = lda const
         STAL  SprProg,X
         LDA   Data       ;data
         STAL  SprProg+1,X
         LDA   #$9D       ;9D = sta $000000,x
         STAL  SprProg+2,X
         LDA   Sps        ;store to $0000,x
         STAL  SprProg+3,X
         TXA
         CLC
         ADC   #$0005     ;5 bytes of code done
         STA   Prog
         LDX   Prog2
         LDA   #$BF
         STAL  ErsProg,X
         LDA   Sps
         STAL  ErsProg+1,X
         STAL  ErsProg+5,X
         LDA   #$9D06
         STAL  ErsProg+3,X
         TXA
         CLC
         ADC   #$0007
         STA   Prog2
         LDA   Row
         STA   DCRow
         LDA   Column
         STA   DCCol
NextDC8  REP   #$30
         LDA   DCCol
         DEC
         CMP   #$0002
         STA   DCCol
         BCS   DupChk8
         LDA   #$000A
         STA   DCCol
         LDA   DCRow
         SEC
         SBC   #$00A0
         STA   DCRow
         BNE   DupChk8
         JMP   Next
DupChk8  STZ   PixelFix
         LDA   DCCol
         BIT   #$0001
         BEQ   GoAhead
         INC   PixelFix
GoAhead  CLC
         ADC   DCRow
         ADC   BlkRow
         ADC   BlkCol
         TAX
         SEP   #$20
         LDA   $1F5E,X
         BEQ   NextDC8
         CMP   Data
         BEQ   Dup8Fnd
         CMP   Data+1
         BNE   NextDC8
Dup8Fnd  STZ   $1F5E,X
         LDX   Prog
         REP   #$30
         LDA   #$009D
         STAL  SprProg,X
         LDA   #$0A00
         SEC
         SBC   DCRow
         STA   Work
         LDA   #$00A0
         SEC
         SBC   DCCol
         CLC
         ADC   PixelFix
         ADC   Work
         STA   Work
         LSR
         ADC   Work
         ADC   PixelFix
         STA   BkB
         STAL  SprProg+1,X
         TXA
         CLC
         ADC   #$0003
         STA   Prog
         LDX   Prog2
         LDA   #$00BF
         STAL  ErsProg,X
         LDA   BkB
         STAL  ErsProg+1,X
         STAL  ErsProg+5,X
         LDA   #$9D06
         STAL  ErsProg+3,X
         TXA
         CLC
         ADC   #$0007
         STA   Prog2
         JMP   NextDC8

]NotYet  JMP   Next

Partial  CPY   #$0000
         BEQ   ]NotYet
         CPY   #$0FFF
         BEQ   ]NotYet
         CPY   #$F0FF
         BEQ   ]NotYet
         CPY   #$FF0F
         BEQ   ]NotYet
         CPY   #$FFF0
         BEQ   ]NotYet
         CPY   #$00FF
         BEQ   ]NotYet
         CPY   #$FF00
         BEQ   ]NotYet
         LDX   Index
         STZ   $1F5E,X
         LDX   Prog
         LDA   #$00BD     ;BD = lda $0000,x
         STAL  SprProg,X
         LDA   Sps        ;load from location
         STAL  SprProg+1,X
         LDA   #$0029     ;29 = and #$0000
         STAL  SprProg+3,X
         TYA              ;and with mask
         STAL  SprProg+4,X
         LDA   #$0009     ;09 = ora #$0000
         STAL  SprProg+6,X
         LDA   Data       ;ora with data
         STAL  SprProg+7,X
         LDA   #$009D     ;9D = sta $0000,x
         STAL  SprProg+9,X ;store to location
         LDA   Sps
         STAL  SprProg+10,X
         TXA
         CLC
         ADC   #$000C     ;12 bytes of code done
         STA   Prog
         LDX   Prog2
         LDA   #$00BF
         STAL  ErsProg,X
         LDA   Sps
         STAL  ErsProg+1,X
         STAL  ErsProg+5,X
         LDA   #$9D06
         STAL  ErsProg+3,X
         TXA
         CLC
         ADC   #$0007
         STA   Prog2

Next     DEC   Column
         DEC   Column
         BNE   SameRow
         LDA   #$000A
         STA   Column     ;reset column
         LDA   Row
         SEC
         SBC   #$00A0     ;next row
         STA   Row
         BEQ   NxtBlk
SameRow  JMP   Loop
NxtBlk   LDA   #$0A00
         STA   Row        ;reset row
         LDA   Pass
         INC
         INC
         CMP   #$0008
         BEQ   Really
         STA   Pass
         CMP   #$0004
         BEQ   AddSep
         JMP   Loop
AddSep   LDX   Prog
         LDA   #$20E2     ;sep #$20
         STAL  SprProg,X
         LDX   Prog2
         STAL  ErsProg,X
         INC   Prog
         INC   Prog
         INC   Prog2
         INC   Prog2
         JMP   Loop
Really   STZ   Pass
         LDX   Prog
         LDA   #$006B     ;$6B = rtl
         STAL  SprProg,X
         LDX   Prog2
         STAL  ErsProg,X
         INC   Prog
         INC   Prog2
         LDA   BlkCol
         CLC
         ADC   #$000A     ;next block
         STA   BlkCol
         CMP   #$50       ;middle of screen
         BNE   SameBRow
         STZ   BlkCol
         LDA   BlkRow
         CLC
         ADC   #$0A00     ;next block row
         CMP   #20480     ;middle of screen
         BEQ   AllDone
         STA   BlkRow
SameBRow JMP   NewBlock

AllDone  LDA   FlipFlag
         BEQ   LetsFlip
         pea   #>MoveDest
         plb
         plb
         rts

LetsFlip STZ   Row
         STZ   Column
Flip     LDA   Column
         CLC
         ADC   Row
         TAX
         LDAL  ScrnRaw,X
         JSR   Fix
         STA   ScrnRef+$8,X
         LDAL  ScrnRaw+$2,X
         JSR   Fix
         STA   ScrnRef+$6,X
         LDAL  ScrnRaw+$4,X
         JSR   Fix
         STA   ScrnRef+$4,X
         LDAL  ScrnRaw+$6,X
         JSR   Fix
         STA   ScrnRef+$2,X
         LDAL  ScrnRaw+$8,X
         JSR   Fix
         STA   ScrnRef,X
         LDA   Row
         CMP   #20480
         BEQ   NxtFBlk
         CLC
         ADC   #$00A0
         STA   Row
         BRA   Flip
NxtFBlk  STZ   Row
         LDA   Column
         clc
         adc   #$000A
         sta   Column
         CMP   #$0050
         BNE   Flip
         INC   FlipFlag
         JMP   Start

Fix      STA   BlkCol
         AND   #$0F0F
         ASL
         ASL
         ASL
         ASL
         STA   BlkRow
         LDA   BlkCol
         AND   #$F0F0
         LSR
         LSR
         LSR
         LSR
         CLC
         ADC   BlkRow
         XBA
         RTS

         DS    \
MoveEnd  =     *
OpenBuf  =     *
