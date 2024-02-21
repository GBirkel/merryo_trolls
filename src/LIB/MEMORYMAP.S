* SMT memory map

* Bank 00 -----------------------------------------------------

PeaJumpPtr =     $000800    ; Long jump location (Important)
ShelPage =     $001000    ; Zero page for title/loader mode
Zpl      =     $001100    ; Zero page location for play mode
         DO    BF_HeatWav
AcidPtrn =     $001600    ; Acid land wave patterns
         FIN
Loader   =     $009000

* Bank 01 -----------------------------------------------------

FadeDat  =     $010800
FadeWork =     $010a00
FadeVals =     $010d00
SHR      =     $012500    ; ShrA start of PEA window (standard)
ShrA     =     $012000

* Bank 02 -----------------------------------------------------

ThisProg =     $020000
MapBl    =     $028000    ; Map
MapSpr   =     MapBl+$C00 ; Map sprite list
MapVl    =     MapBl+$1000 ; Map call #'s
Connects =     MapBl+$2800 ; Map door connects
ClmInfo  =     MapBl+$2900 ; Map column flags
GenInfo  =     MapBl+$2A00 ; Map general info- time, name, etc.
LevPal   =     MapBl+$2d00 ; Map initial SCB arrangement and palette
MsgList  =     MapBl+$3000 ; Map message list
Char     =     $02C000    ; Character set
GuidoSpriteJumpTable =     $02E000                   ; Guido sprites jmp table
LevelSpriteJumpTable =     GuidoSpriteJumpTable+$400 ; Other sprites jmp table
GuidoEraserJumpTable =     GuidoSpriteJumpTable+$800 ; Guido sprite eraser jmp table
LevelEraserJumpTable =     GuidoEraserJumpTable+$400 ; Other sprite eraser jmp table
SprI     =     $02F000    ; Sprite data list
DraW     =     $02FC00    ; On-screen to-draw list

* Bank 03 -----------------------------------------------------

         DO    BF_BlkComp
DestBnk  =     $030000
DestTabl =     $030100    ; Destination table
Dest     =     $030B00    ; Destination block set
         ELSE
Blok     =     $030000
         FIN

* Bank 04 -----------------------------------------------------

Slots    =     $040000    ; Storage slots for levels

* Bank 05 -----------------------------------------------------

SprProg  =     $050000    ; These should match the spritemaker
SprGuido =     $050000
ErsProg  =     $058000    ; And the bank should match the one for
ErsGuido =     $058000
SprTable =     $05f800    ; Guido's sprites.
ErsTable =     $05fC00

* Bank 06 -----------------------------------------------------

LevelSprites =     $060000
LevelErasers =     $068000

* Bank 07 -----------------------------------------------------

BackgPeaField  =     $070000    ; Background feild bank

* Bank 08 -----------------------------------------------------

ForegPeaField  =     $080000    ; Foreground field bank
SpriRaw  =     $081000    ; Original sprite pics
         DO    BF_BlkComp
Blox     =     $080000    ; Original block set
Table    =     $08F000    ; Original table of block locations
TrashTbl =     $08f400    ; Table for duplicate checking
         FIN

* Bank 09 -----------------------------------------------------

SFXdata  =     $090000    ;SFX bank

* Bank E1 -----------------------------------------------------

ShrB     =     $E12000
