         LST   ON
*  Merryo Trolls PEA effect tester v0.1a
*       (c) Garote '93
*
         lst   off

BF_SizLine  =     $F0  ; Length of one line on the PEA field
BF_SizCode  =     $00  ; Length of any additional code tacked onto the end of one line

         DUM   $00
Tmp      DS    2
ST       DS    2          ; Stack storage
Lupe     DS    2          ; Minor update loop byte(s)
SizTotal DS    2          ; Total length of PEA field
PEAInitialStackPtr DS    2          ; Initial entry point for stack when blitting
FogDork  DS    2
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

PeaJumpPtr =     $000800    ; Long jump location (Important)
Zpl      =     $001100    ; Zero page location

RawScren =     $012500

ThisProg =     $020000

ForeFld  =     $040000    ; Foreground feild bank
FogTable =     $04FFFF    ; (claims all of 5)

BackFld  =     $060000    ; Background feild bank

         ORG   ThisProg

         SEC
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

         pea   #>ThisProg
         plb
         plb

         lda   #Zpl
         tcd
         ldx   #$00FE
]lp      stz   $00,x      ; Clear the whole damn Zero Page
         dex
         dex
         bpl   ]lp

         lda   #ForeFld
         stal  PeaJumpPtr
         LDA   #^ForeFld
         STAl  PeaJumpPtr+2       ; Set the PEA bank correctly
         lda   #BF_SizLine*$C0 ; x192
         sta   SizTotal
         lda   #$9cff
         sta   PEAInitialStackPtr

         ldx   #$0000
         phb
         pea   #>RawScren
         plb
         plb
         ldy   #$77FE
]lp      lda   #$00F4     ; set up the two PEA feilds
         STAl  ForeFld,x  ; (that is, the foreground one
         STAL  BackFld,x  ;  and the background one.)
         lda   RawScren,y ; According to the raw picture
         STAl  ForeFld+1,x ; supplied at location RawScren
         STAL  BackFld+1,x
         inx
         inx
         inx
         dey
         dey
         bpl   ]lp
         plb

         rep   #$30
         stz   Tmp
]lp2     rep   #$20
         lda   Tmp
         XBA
         tax
         lda   FogTablR-1,x
         sep   #$20
         ldy   #$0000
         ldx   Tmp
]lp      lda   FogTablR,y
         rep   #$20
         stal  FogTable,x
         sep   #$20
         inx
         inx
         iny
         iny
         cpy   #$0100
         bne   ]lp
         stx   Tmp
         cpx   #$0000
         bne   ]lp2

MainPlayLoop JSR   PeaBlit    ; blit dat screen!

         rep   #$30
         phb
         pea   #>ForeFld  ; Go to the right bank
         plb
         plb
         lda   FogDork
         asl
         tax
         ldal  FogTabls,x
         dec
         tax
         sep   #$20
         lda   #$60
         stal  ThisProg,x ; Put RTS in FogTabls
         rep   #$20
         lda   FogDork
         asl
         tax
         ldy   #$0001
         jsr   (FogTabls,x)
         lda   FogDork
         asl
         tax
         ldal  FogTabls,x
         dec
         tax
         sep   #$20
         lda   #$EA       ; replace RTS with NOP
         stal  ThisProg,x ;
         rep   #$20
         lda   FogDork
         dec
         bpl   NoFgWrp3
         lda   #79
NoFgWrp3 sta   FogDork
         plb
         jmp   MainPlayLoop

PeaBlit  php
         rep   #$20
         tsc
         sta   ST         ; Save stack
         sep   #$20
         STAl  $e1C005
         STAl  $e1C005    ; Writes to bank 1
         REP   #$31
         LDa   SizTotal
         adcl  PeaJumpPtr
         tax
         LDA   #PeaCR*$100+$5C ; Return Jump
         STAL  ForeFld,x
         LDA   #>PeaCR
         STAL  ForeFld+2,x
         LDA   PEAInitialStackPtr
         tcs
         sec
         JML   [PeaJumpPtr]

PeaCR    SEP   #$20
         STAl  $e1C004
         STAl  $e1C004    ; Writes back to bank 0
         rep   #$20
         lda   #Zpl
         tcd
         lda   ST
         TCS              ; Recover stack
         plp
         RTS

*
*  Thanx to: Alex, Andy, Brad, Bradley, Brent,
*            Emily, Fred, Jon, Justin, Mike, Peter,
*            Phil, Skot, Tara, Tuna, and Zach
*
*     :)
         lst   off

         lst   on
* This source actually written by a basic program.
* ... So watch your ass.
         lst   off

FogTablR HEX   BBBCB1B5B3BFB9BDB7B8BCBABEBDBDBD
         HEX   CBCCC1C5C3CFC9CDC7C8CCCACECDCDCD
         HEX   1B1C1115131F191D17181C1A1E1D1D1D
         HEX   5B5C5155535F595D57585C5A5E5D5D5D
         HEX   3B3C3135333F393D37383C3A3E3D3D3D
         HEX   FBFCF1F5F3FFF9FDF7F8FCFAFEFDFDFD
         HEX   9B9C9195939F999D97989C9A9E9D9D9D
         HEX   DBDCD1D5D3DFD9DDD7D8DCDADEDDDDDD
         HEX   7B7C7175737F797D77787C7A7E7D7D7D
         HEX   8B8C8185838F898D87888C8A8E8D8D8D
         HEX   CBCCC1C5C3CFC9CDC7C8CCCACECDCDCD
         HEX   ABACA1A5A3AFA9ADA7A8ACAAAEADADAD
         HEX   EBECE1E5E3EFE9EDE7E8ECEAEEEDEDED
         HEX   DBDCD1D5D3DFD9DDD7D8DCDADEDDDDDD
         HEX   DBDCD1D5D3DFD9DDD7D8DCDADEDDDDDD
         HEX   DBDCD1D5D3DFD9DDD7D8DCDADEDDDDDD

         PUT   LIB/WAITKEY

         PUT   LIB/WAITSYN

         PUT   LIB/FOGIMPORT
