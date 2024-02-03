         DO    World-2/-1
         lst   on
* World 1 pallete modifier v0.2b
         lst   off
PalUp    rep   #$30
         ldx   Pal        ; Update the palette.
         LDA   Palette2,x ; for the QM blox
         stal  $E19ee0
         inc   Pal
         inc   Pal
         lda   Pal
         cmp   #$0034
         bne   :Br1
         stz   Pal
:Br1     ldx   Pal2
         LDA   Palette+16,x ; for the SMT logo
         phb
         pea   #$0101
         plb
         plb
         sta   $9F22
         LDAl  Palette+14,x
         sta   $9F2A
         sta   $9F3A
         sta   $9F42
         LDAl  Palette+12,x
         sta   $9F32
         sta   $9F4A
         sta   $9F5A
         sta   $9F62
         LDAl  Palette+10,x
         sta   $9F52
         sta   $9F6A
         sta   $9F7A
         sta   $9F82
         LDAl  Palette+8,x
         sta   $9F72
         sta   $9F8A
         sta   $9F9A
         sta   $9FA2
         LDAl  Palette+6,x
         sta   $9F92
         sta   $9FAA
         sta   $9FBA
         sta   $9FC2
         LDAl  Palette+4,x
         sta   $9FB2
         sta   $9FCA
         sta   $9FDA
         sta   $9FE2
         LDAl  Palette+2,x
         sta   $9FD2
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
Palette2 HEX   40042002200230034004500560067007
         HEX   80089009a00ab00bc00cd00de00ef00f
         HEX   e00ed00dc00cb00ba00a900980087007
         DA    $660,$550
         FIN

         DO    World-3/-1
         lst   on
* World 2 pallete modifier v0.2b
         lst   off
PalUp    rep   #$30
         ldx   Pal
         LDA   Palette+6,x ; for the SMT logo
         stal  $019FE2
         LDA   Palette+4,x
         stal  $019FEA
         LDA   Palette+2,x
         stal  $019FF2
         LDA   Palette,x
         stal  $019FFA
         inc   Pal
         inc   Pal
         lda   Pal
         cmp   #90
         bne   :Br1
         stz   Pal
:Br1     RTS
         FIN

         DO    World-4/-1
         lst   on
* World 3 pallete modifier v0.2b
         lst   off
PalUp    rep   #$30
         ldx   Pal
         LDA   Palette+6,x ; for the SMT logo
         stal  $019FE2
         LDA   Palette+4,x
         stal  $019FEA
         LDA   Palette+2,x
         stal  $019FF2
         LDA   Palette,x
         stal  $019FFA
         inc   Pal
         inc   Pal
         lda   Pal
         cmp   #90
         bne   :Br1
         stz   Pal
:Br1     RTS
         FIN

         DO    World-5/-1
         lst   on
* World 4 pallete modifier v0.2b
         lst   off
PalUp    rep   #$30
         ldx   Pal
         LDA   Palette+6,x ; for the SMT logo
         stal  $019FE2
         LDA   Palette+4,x
         stal  $019FEA
         LDA   Palette+2,x
         stal  $019FF2
         LDA   Palette,x
         stal  $019FFA
         inc   Pal
         inc   Pal
         lda   Pal
         cmp   #90
         bne   :Br1
         stz   Pal
:Br1     RTS
         FIN

         DO    World-6/-1
         lst   on
* World 5 pallete modifier v0.1
         lst   off
PalUp    rep   #$30
         ldx   Pal
         LDA   Palette+6,x ; for the SMT logo
         stal  $019FE2
         LDA   Palette+4,x
         stal  $019FEA
         LDA   Palette+2,x
         stal  $019FF2
         LDA   Palette,x
         stal  $019FFA
         inc   Pal
         inc   Pal
         lda   Pal
         cmp   #90
         bne   :Br1
         stz   Pal
:Br1     RTS
         FIN

         DO    World-7/-1
         lst   on
* World 6 pallete modifier v0.1
         lst   off
PalUp    rep   #$30
         ldx   Pal
         LDA   Palette+6,x ; for the SMT logo
         stal  $019FE2
         LDA   Palette+4,x
         stal  $019FEA
         LDA   Palette+2,x
         stal  $019FF2
         LDA   Palette,x
         stal  $019FFA
         inc   Pal
         inc   Pal
         lda   Pal
         cmp   #90
         bne   :Br1
         stz   Pal
:Br1     RTS
         FIN

Palette  DA    $80F,$81E,$82d,$83c,$84b,$85A,$869,$878
         DA    $887,$896,$8a5,$8b4,$8c3,$8d2,$8e1
         DA    $8F0,$8E0,$8d0,$8c0,$8b0,$8A0,$890,$880
         DA    $870,$960,$a50,$b40,$c30,$d20,$e10
         DA    $f00,$E01,$d02,$c03,$b04,$A05,$906,$807
         DA    $808,$809,$80A,$80B,$80C,$80D,$80E
         DA    $80F,$81E,$82d,$83c,$84b,$85A,$869,$878,$887,$896
