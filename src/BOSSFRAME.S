
BackBlit php
         rep   #$20
         sei
         tsc
         sta   ST
         sep   #$20
         STAl  $e1C005
         STAl  $e1C005
         REP   #$30
         LDA   #$9CFF     ; Where on the screen?
         TCS
         JML   (PB)
