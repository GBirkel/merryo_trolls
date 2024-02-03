         MX    %00
LivesInc rep   #$10       ; Increase lives:
         ldx   #$0078
         sep   #$20
         ldal  WldLives+ShelPage
         inc
         cmp   #$0A
         bcc   Jessica
         lda   #$00        ; If it skips over,
         stal  WldLives+ShelPage  ; save a zero and draw,
         jsr   Emily
         sep   #$20
         ldal  WldLives+ShelPage+1
         inc
         cmp   #$0A
         bcc   Ripley
         lda   #$00        ; If it skips over,
Ripley   stal  WldLives+ShelPage+1 ; save a nine and draw,
         jmp   Emily

Jessica  stal  WldLives+ShelPage

Emily    rep   #$20
         and   #$00FF
         ASLS  5
         adc   #$0610
         tay
         jsr   CharWrt
         dex
         dex
         tya
         sec
         sbc   #$0010
         tay
         jsr   CharWrt
         dex
         dex
         rts
