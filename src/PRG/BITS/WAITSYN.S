WaitSync PHP
         SEP   #$20
]lp      LDAL  $E1C02E
         cmp   #$ee
         Bne   ]lp
]lp      LDAL  $E1C02E
         cmp   #$ef
         bne   ]lp
         PLP
         RTS
