* spritemaker v.10-.2f  (c) ace 1993
* spritemaker v.2f-.3f  Garote '93
* spritemaker v.3f-.45  ace 1993
         LST   ON
* spritemaker v.46-.48  Garote '93
*
         LST   OFF

         DUM   ]Z0
SprMkBnk DS    2          ;Spritemaker zp
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
FlipIndx ds    2
Sps      DS    2
Data     DS    2
BkB      DS    2
Index    ds    2
Pass     ds    2
PixelFix ds    2
NumDone  ds    2
]Z0      =     *
         DEND

SpriteMk REP   #$30
         PEA   #>SpriRaw
         plb
         plb
         LDA   SprMkBnk   ;set by caller
         TAY
         AND   #$00FF
         STA   BankSet    ; bank to set jmp table for
         STZ   FlipIndx   ; Page index at 0 initially.
         TYA
         XBA
         AND   #$00FF
         BNE   NoFlippr   ; If flipflag is 0, make second page
         jsr   FlipThem   ; mirror of 1st.  If 1, don't.
NoFlippr STZ   Prog       ;start of code
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
Loop     LDA   #$0AA0
         SEC
         SBC   Row
         sec
         SBC   Column
         STA   Work
         LSR
         ADC   Work
         STA   Sps
         LDA   Row        ;row offset
         clc
         ADC   Column     ;column offset
         ADC   BlkCol     ;blkcol offset
         ADC   BlkRow     ;blkrow offset
         adc   FlipIndx   ; Flip index
         STA   Index
         TAX
         LDA   SpriRaw-$A2,X
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
         STZ   SpriRaw-$A2,X
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
         LDA   #^$9D000000+BackFld
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
         LDA   SpriRaw-$A2,X
         CMP   Data
         BNE   NextDC
         STZ   SpriRaw-$A2,X
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
         LDA   #^$9D000000+BackFld
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
         STZ   SpriRaw-$A2,X
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
         LDA   #^$9D000000+BackFld
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
         STZ   SpriRaw-$A2,X
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
         LDA   #^$9D000000+BackFld
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
         LDA   SpriRaw-$A2,X
         BEQ   NextDC8
         CMP   Data
         BEQ   Dup8Fnd
         CMP   Data+1
         BNE   NextDC8
Dup8Fnd  STZ   SpriRaw-$A2,X
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
         LDA   #^$9D000000+BackFld
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
         STZ   SpriRaw-$A2,X
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
         LDA   #^$9D000000+BackFld
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

         ldx   NumDone
         lda   #$00FF     ; Graphic completion meter
         stal  $0178CC,x
         INC   NumDone

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

AllDone  LDA   FlipIndx
         BEQ   NextPage
         pea   #>ThisProg
         plb
         plb
         rts

NextPage lda   #$0050
         sta   FlipIndx
         jmp   Start

FlipThem STZ   Row
         STZ   Column
Flip     LDA   Column
         CLC
         ADC   Row
         TAX
         LDA   SpriRaw,X
         JSR   Fix
         STA   SpriRaw+$58,X
         LDA   SpriRaw+$2,X
         JSR   Fix
         STA   SpriRaw+$56,X
         LDA   SpriRaw+$4,X
         JSR   Fix
         STA   SpriRaw+$54,X
         LDA   SpriRaw+$6,X
         JSR   Fix
         STA   SpriRaw+$52,X
         LDA   SpriRaw+$8,X
         JSR   Fix
         STA   SpriRaw+$50,X
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
         rts

Fix      STA   BlkCol
         AND   #$0F0F
         ASLS  4
         STA   BlkRow
         LDA   BlkCol
         AND   #$F0F0
         LSRS  4
         CLC
         ADC   BlkRow
         XBA
         RTS
