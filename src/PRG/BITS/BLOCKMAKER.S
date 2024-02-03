         lst   on
* Block encoder v0.4, (c) Garote '93
*
         lst   off

         DUM   ]Z0
Crnt     DS    2          ;Blockmaker zp
CrntT    DS    2          ; Value in table representing block
Sect     DS    2          ; Current section being converted (0-4)
Wrd      DS    2          ; Current vertical word being converted
CrntComp DS    2          ; Value of current vertical word being converted
WrdDup   DS    2          ; Current vertical word being checked for duplicate
LocDup   DS    2          ; Current blox location being checked for dup
DupTbl   DS    17         ; Table of flags for duplicate checking
Indx     DS    2          ; Index into destination code
LastIndx DS    2          ; Beginning of current section in dest code
IndxT    DS    2          ; Current entry being compared for dupliacte
TrashTL  DS    2          ; Number of entries in comparison table
IndxLn   DS    2          ; Current length to check
PEALen   DS    2          ; Length of one SCB of data in the PEA field
PEAWhole DS    2          ; Endpoint of a whole 20x16 block in PEA field
StorDmmy DS    2          ; Current store variable being processed
]Z0      =     *
         DEND

BlokMakr rep   #$30
         lda   #Dest
         sta   Indx
         stz   Crnt
         stz   TrashTL
         lda   #$00F0
         sta   PEALen
         asl
         asl
         asl
         asl              ; PEALen x0F
         sec
         sbc   PEALen
         inc
         sta   PEAWhole

NextBlok lda   Crnt       ; New block
         asl
         tax
         ldal  Table,x
         sta   CrntT
         stz   Sect

NextSect lda   Sect-1      ; New section
         and   #$FF00
         clc
         adc   Crnt
         asl
         tax
         lda   Indx
         stal  DestTabl,x
         sta   LastIndx   ; Update last index to here
         ldx   #$000F
]lp      stz   DupTbl,x   ; Reset duplicate checking row
         dex
         bpl   ]lp
         stz   Wrd

NextWord ldx   Wrd
         lda   DupTbl,x
         and   #$000F
         beq   YupYup
         jmp   IncWord
YupYup   txa
         asl
         asl
         adc   Wrd        ; Wrd x5
         adc   Sect       ; Wrd x5 + Sect
         asl              ; Wrd xA + Sect x2
         adc   CrntT
         sta   LocDup     ; Save for duplicate checker
         tax
         ldal  Blox,x
         sta   LoadDmmy+1
         sta   CrntComp
         lda   #$0000
         ldx   Wrd
         beq   DoneClc
]lp      clc
         adc   PEALen
         dex
         bne   ]lp
DoneClc  sta   TmpB       ; Wrd x PEALen
         lda   PEAWhole
         sec
         sbc   TmpB
         sta   StorDmmy   ; PEAWhole - ((Wrd x PEALen) + (Sect x 3))
         ldx   Indx
         lda   #$00A9     ; LDA #$xx00
         stal  DestBnk,x  ; Move in the completed action
LoadDmmy lda   #$0000
         stal  DestBnk+1,x
         lda   #$0099
         stal  DestBnk+3,x
         lda   StorDmmy
         stal  DestBnk+4,x
         txa
         clc
         adc   #$0006
         sta   Indx
         lda   Wrd
         sta   WrdDup
         jmp   IncDup     ; Auto-inc to next position

NextDup  ldx   LocDup
         ldal  Blox,x
         cmp   CrntComp
         bne   IncDup
         ldx   WrdDup
         inc   DupTbl,x   ; Flag that this is a duplicate
         ldx   Indx
         lda   #$0099     ; STA $xx00,y
         stal  DestBnk,x  ; Move in the added action
         lda   StorDmmy
         stal  DestBnk+1,x
         txa
         clc
         adc   #$0003
         sta   Indx

IncDup   lda   StorDmmy
         sec
         sbc   PEALen
         sta   StorDmmy
         lda   LocDup
         clc
         adc   #$000A
         sta   LocDup
         inc   WrdDup
         lda   WrdDup
         cmp   #$0010
         beq   IncWord
         jmp   NextDup

IncWord  inc   Wrd
         lda   Wrd
         cmp   #$0010
         beq   GoDupChk
         jmp   NextWord

GoDupChk ldx   Indx
         lda   #$0060     ; RTS
         stal  DestBnk,x  ; Append it
         inc   Indx

DupBChk  lda   Crnt       ; If this is the first, forget it!
         bne   DupBChk2
         lda   Sect
         beq   IncTL
DupBChk2 lda   Indx
         sec
         sbc   LastIndx
         dec
         dec
         sta   IndxLn
         lda   LastIndx
         sta   DupMod+1
         stz   IndxT
DupNext  lda   IndxT
         asl
         tax
         ldal  TrashTbl,x
         sta   DupMod2+1
         ldx   #$0000
DupMod   ldal  Dest,x
DupMod2  cmpl  Dest,x
         bne   DupInc
         inx
         inx
         cpx   IndxLn
         bcc   DupMod
         lda   LastIndx   ; If duplicate is found:
         sta   Indx       ; Move back index
         lda   Sect-1     ; Redirect jump table
         and   #$FF00
         clc
         adc   Crnt
         asl
         tax
         lda   DupMod2+1
         stal  DestTabl,x
         bra   IncSect

DupInc   inc   IndxT
         lda   IndxT
         cmp   TrashTL
         beq   IncTL
         jmp   DupNext

IncTL    lda   TrashTL
         inc   TrashTL
         asl
         tax
         lda   LastIndx   ; Make a new entry for the dupchek list
         stal  TrashTbl,x

IncSect  inc   Sect       ; Go to the next block portion to be processed
         lda   Sect
         cmp   #$0005
         beq   IncBlok
         jmp   NextSect

IncBlok  lda   Crnt
         lsr
         tax
         ldal  $017A0c,x
         lsr
         lsr
         lsr
         lsr
         ora   #$00F0
         stal  $017A0c,x
         inc   Crnt
         lda   Crnt
         cmp   #$0100
         beq   DoneIt
         jmp   NextBlok

DoneIt   ldx   #$0000
]lp      lda   CallDmmy,x
         stal  DestBnk,x
         inx
         inx
         cpx   #CallDEnd-CallDmmy+1
         bcc   ]lp
         rts

CallDmmy MX    %00
         asl
         tax
         phb
         pea   #^ForeFld*$100+BackFld
         plb
         jsr   (DestTabl,x)
         plb
         jsr   (DestTabl,x)
         plb
CallDEnd rtl
