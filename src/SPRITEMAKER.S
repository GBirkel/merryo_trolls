
                          ;sprite maker v.2e
                          ;ace 1992

         ORG   $1000      (K must be E1)

Prog     =     $00
Row      =     $02
Column   =     $04
BlkCol   =     $06
BlkRow   =     $08
Work     =     $0A
DCRow    =     $0C
DCCol    =     $0E
JmpOff   =     $10
Prog2    =     $12
Flipped  =     $14

         CLC
         XCE
         sep   #$20
         lda   #$e1       ; set the bank right.
         pha
         plb
         REP   #$30
         STZ   Flipped    ;first sprite set
         STZ   Prog       ;start of code
         STZ   Prog2      ;start of erasers
         STZ   JmpOff     ;start of jmp tbls
         LDA   #$7800     ;make working copy in e1
         LDY   #$2000
         LDX   #$2000
         MVN   $012000,$E12000
Start    LDA   #$0A00     ;16th row
         STA   Row
         LDA   #$000A     ;10th column
         STA   Column
         STZ   BlkCol     ;first block
         STZ   BlkRow     ;first block
NewBlock LDA   Prog
         LDX   JmpOff
         STAL  $08F000,X
         LDA   #$0008
         STAL  $08F002,X
         LDA   Prog2
         STAL  $09F000,X
         LDA   #$0009
         STAL  $09F002,X
         INX
         INX
         INX
         STX   JmpOff
Loop     LDA   #$0A00
         SEC
         SBC   Row
         STA   Work
         LDA   #$00A0
         SEC
         SBC   Column
         CLC
         ADC   Work
         STA   Work
         LSR
         CLC
         ADC   Work
         STA   Sp+1
         LDA   Row        ;row offset
         CLC
         ADC   Column     ;column offset
         CLC
         ADC   BlkCol     ;blkcol offset
         CLC
         ADC   BlkRow     ;blkrow offset
         TAY
         LDA   $1F5E,Y
         BNE   Auugh
         JMP   Next
Auugh    TAY
         STA   Data+1
         AND   #$F000
         BNE   NBkgr1
         JMP   Bkgr1
NBkgr1   TYA
         AND   #$0F00
         BNE   NBkgr2
         JMP   Bkgr2
NBkgr2   TYA
         AND   #$00F0
         BNE   NBkgr3
         JMP   Bkgr3
NBkgr3   TYA
         AND   #$000F
         BNE   Full
         JMP   Bkgr4d
Full     LDX   Prog
         LDA   #$00A9     ;A9 = lda const
         STAL  $080000,X
Data     LDA   #$0000     ;data
         STAL  $080001,X
         LDA   #$009D     ;9D = sta absolute,x
         STAL  $080003,X
Sp       LDA   #$0000     ;store to 0000,x
         STAL  $080004,X
         TXA
         CLC
         ADC   #$0006     ;6 bytes of code done
         STA   Prog
         LDX   Prog2
         LDA   #$00BF
         STAL  $090000,X
         LDA   Sp+1
         STAL  $090001,X
         LDA   #$9D06
         STAL  $090003,X
         LDA   Sp+1
         STAL  $090005,X
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
         CLC
         ADC   BlkRow
         CLC
         ADC   BlkCol
         TAY
         LDA   $1F5E,Y
         CMP   Data+1
         BNE   NextDC
         TYX
         STZ   $1F5E,X
         LDX   Prog
         LDA   #$009D
         STAL  #$080000,X
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
         CLC
         ADC   Work
         STA   Bk+1
         STAL  #$080001,X
         TXA
         CLC
         ADC   #$0003
         STA   Prog
         LDX   Prog2
         LDA   #$00BF
         STAL  $090000,X
Bk       LDA   #$0000
         STAL  $090001,X
         LDA   #$9D06
         STAL  $090003,X
         LDA   Bk+1
         STAL  $090005,X
         TXA
         CLC
         ADC   #$0007
         STA   Prog2
         JMP   NextDC

Bkgr1    TYA
         AND   #$0F00
         BEQ   Bkgr12

         TYA
         AND   #$00F0
         BEQ   Bkgr13

         TYA
         AND   #$000F
         BEQ   Bkgr14d

Bkgr1d   LDA   #$F000
         STA   Mask+1
         JMP   Dirty

Bkgr12   TYA
         AND   #$00F0
         BEQ   Bkgr123d

         TYA
         AND   #$000F
         BEQ   Bkgr124d

Bkgr12d  LDA   #$FF00
         STA   Mask+1
         JMP   Dirty

Bkgr123d LDA   #$FFF0
         STA   Mask+1
         JMP   Dirty

Bkgr124d LDA   #$FF0F
         STA   Mask+1
         JMP   Dirty

Bkgr13   TYA
         AND   #$000F
         BEQ   Bkgr134d

Bkgr13d  LDA   #$F0F0
         STA   Mask+1
         JMP   Dirty

Bkgr134d LDA   #$F0FF
         STA   Mask+1
         JMP   Dirty

Bkgr14d  LDA   #$F00F
         STA   Mask+1
         JMP   Dirty

Bkgr2    TYA
         AND   #$00F0
         BEQ   Bkgr23

         TYA
         AND   #$000F
         BEQ   Bkgr24d

Bkgr2d   LDA   #$0F00
         STA   Mask+1
         JMP   Dirty

Bkgr23   TYA
         AND   #$000F
         BEQ   Bkgr234d

Bkgr23d  LDA   #$0FF0
         STA   Mask+1
         JMP   Dirty

Bkgr234d LDA   #$0FFF
         STA   Mask+1
         JMP   Dirty

Bkgr24d  LDA   #$0F0F
         STA   Mask+1
         JMP   Dirty

Bkgr3    TYA
         AND   #$000F
         BEQ   Bkgr34d

Bkgr3d   LDA   #$00F0
         STA   Mask+1
         JMP   Dirty

Bkgr34d  LDA   #$00FF
         STA   Mask+1
         JMP   Dirty

Bkgr4d   LDA   #$000F
         STA   Mask+1

Dirty    LDX   Prog
         LDA   #$00BD     ;BD = lda absolute,x
         STAL  $080000,X
         LDA   Sp+1       ;load from 0000,x
         STAL  $080001,X
         LDA   #$0029     ;29 = and const
         STAL  $080003,X
Mask     LDA   #$0000     ;and with mask
         STAL  $080004,X
         LDA   #$0009     ;09 = ora const
         STAL  $080006,X
         LDA   Data+1     ;ora with data
         STAL  $080007,X
         LDA   #$009D     ;9D = sta absolute,x
         STAL  $080009,X  ;store to 0000,x
         LDA   Sp+1       ;9f = sta absolute long,x
         STAL  $08000A,X
         TXA
         CLC
         ADC   #$000C     ;12 bytes of code done
         STA   Prog
         LDX   Prog2
         LDA   #$00BF
         STAL  $090000,X
         LDA   Sp+1
         STAL  $090001,X
         LDA   #$9D06
         STAL  $090003,X
         LDA   Sp+1
         STAL  $090005,X
         TXA
         CLC
         ADC   #$0007
         STA   Prog2

Next     DEC   Column
         DEC   Column
         BEQ   NxtRow
         JMP   Loop
NxtRow   LDA   #$000A
         STA   Column     ;reset column
         LDA   Row
         SEC
         SBC   #$00A0     ;next row
         STA   Row
         BEQ   NxtBlk
         JMP   Loop
NxtBlk   LDX   Prog
         LDA   #$006B
         STAL  #$080000,X
         LDX   Prog2
         STAL  #$090000,X
         INC   Prog
         INC   Prog2
         LDA   #$0A00
         STA   Row        ;reset row
         LDA   BlkCol
         CLC
         ADC   #$000A     ;next block
         STA   BlkCol
         CMP   #$50       ;middle of screen
         BEQ   NxtBlkR
         JMP   NewBlock
NxtBlkR  STZ   BlkCol
         LDA   BlkRow
         CLC
         ADC   #$0A00     ;next block row
         CMP   #20480     ;middle of screen
         BEQ   AllDone
         STA   BlkRow
         JMP   NewBlock

AllDone  LDA   Flipped
         BEQ   LetsDoIt
         JMP   Finished

LetsDoIt LDA   #$7800     ;restore working copy
         LDX   #$2000
         LDY   #$2000
         MVN   $012000,$E12000
         STZ   Row
         STZ   Column
Flip     LDA   Column
         CLC
         ADC   Row
         TAX
         LDA   $2000,X
         STA   Work
         LDA   $2002,X
         STA   Prog
         LDA   $2004,X
         JSR   Fix
         STA   $2004,X
         LDA   $2006,X
         JSR   Fix
         STA   $2002,X
         LDA   $2008,X
         JSR   Fix
         STA   $2000,X
         LDA   Prog
         JSR   Fix
         STA   $2006,X
         LDA   Work
         JSR   Fix
         STA   $2008,X
         LDA   Row
         CMP   #20480
         BEQ   NxtFBlk
         CLC
         ADC   #$00A0
         STA   Row
         BRA   Flip
NxtFBlk  STZ   Row
         LDA   Column
         CMP   #$96
         BEQ   OnceMore
         CLC
         ADC   #$000A
         STA   Column
         BRA   Flip

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

OnceMore INC   Flipped
         LDA   #$8000
         STA   Prog
         STA   Prog2
         LDA   #$0100
         STA   JmpOff
         JMP   Start

Finished SEP   #$30
         LDA   #$00
         PHA
         PLB
         SEC
         XCE
         RTL
