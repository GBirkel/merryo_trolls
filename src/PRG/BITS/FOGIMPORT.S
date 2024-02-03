* This source actually written by a basic program.
* ... So watch your ass.

FogTabls DA    FogT0,FogT1,FogT2,FogT3,FogT4,FogT5,FogT6,FogT7
         DA    FogT8,FogT9,FogT10,FogT11,FogT12,FogT13,FogT14,FogT15
         DA    FogT16,FogT17,FogT18,FogT19,FogT20,FogT21,FogT22,FogT23
         DA    FogT24,FogT25,FogT26,FogT27,FogT28,FogT29,FogT30,FogT31
         DA    FogT32,FogT33,FogT34,FogT35,FogT36,FogT37,FogT38,FogT39
         DA    FogT40,FogT41,FogT42,FogT43,FogT44,FogT45,FogT46,FogT47
         DA    FogT48,FogT49,FogT50,FogT51,FogT52,FogT53,FogT54,FogT55
         DA    FogT56,FogT57,FogT58,FogT59,FogT60,FogT61,FogT62,FogT63
         DA    FogT64,FogT65,FogT66,FogT67,FogT68,FogT69,FogT70,FogT71
         DA    FogT72,FogT73,FogT74,FogT75,FogT76,FogT77,FogT78,FogT79

BackLoop iny
         iny
         iny
         nop

FogT0    ldx   ForeFld+36720,y
         lda   FogTable,x
         sta   ForeFld+36720,y
         ldx   ForeFld+24000,y
         lda   FogTable,x
         sta   ForeFld+24000,y
         ldx   ForeFld+16800,y
         lda   FogTable,x
         sta   ForeFld+16800,y
         ldx   ForeFld+14160,y
         lda   FogTable,x
         sta   ForeFld+14160,y
         ldx   ForeFld+7440,y
         lda   FogTable,x
         sta   ForeFld+7440,y
         tyx
         ldal  BackFld+40560,x
         sta   ForeFld+40560,x
         ldal  BackFld+3840,x
         sta   ForeFld+3840,x
         ldal  BackFld+3600,x
         sta   ForeFld+3600,x
         iny
         iny
         iny
         nop

FogT1    ldx   ForeFld+43200,y
         lda   FogTable,x
         sta   ForeFld+43200,y
         ldx   ForeFld+42960,y
         lda   FogTable,x
         sta   ForeFld+42960,y
         ldx   ForeFld+36480,y
         lda   FogTable,x
         sta   ForeFld+36480,y
         ldx   ForeFld+32160,y
         lda   FogTable,x
         sta   ForeFld+32160,y
         ldx   ForeFld+31680,y
         lda   FogTable,x
         sta   ForeFld+31680,y
         ldx   ForeFld+17040,y
         lda   FogTable,x
         sta   ForeFld+17040,y
         ldx   ForeFld+13920,y
         lda   FogTable,x
         sta   ForeFld+13920,y
         ldx   ForeFld+13680,y
         lda   FogTable,x
         sta   ForeFld+13680,y
         tyx
         ldal  BackFld+40800,x
         sta   ForeFld+40800,x
         ldal  BackFld+28560,x
         sta   ForeFld+28560,x
         ldal  BackFld+4320,x
         sta   ForeFld+4320,x
         ldal  BackFld+4080,x
         sta   ForeFld+4080,x
         iny
         iny
         iny
         nop

FogT2    ldx   ForeFld+43440,y
         lda   FogTable,x
         sta   ForeFld+43440,y
         ldx   ForeFld+40320,y
         lda   FogTable,x
         sta   ForeFld+40320,y
         ldx   ForeFld+32400,y
         lda   FogTable,x
         sta   ForeFld+32400,y
         ldx   ForeFld+31440,y
         lda   FogTable,x
         sta   ForeFld+31440,y
         ldx   ForeFld+13440,y
         lda   FogTable,x
         sta   ForeFld+13440,y
         ldx   ForeFld+7680,y
         lda   FogTable,x
         sta   ForeFld+7680,y
         ldx   ForeFld+3600,y
         lda   FogTable,x
         sta   ForeFld+3600,y
         tyx
         ldal  BackFld+41040,x
         sta   ForeFld+41040,x
         ldal  BackFld+4560,x
         sta   ForeFld+4560,x
         iny
         iny
         iny
         nop

FogT3    ldx   ForeFld+43920,y
         lda   FogTable,x
         sta   ForeFld+43920,y
         ldx   ForeFld+43680,y
         lda   FogTable,x
         sta   ForeFld+43680,y
         ldx   ForeFld+32640,y
         lda   FogTable,x
         sta   ForeFld+32640,y
         ldx   ForeFld+31200,y
         lda   FogTable,x
         sta   ForeFld+31200,y
         ldx   ForeFld+17280,y
         lda   FogTable,x
         sta   ForeFld+17280,y
         ldx   ForeFld+13200,y
         lda   FogTable,x
         sta   ForeFld+13200,y
         tyx
         ldal  BackFld+41280,x
         sta   ForeFld+41280,x
         ldal  BackFld+28320,x
         sta   ForeFld+28320,x
         ldal  BackFld+5040,x
         sta   ForeFld+5040,x
         ldal  BackFld+4800,x
         sta   ForeFld+4800,x
         iny
         iny
         iny
         nop

FogT4    ldx   ForeFld+44160,y
         lda   FogTable,x
         sta   ForeFld+44160,y
         ldx   ForeFld+36240,y
         lda   FogTable,x
         sta   ForeFld+36240,y
         ldx   ForeFld+30960,y
         lda   FogTable,x
         sta   ForeFld+30960,y
         ldx   ForeFld+17520,y
         lda   FogTable,x
         sta   ForeFld+17520,y
         ldx   ForeFld+7920,y
         lda   FogTable,x
         sta   ForeFld+7920,y
         ldx   ForeFld+3840,y
         lda   FogTable,x
         sta   ForeFld+3840,y
         tyx
         iny
         iny
         iny
         nop

FogT5    ldx   ForeFld+44400,y
         lda   FogTable,x
         sta   ForeFld+44400,y
         ldx   ForeFld+40560,y
         lda   FogTable,x
         sta   ForeFld+40560,y
         ldx   ForeFld+30720,y
         lda   FogTable,x
         sta   ForeFld+30720,y
         ldx   ForeFld+17760,y
         lda   FogTable,x
         sta   ForeFld+17760,y
         tyx
         ldal  BackFld+41520,x
         sta   ForeFld+41520,x
         ldal  BackFld+5520,x
         sta   ForeFld+5520,x
         ldal  BackFld+5280,x
         sta   ForeFld+5280,x
         iny
         iny
         iny
         nop

FogT6    ldx   ForeFld+44880,y
         lda   FogTable,x
         sta   ForeFld+44880,y
         ldx   ForeFld+44640,y
         lda   FogTable,x
         sta   ForeFld+44640,y
         ldx   ForeFld+32880,y
         lda   FogTable,x
         sta   ForeFld+32880,y
         ldx   ForeFld+30480,y
         lda   FogTable,x
         sta   ForeFld+30480,y
         ldx   ForeFld+18000,y
         lda   FogTable,x
         sta   ForeFld+18000,y
         ldx   ForeFld+4080,y
         lda   FogTable,x
         sta   ForeFld+4080,y
         tyx
         ldal  BackFld+41760,x
         sta   ForeFld+41760,x
         ldal  BackFld+5760,x
         sta   ForeFld+5760,x
         iny
         iny
         iny
         nop

FogT7    ldx   ForeFld+45120,y
         lda   FogTable,x
         sta   ForeFld+45120,y
         ldx   ForeFld+8160,y
         lda   FogTable,x
         sta   ForeFld+8160,y
         ldx   ForeFld+4320,y
         lda   FogTable,x
         sta   ForeFld+4320,y
         tyx
         ldal  BackFld+6000,x
         sta   ForeFld+6000,x
         iny
         iny
         iny
         nop

FogT8    ldx   ForeFld+45360,y
         lda   FogTable,x
         sta   ForeFld+45360,y
         ldx   ForeFld+4560,y
         lda   FogTable,x
         sta   ForeFld+4560,y
         tyx
         ldal  BackFld+42000,x
         sta   ForeFld+42000,x
         ldal  BackFld+24000,x
         sta   ForeFld+24000,x
         ldal  BackFld+6240,x
         sta   ForeFld+6240,x
         ldal  BackFld+240,x
         sta   ForeFld+240,x
         iny
         iny
         iny
         nop

FogT9    ldx   ForeFld+45600,y
         lda   FogTable,x
         sta   ForeFld+45600,y
         ldx   ForeFld+40800,y
         lda   FogTable,x
         sta   ForeFld+40800,y
         ldx   ForeFld+30240,y
         lda   FogTable,x
         sta   ForeFld+30240,y
         ldx   ForeFld+28320,y
         lda   FogTable,x
         sta   ForeFld+28320,y
         tyx
         ldal  BackFld+18000,x
         sta   ForeFld+18000,x
         ldal  BackFld+8160,x
         sta   ForeFld+8160,x
         ldal  BackFld+6480,x
         sta   ForeFld+6480,x
         iny
         iny
         iny
         nop

FogT10   ldx   ForeFld+45840,y
         lda   FogTable,x
         sta   ForeFld+45840,y
         ldx   ForeFld+4800,y
         lda   FogTable,x
         sta   ForeFld+4800,y
         tyx
         ldal  BackFld+42240,x
         sta   ForeFld+42240,x
         ldal  BackFld+6720,x
         sta   ForeFld+6720,x
         iny
         iny
         iny
         nop

FogT11   ldx   ForeFld+33120,y
         lda   FogTable,x
         sta   ForeFld+33120,y
         ldx   ForeFld+30000,y
         lda   FogTable,x
         sta   ForeFld+30000,y
         ldx   ForeFld+28560,y
         lda   FogTable,x
         sta   ForeFld+28560,y
         ldx   ForeFld+12960,y
         lda   FogTable,x
         sta   ForeFld+12960,y
         ldx   ForeFld+5040,y
         lda   FogTable,x
         sta   ForeFld+5040,y
         tyx
         ldal  BackFld+7920,x
         sta   ForeFld+7920,x
         ldal  BackFld+6960,x
         sta   ForeFld+6960,x
         iny
         iny
         iny
         nop

FogT12   ldx   ForeFld+46080,y
         lda   FogTable,x
         sta   ForeFld+46080,y
         ldx   ForeFld+28800,y
         lda   FogTable,x
         sta   ForeFld+28800,y
         tyx
         ldal  BackFld+36240,x
         sta   ForeFld+36240,x
         ldal  BackFld+7680,x
         sta   ForeFld+7680,x
         ldal  BackFld+7440,x
         sta   ForeFld+7440,x
         ldal  BackFld+480,x
         sta   ForeFld+480,x
         iny
         iny
         iny
         nop

FogT13   ldx   ForeFld+29760,y
         lda   FogTable,x
         sta   ForeFld+29760,y
         ldx   ForeFld+29040,y
         lda   FogTable,x
         sta   ForeFld+29040,y
         ldx   ForeFld+5280,y
         lda   FogTable,x
         sta   ForeFld+5280,y
         tyx
         ldal  BackFld+24240,x
         sta   ForeFld+24240,x
         ldal  BackFld+7200,x
         sta   ForeFld+7200,x
         iny
         iny
         iny
         nop

FogT14   ldx   ForeFld+29280,y
         lda   FogTable,x
         sta   ForeFld+29280,y
         ldx   ForeFld+12720,y
         lda   FogTable,x
         sta   ForeFld+12720,y
         tyx
         ldal  BackFld+42480,x
         sta   ForeFld+42480,x
         ldal  BackFld+24480,x
         sta   ForeFld+24480,x
         ldal  BackFld+720,x
         sta   ForeFld+720,x
         iny
         iny
         iny
         nop

FogT15   ldx   ForeFld+12480,y
         lda   FogTable,x
         sta   ForeFld+12480,y
         tyx
         ldal  BackFld+40800,x
         sta   ForeFld+40800,x
         ldal  BackFld+36480,x
         sta   ForeFld+36480,x
         iny
         iny
         iny
         nop

FogT16   ldx   ForeFld+33360,y
         lda   FogTable,x
         sta   ForeFld+33360,y
         ldx   ForeFld+29520,y
         lda   FogTable,x
         sta   ForeFld+29520,y
         ldx   ForeFld+20640,y
         lda   FogTable,x
         sta   ForeFld+20640,y
         tyx
         ldal  BackFld+24720,x
         sta   ForeFld+24720,x
         ldal  BackFld+960,x
         sta   ForeFld+960,x
         iny
         iny
         iny
         nop

FogT17   ldx   ForeFld+20880,y
         lda   FogTable,x
         sta   ForeFld+20880,y
         ldx   ForeFld+20400,y
         lda   FogTable,x
         sta   ForeFld+20400,y
         ldx   ForeFld+18000,y
         lda   FogTable,x
         sta   ForeFld+18000,y
         ldx   ForeFld+12240,y
         lda   FogTable,x
         sta   ForeFld+12240,y
         tyx
         ldal  BackFld+36720,x
         sta   ForeFld+36720,x
         ldal  BackFld+24960,x
         sta   ForeFld+24960,x
         ldal  BackFld+1200,x
         sta   ForeFld+1200,x
         iny
         iny
         iny
         nop

FogT18   ldx   ForeFld+21120,y
         lda   FogTable,x
         sta   ForeFld+21120,y
         tyx
         ldal  BackFld+40560,x
         sta   ForeFld+40560,x
         ldal  BackFld+36960,x
         sta   ForeFld+36960,x
         ldal  BackFld+25200,x
         sta   ForeFld+25200,x
         ldal  BackFld+1440,x
         sta   ForeFld+1440,x
         iny
         iny
         iny
         nop

FogT19   ldx   ForeFld+21600,y
         lda   FogTable,x
         sta   ForeFld+21600,y
         ldx   ForeFld+21360,y
         lda   FogTable,x
         sta   ForeFld+21360,y
         ldx   ForeFld+20160,y
         lda   FogTable,x
         sta   ForeFld+20160,y
         ldx   ForeFld+12000,y
         lda   FogTable,x
         sta   ForeFld+12000,y
         tyx
         ldal  BackFld+37200,x
         sta   ForeFld+37200,x
         ldal  BackFld+25440,x
         sta   ForeFld+25440,x
         ldal  BackFld+1680,x
         sta   ForeFld+1680,x
         iny
         iny
         iny
         nop

FogT20   ldx   ForeFld+42480,y
         lda   FogTable,x
         sta   ForeFld+42480,y
         ldx   ForeFld+33600,y
         lda   FogTable,x
         sta   ForeFld+33600,y
         ldx   ForeFld+22080,y
         lda   FogTable,x
         sta   ForeFld+22080,y
         ldx   ForeFld+21840,y
         lda   FogTable,x
         sta   ForeFld+21840,y
         tyx
         ldal  BackFld+40320,x
         sta   ForeFld+40320,x
         ldal  BackFld+37440,x
         sta   ForeFld+37440,x
         ldal  BackFld+29040,x
         sta   ForeFld+29040,x
         ldal  BackFld+25680,x
         sta   ForeFld+25680,x
         ldal  BackFld+5280,x
         sta   ForeFld+5280,x
         iny
         iny
         iny
         nop

FogT21   ldx   ForeFld+22320,y
         lda   FogTable,x
         sta   ForeFld+22320,y
         ldx   ForeFld+19920,y
         lda   FogTable,x
         sta   ForeFld+19920,y
         ldx   ForeFld+18240,y
         lda   FogTable,x
         sta   ForeFld+18240,y
         tyx
         ldal  BackFld+40080,x
         sta   ForeFld+40080,x
         ldal  BackFld+37920,x
         sta   ForeFld+37920,x
         ldal  BackFld+37680,x
         sta   ForeFld+37680,x
         ldal  BackFld+29280,x
         sta   ForeFld+29280,x
         ldal  BackFld+25920,x
         sta   ForeFld+25920,x
         ldal  BackFld+1920,x
         sta   ForeFld+1920,x
         iny
         iny
         iny
         nop

FogT22   ldx   ForeFld+22560,y
         lda   FogTable,x
         sta   ForeFld+22560,y
         ldx   ForeFld+18480,y
         lda   FogTable,x
         sta   ForeFld+18480,y
         ldx   ForeFld+240,y
         lda   FogTable,x
         sta   ForeFld+240,y
         tyx
         ldal  BackFld+39840,x
         sta   ForeFld+39840,x
         ldal  BackFld+38160,x
         sta   ForeFld+38160,x
         ldal  BackFld+29520,x
         sta   ForeFld+29520,x
         ldal  BackFld+26160,x
         sta   ForeFld+26160,x
         ldal  BackFld+5040,x
         sta   ForeFld+5040,x
         iny
         iny
         iny
         nop

FogT23   ldx   ForeFld+29040,y
         lda   FogTable,x
         sta   ForeFld+29040,y
         ldx   ForeFld+22800,y
         lda   FogTable,x
         sta   ForeFld+22800,y
         ldx   ForeFld+18720,y
         lda   FogTable,x
         sta   ForeFld+18720,y
         ldx   ForeFld+9360,y
         lda   FogTable,x
         sta   ForeFld+9360,y
         tyx
         ldal  BackFld+39600,x
         sta   ForeFld+39600,x
         ldal  BackFld+38400,x
         sta   ForeFld+38400,x
         ldal  BackFld+29760,x
         sta   ForeFld+29760,x
         ldal  BackFld+26640,x
         sta   ForeFld+26640,x
         ldal  BackFld+26400,x
         sta   ForeFld+26400,x
         ldal  BackFld+12000,x
         sta   ForeFld+12000,x
         ldal  BackFld+2400,x
         sta   ForeFld+2400,x
         ldal  BackFld+2160,x
         sta   ForeFld+2160,x
         iny
         iny
         iny
         nop

FogT24   ldx   ForeFld+19200,y
         lda   FogTable,x
         sta   ForeFld+19200,y
         ldx   ForeFld+18960,y
         lda   FogTable,x
         sta   ForeFld+18960,y
         ldx   ForeFld+9840,y
         lda   FogTable,x
         sta   ForeFld+9840,y
         ldx   ForeFld+9600,y
         lda   FogTable,x
         sta   ForeFld+9600,y
         ldx   ForeFld+9120,y
         lda   FogTable,x
         sta   ForeFld+9120,y
         ldx   ForeFld+480,y
         lda   FogTable,x
         sta   ForeFld+480,y
         tyx
         ldal  BackFld+39360,x
         sta   ForeFld+39360,x
         ldal  BackFld+38880,x
         sta   ForeFld+38880,x
         ldal  BackFld+38640,x
         sta   ForeFld+38640,x
         ldal  BackFld+30000,x
         sta   ForeFld+30000,x
         ldal  BackFld+26880,x
         sta   ForeFld+26880,x
         ldal  BackFld+2880,x
         sta   ForeFld+2880,x
         ldal  BackFld+2640,x
         sta   ForeFld+2640,x
         iny
         iny
         iny
         nop

FogT25   ldx   ForeFld+23040,y
         lda   FogTable,x
         sta   ForeFld+23040,y
         ldx   ForeFld+19680,y
         lda   FogTable,x
         sta   ForeFld+19680,y
         ldx   ForeFld+19440,y
         lda   FogTable,x
         sta   ForeFld+19440,y
         ldx   ForeFld+10080,y
         lda   FogTable,x
         sta   ForeFld+10080,y
         ldx   ForeFld+8880,y
         lda   FogTable,x
         sta   ForeFld+8880,y
         tyx
         ldal  BackFld+27360,x
         sta   ForeFld+27360,x
         ldal  BackFld+27120,x
         sta   ForeFld+27120,x
         ldal  BackFld+12240,x
         sta   ForeFld+12240,x
         ldal  BackFld+4800,x
         sta   ForeFld+4800,x
         ldal  BackFld+3120,x
         sta   ForeFld+3120,x
         iny
         iny
         iny
         nop

FogT26   ldx   ForeFld+42240,y
         lda   FogTable,x
         sta   ForeFld+42240,y
         ldx   ForeFld+42000,y
         lda   FogTable,x
         sta   ForeFld+42000,y
         ldx   ForeFld+33840,y
         lda   FogTable,x
         sta   ForeFld+33840,y
         ldx   ForeFld+10320,y
         lda   FogTable,x
         sta   ForeFld+10320,y
         ldx   ForeFld+8640,y
         lda   FogTable,x
         sta   ForeFld+8640,y
         ldx   ForeFld+8400,y
         lda   FogTable,x
         sta   ForeFld+8400,y
         ldx   ForeFld+720,y
         lda   FogTable,x
         sta   ForeFld+720,y
         tyx
         ldal  BackFld+39120,x
         sta   ForeFld+39120,x
         ldal  BackFld+30240,x
         sta   ForeFld+30240,x
         ldal  BackFld+27600,x
         sta   ForeFld+27600,x
         ldal  BackFld+12480,x
         sta   ForeFld+12480,x
         ldal  BackFld+3360,x
         sta   ForeFld+3360,x
         iny
         iny
         iny
         nop

FogT27   ldx   ForeFld+10560,y
         lda   FogTable,x
         sta   ForeFld+10560,y
         ldx   ForeFld+960,y
         lda   FogTable,x
         sta   ForeFld+960,y
         tyx
         ldal  BackFld+30480,x
         sta   ForeFld+30480,x
         ldal  BackFld+29040,x
         sta   ForeFld+29040,x
         ldal  BackFld+27840,x
         sta   ForeFld+27840,x
         ldal  BackFld+4560,x
         sta   ForeFld+4560,x
         ldal  BackFld+3840,x
         sta   ForeFld+3840,x
         ldal  BackFld+3600,x
         sta   ForeFld+3600,x
         iny
         iny
         iny
         nop

FogT28   ldx   ForeFld+34080,y
         lda   FogTable,x
         sta   ForeFld+34080,y
         ldx   ForeFld+8160,y
         lda   FogTable,x
         sta   ForeFld+8160,y
         ldx   ForeFld+1440,y
         lda   FogTable,x
         sta   ForeFld+1440,y
         ldx   ForeFld+1200,y
         lda   FogTable,x
         sta   ForeFld+1200,y
         tyx
         ldal  BackFld+30720,x
         sta   ForeFld+30720,x
         ldal  BackFld+28320,x
         sta   ForeFld+28320,x
         ldal  BackFld+28080,x
         sta   ForeFld+28080,x
         ldal  BackFld+15840,x
         sta   ForeFld+15840,x
         ldal  BackFld+4320,x
         sta   ForeFld+4320,x
         ldal  BackFld+4080,x
         sta   ForeFld+4080,x
         iny
         iny
         iny
         nop

FogT29   ldx   ForeFld+12480,y
         lda   FogTable,x
         sta   ForeFld+12480,y
         ldx   ForeFld+11040,y
         lda   FogTable,x
         sta   ForeFld+11040,y
         ldx   ForeFld+10800,y
         lda   FogTable,x
         sta   ForeFld+10800,y
         ldx   ForeFld+1920,y
         lda   FogTable,x
         sta   ForeFld+1920,y
         ldx   ForeFld+1680,y
         lda   FogTable,x
         sta   ForeFld+1680,y
         tyx
         ldal  BackFld+28560,x
         sta   ForeFld+28560,x
         ldal  BackFld+23040,x
         sta   ForeFld+23040,x
         ldal  BackFld+15600,x
         sta   ForeFld+15600,x
         iny
         iny
         iny
         nop

FogT30   ldx   ForeFld+2160,y
         lda   FogTable,x
         sta   ForeFld+2160,y
         tyx
         ldal  BackFld+28800,x
         sta   ForeFld+28800,x
         ldal  BackFld+15360,x
         sta   ForeFld+15360,x
         iny
         iny
         iny
         nop

FogT31   ldx   ForeFld+41760,y
         lda   FogTable,x
         sta   ForeFld+41760,y
         ldx   ForeFld+34320,y
         lda   FogTable,x
         sta   ForeFld+34320,y
         ldx   ForeFld+2400,y
         lda   FogTable,x
         sta   ForeFld+2400,y
         tyx
         ldal  BackFld+46080,x
         sta   ForeFld+46080,x
         ldal  BackFld+22800,x
         sta   ForeFld+22800,x
         ldal  BackFld+16080,x
         sta   ForeFld+16080,x
         iny
         iny
         iny
         nop

FogT32   ldx   ForeFld+12240,y
         lda   FogTable,x
         sta   ForeFld+12240,y
         ldx   ForeFld+2640,y
         lda   FogTable,x
         sta   ForeFld+2640,y
         tyx
         ldal  BackFld+22560,x
         sta   ForeFld+22560,x
         ldal  BackFld+16320,x
         sta   ForeFld+16320,x
         iny
         iny
         iny
         nop

FogT33   ldx   ForeFld+34560,y
         lda   FogTable,x
         sta   ForeFld+34560,y
         ldx   ForeFld+30720,y
         lda   FogTable,x
         sta   ForeFld+30720,y
         ldx   ForeFld+12000,y
         lda   FogTable,x
         sta   ForeFld+12000,y
         tyx
         ldal  BackFld+45840,x
         sta   ForeFld+45840,x
         ldal  BackFld+16800,x
         sta   ForeFld+16800,x
         ldal  BackFld+16560,x
         sta   ForeFld+16560,x
         ldal  BackFld+11040,x
         sta   ForeFld+11040,x
         iny
         iny
         iny
         nop

FogT34   ldx   ForeFld+41520,y
         lda   FogTable,x
         sta   ForeFld+41520,y
         ldx   ForeFld+24960,y
         lda   FogTable,x
         sta   ForeFld+24960,y
         ldx   ForeFld+24720,y
         lda   FogTable,x
         sta   ForeFld+24720,y
         ldx   ForeFld+24480,y
         lda   FogTable,x
         sta   ForeFld+24480,y
         ldx   ForeFld+15360,y
         lda   FogTable,x
         sta   ForeFld+15360,y
         ldx   ForeFld+11760,y
         lda   FogTable,x
         sta   ForeFld+11760,y
         ldx   ForeFld+2880,y
         lda   FogTable,x
         sta   ForeFld+2880,y
         tyx
         ldal  BackFld+45600,x
         sta   ForeFld+45600,x
         ldal  BackFld+22320,x
         sta   ForeFld+22320,x
         ldal  BackFld+17040,x
         sta   ForeFld+17040,x
         iny
         iny
         iny
         nop

FogT35   ldx   ForeFld+34800,y
         lda   FogTable,x
         sta   ForeFld+34800,y
         ldx   ForeFld+30480,y
         lda   FogTable,x
         sta   ForeFld+30480,y
         ldx   ForeFld+24240,y
         lda   FogTable,x
         sta   ForeFld+24240,y
         ldx   ForeFld+11520,y
         lda   FogTable,x
         sta   ForeFld+11520,y
         tyx
         ldal  BackFld+45360,x
         sta   ForeFld+45360,x
         ldal  BackFld+22080,x
         sta   ForeFld+22080,x
         ldal  BackFld+17280,x
         sta   ForeFld+17280,x
         iny
         iny
         iny
         nop

FogT36   ldx   ForeFld+41280,y
         lda   FogTable,x
         sta   ForeFld+41280,y
         ldx   ForeFld+35040,y
         lda   FogTable,x
         sta   ForeFld+35040,y
         ldx   ForeFld+25200,y
         lda   FogTable,x
         sta   ForeFld+25200,y
         ldx   ForeFld+24000,y
         lda   FogTable,x
         sta   ForeFld+24000,y
         ldx   ForeFld+23760,y
         lda   FogTable,x
         sta   ForeFld+23760,y
         ldx   ForeFld+15600,y
         lda   FogTable,x
         sta   ForeFld+15600,y
         ldx   ForeFld+11280,y
         lda   FogTable,x
         sta   ForeFld+11280,y
         tyx
         ldal  BackFld+45120,x
         sta   ForeFld+45120,x
         ldal  BackFld+21840,x
         sta   ForeFld+21840,x
         ldal  BackFld+10800,x
         sta   ForeFld+10800,x
         iny
         iny
         iny
         nop

FogT37   ldx   ForeFld+35280,y
         lda   FogTable,x
         sta   ForeFld+35280,y
         ldx   ForeFld+23520,y
         lda   FogTable,x
         sta   ForeFld+23520,y
         ldx   ForeFld+15840,y
         lda   FogTable,x
         sta   ForeFld+15840,y
         ldx   ForeFld+11040,y
         lda   FogTable,x
         sta   ForeFld+11040,y
         ldx   ForeFld+7920,y
         lda   FogTable,x
         sta   ForeFld+7920,y
         tyx
         ldal  BackFld+17520,x
         sta   ForeFld+17520,x
         iny
         iny
         iny
         nop

FogT38   ldx   ForeFld+35520,y
         lda   FogTable,x
         sta   ForeFld+35520,y
         ldx   ForeFld+30240,y
         lda   FogTable,x
         sta   ForeFld+30240,y
         ldx   ForeFld+23280,y
         lda   FogTable,x
         sta   ForeFld+23280,y
         ldx   ForeFld+3120,y
         lda   FogTable,x
         sta   ForeFld+3120,y
         tyx
         ldal  BackFld+44880,x
         sta   ForeFld+44880,x
         ldal  BackFld+21600,x
         sta   ForeFld+21600,x
         iny
         iny
         iny
         nop

FogT39   ldx   ForeFld+36000,y
         lda   FogTable,x
         sta   ForeFld+36000,y
         ldx   ForeFld+35760,y
         lda   FogTable,x
         sta   ForeFld+35760,y
         ldx   ForeFld+23040,y
         lda   FogTable,x
         sta   ForeFld+23040,y
         ldx   ForeFld+10800,y
         lda   FogTable,x
         sta   ForeFld+10800,y
         ldx   ForeFld+7680,y
         lda   FogTable,x
         sta   ForeFld+7680,y
         tyx
         ldal  BackFld+44640,x
         sta   ForeFld+44640,x
         iny
         iny
         iny
         nop

FogT40   ldx   ForeFld+41040,y
         lda   FogTable,x
         sta   ForeFld+41040,y
         ldx   ForeFld+36240,y
         lda   FogTable,x
         sta   ForeFld+36240,y
         ldx   ForeFld+30000,y
         lda   FogTable,x
         sta   ForeFld+30000,y
         ldx   ForeFld+22800,y
         lda   FogTable,x
         sta   ForeFld+22800,y
         ldx   ForeFld+3360,y
         lda   FogTable,x
         sta   ForeFld+3360,y
         tyx
         ldal  BackFld+32880,x
         sta   ForeFld+32880,x
         ldal  BackFld+32640,x
         sta   ForeFld+32640,x
         ldal  BackFld+25200,x
         sta   ForeFld+25200,x
         iny
         iny
         iny
         nop

FogT41   ldx   ForeFld+46080,y
         lda   FogTable,x
         sta   ForeFld+46080,y
         ldx   ForeFld+36480,y
         lda   FogTable,x
         sta   ForeFld+36480,y
         ldx   ForeFld+32640,y
         lda   FogTable,x
         sta   ForeFld+32640,y
         ldx   ForeFld+22560,y
         lda   FogTable,x
         sta   ForeFld+22560,y
         ldx   ForeFld+7440,y
         lda   FogTable,x
         sta   ForeFld+7440,y
         tyx
         ldal  BackFld+33360,x
         sta   ForeFld+33360,x
         ldal  BackFld+33120,x
         sta   ForeFld+33120,x
         iny
         iny
         iny
         nop

FogT42   ldx   ForeFld+32880,y
         lda   FogTable,x
         sta   ForeFld+32880,y
         ldx   ForeFld+22320,y
         lda   FogTable,x
         sta   ForeFld+22320,y
         ldx   ForeFld+7200,y
         lda   FogTable,x
         sta   ForeFld+7200,y
         ldx   ForeFld+6960,y
         lda   FogTable,x
         sta   ForeFld+6960,y
         tyx
         ldal  BackFld+44400,x
         sta   ForeFld+44400,x
         ldal  BackFld+33600,x
         sta   ForeFld+33600,x
         ldal  BackFld+11520,x
         sta   ForeFld+11520,x
         ldal  BackFld+3360,x
         sta   ForeFld+3360,x
         iny
         iny
         iny
         nop

FogT43   ldx   ForeFld+45840,y
         lda   FogTable,x
         sta   ForeFld+45840,y
         ldx   ForeFld+36720,y
         lda   FogTable,x
         sta   ForeFld+36720,y
         ldx   ForeFld+22080,y
         lda   FogTable,x
         sta   ForeFld+22080,y
         ldx   ForeFld+21600,y
         lda   FogTable,x
         sta   ForeFld+21600,y
         ldx   ForeFld+17520,y
         lda   FogTable,x
         sta   ForeFld+17520,y
         ldx   ForeFld+6720,y
         lda   FogTable,x
         sta   ForeFld+6720,y
         tyx
         ldal  BackFld+33840,x
         sta   ForeFld+33840,x
         ldal  BackFld+24960,x
         sta   ForeFld+24960,x
         ldal  BackFld+15840,x
         sta   ForeFld+15840,x
         ldal  BackFld+11280,x
         sta   ForeFld+11280,x
         ldal  BackFld+3120,x
         sta   ForeFld+3120,x
         iny
         iny
         iny
         nop

FogT44   ldx   ForeFld+21840,y
         lda   FogTable,x
         sta   ForeFld+21840,y
         ldx   ForeFld+6480,y
         lda   FogTable,x
         sta   ForeFld+6480,y
         tyx
         ldal  BackFld+41040,x
         sta   ForeFld+41040,x
         ldal  BackFld+34080,x
         sta   ForeFld+34080,x
         iny
         iny
         iny
         nop

FogT45   ldx   ForeFld+36960,y
         lda   FogTable,x
         sta   ForeFld+36960,y
         ldx   ForeFld+11520,y
         lda   FogTable,x
         sta   ForeFld+11520,y
         ldx   ForeFld+6240,y
         lda   FogTable,x
         sta   ForeFld+6240,y
         ldx   ForeFld+6000,y
         lda   FogTable,x
         sta   ForeFld+6000,y
         tyx
         ldal  BackFld+32880,x
         sta   ForeFld+32880,x
         ldal  BackFld+24720,x
         sta   ForeFld+24720,x
         ldal  BackFld+15600,x
         sta   ForeFld+15600,x
         ldal  BackFld+11040,x
         sta   ForeFld+11040,x
         ldal  BackFld+10800,x
         sta   ForeFld+10800,x
         ldal  BackFld+2880,x
         sta   ForeFld+2880,x
         iny
         iny
         iny
         nop

FogT46   ldx   ForeFld+45600,y
         lda   FogTable,x
         sta   ForeFld+45600,y
         ldx   ForeFld+17280,y
         lda   FogTable,x
         sta   ForeFld+17280,y
         ldx   ForeFld+5760,y
         lda   FogTable,x
         sta   ForeFld+5760,y
         tyx
         ldal  BackFld+41280,x
         sta   ForeFld+41280,x
         ldal  BackFld+34320,x
         sta   ForeFld+34320,x
         ldal  BackFld+15360,x
         sta   ForeFld+15360,x
         ldal  BackFld+10560,x
         sta   ForeFld+10560,x
         ldal  BackFld+10320,x
         sta   ForeFld+10320,x
         ldal  BackFld+2640,x
         sta   ForeFld+2640,x
         iny
         iny
         iny
         nop

FogT47   ldx   ForeFld+11280,y
         lda   FogTable,x
         sta   ForeFld+11280,y
         ldx   ForeFld+5520,y
         lda   FogTable,x
         sta   ForeFld+5520,y
         ldx   ForeFld+5280,y
         lda   FogTable,x
         sta   ForeFld+5280,y
         tyx
         ldal  BackFld+41520,x
         sta   ForeFld+41520,x
         ldal  BackFld+30000,x
         sta   ForeFld+30000,x
         ldal  BackFld+15120,x
         sta   ForeFld+15120,x
         iny
         iny
         iny
         nop

FogT48   ldx   ForeFld+44400,y
         lda   FogTable,x
         sta   ForeFld+44400,y
         ldx   ForeFld+5040,y
         lda   FogTable,x
         sta   ForeFld+5040,y
         tyx
         ldal  BackFld+14880,x
         sta   ForeFld+14880,x
         ldal  BackFld+10080,x
         sta   ForeFld+10080,x
         ldal  BackFld+2400,x
         sta   ForeFld+2400,x
         iny
         iny
         iny
         nop

FogT49   ldx   ForeFld+32880,y
         lda   FogTable,x
         sta   ForeFld+32880,y
         ldx   ForeFld+4800,y
         lda   FogTable,x
         sta   ForeFld+4800,y
         tyx
         ldal  BackFld+34560,x
         sta   ForeFld+34560,x
         ldal  BackFld+24480,x
         sta   ForeFld+24480,x
         ldal  BackFld+14640,x
         sta   ForeFld+14640,x
         ldal  BackFld+9840,x
         sta   ForeFld+9840,x
         ldal  BackFld+2160,x
         sta   ForeFld+2160,x
         iny
         iny
         iny
         nop

FogT50   ldx   ForeFld+44640,y
         lda   FogTable,x
         sta   ForeFld+44640,y
         ldx   ForeFld+37200,y
         lda   FogTable,x
         sta   ForeFld+37200,y
         ldx   ForeFld+4560,y
         lda   FogTable,x
         sta   ForeFld+4560,y
         tyx
         ldal  BackFld+45600,x
         sta   ForeFld+45600,x
         ldal  BackFld+41760,x
         sta   ForeFld+41760,x
         ldal  BackFld+34800,x
         sta   ForeFld+34800,x
         ldal  BackFld+1920,x
         sta   ForeFld+1920,x
         iny
         iny
         iny
         nop

FogT51   ldx   ForeFld+44880,y
         lda   FogTable,x
         sta   ForeFld+44880,y
         ldx   ForeFld+33120,y
         lda   FogTable,x
         sta   ForeFld+33120,y
         ldx   ForeFld+17040,y
         lda   FogTable,x
         sta   ForeFld+17040,y
         ldx   ForeFld+4320,y
         lda   FogTable,x
         sta   ForeFld+4320,y
         tyx
         ldal  BackFld+35040,x
         sta   ForeFld+35040,x
         ldal  BackFld+24240,x
         sta   ForeFld+24240,x
         ldal  BackFld+14400,x
         sta   ForeFld+14400,x
         ldal  BackFld+9600,x
         sta   ForeFld+9600,x
         iny
         iny
         iny
         nop

FogT52   ldx   ForeFld+4080,y
         lda   FogTable,x
         sta   ForeFld+4080,y
         tyx
         ldal  BackFld+35280,x
         sta   ForeFld+35280,x
         ldal  BackFld+11280,x
         sta   ForeFld+11280,x
         iny
         iny
         iny
         nop

FogT53   ldx   ForeFld+45120,y
         lda   FogTable,x
         sta   ForeFld+45120,y
         ldx   ForeFld+33360,y
         lda   FogTable,x
         sta   ForeFld+33360,y
         ldx   ForeFld+26880,y
         lda   FogTable,x
         sta   ForeFld+26880,y
         tyx
         ldal  BackFld+35760,x
         sta   ForeFld+35760,x
         ldal  BackFld+35520,x
         sta   ForeFld+35520,x
         iny
         iny
         iny
         nop

FogT54   ldx   ForeFld+33600,y
         lda   FogTable,x
         sta   ForeFld+33600,y
         ldx   ForeFld+26640,y
         lda   FogTable,x
         sta   ForeFld+26640,y
         ldx   ForeFld+3840,y
         lda   FogTable,x
         sta   ForeFld+3840,y
         ldx   ForeFld+1920,y
         lda   FogTable,x
         sta   ForeFld+1920,y
         tyx
         ldal  BackFld+42000,x
         sta   ForeFld+42000,x
         ldal  BackFld+37200,x
         sta   ForeFld+37200,x
         ldal  BackFld+36240,x
         sta   ForeFld+36240,x
         ldal  BackFld+36000,x
         sta   ForeFld+36000,x
         ldal  BackFld+14160,x
         sta   ForeFld+14160,x
         ldal  BackFld+11520,x
         sta   ForeFld+11520,x
         iny
         iny
         iny
         nop

FogT55   ldx   ForeFld+45600,y
         lda   FogTable,x
         sta   ForeFld+45600,y
         ldx   ForeFld+33840,y
         lda   FogTable,x
         sta   ForeFld+33840,y
         ldx   ForeFld+26400,y
         lda   FogTable,x
         sta   ForeFld+26400,y
         tyx
         ldal  BackFld+36720,x
         sta   ForeFld+36720,x
         ldal  BackFld+36480,x
         sta   ForeFld+36480,x
         ldal  BackFld+24000,x
         sta   ForeFld+24000,x
         ldal  BackFld+19200,x
         sta   ForeFld+19200,x
         ldal  BackFld+17040,x
         sta   ForeFld+17040,x
         ldal  BackFld+12000,x
         sta   ForeFld+12000,x
         ldal  BackFld+11760,x
         sta   ForeFld+11760,x
         iny
         iny
         iny
         nop

FogT56   ldx   ForeFld+45360,y
         lda   FogTable,x
         sta   ForeFld+45360,y
         ldx   ForeFld+27120,y
         lda   FogTable,x
         sta   ForeFld+27120,y
         ldx   ForeFld+9600,y
         lda   FogTable,x
         sta   ForeFld+9600,y
         ldx   ForeFld+2160,y
         lda   FogTable,x
         sta   ForeFld+2160,y
         tyx
         ldal  BackFld+36960,x
         sta   ForeFld+36960,x
         ldal  BackFld+30240,x
         sta   ForeFld+30240,x
         ldal  BackFld+13920,x
         sta   ForeFld+13920,x
         ldal  BackFld+12240,x
         sta   ForeFld+12240,x
         iny
         iny
         iny
         nop

FogT57   ldx   ForeFld+34080,y
         lda   FogTable,x
         sta   ForeFld+34080,y
         ldx   ForeFld+26160,y
         lda   FogTable,x
         sta   ForeFld+26160,y
         ldx   ForeFld+9840,y
         lda   FogTable,x
         sta   ForeFld+9840,y
         tyx
         ldal  BackFld+18960,x
         sta   ForeFld+18960,x
         ldal  BackFld+12480,x
         sta   ForeFld+12480,x
         iny
         iny
         iny
         nop

FogT58   ldx   ForeFld+34320,y
         lda   FogTable,x
         sta   ForeFld+34320,y
         ldx   ForeFld+25920,y
         lda   FogTable,x
         sta   ForeFld+25920,y
         ldx   ForeFld+24000,y
         lda   FogTable,x
         sta   ForeFld+24000,y
         ldx   ForeFld+10080,y
         lda   FogTable,x
         sta   ForeFld+10080,y
         tyx
         ldal  BackFld+42240,x
         sta   ForeFld+42240,x
         ldal  BackFld+12720,x
         sta   ForeFld+12720,x
         iny
         iny
         iny
         nop

FogT59   ldx   ForeFld+34560,y
         lda   FogTable,x
         sta   ForeFld+34560,y
         ldx   ForeFld+10320,y
         lda   FogTable,x
         sta   ForeFld+10320,y
         tyx
         ldal  BackFld+19440,x
         sta   ForeFld+19440,x
         ldal  BackFld+17280,x
         sta   ForeFld+17280,x
         ldal  BackFld+13200,x
         sta   ForeFld+13200,x
         ldal  BackFld+12960,x
         sta   ForeFld+12960,x
         iny
         iny
         iny
         nop

FogT60   ldx   ForeFld+34800,y
         lda   FogTable,x
         sta   ForeFld+34800,y
         ldx   ForeFld+27360,y
         lda   FogTable,x
         sta   ForeFld+27360,y
         ldx   ForeFld+10560,y
         lda   FogTable,x
         sta   ForeFld+10560,y
         ldx   ForeFld+3600,y
         lda   FogTable,x
         sta   ForeFld+3600,y
         tyx
         ldal  BackFld+30480,x
         sta   ForeFld+30480,x
         ldal  BackFld+13440,x
         sta   ForeFld+13440,x
         iny
         iny
         iny
         nop

FogT61   ldx   ForeFld+35040,y
         lda   FogTable,x
         sta   ForeFld+35040,y
         ldx   ForeFld+24240,y
         lda   FogTable,x
         sta   ForeFld+24240,y
         ldx   ForeFld+11040,y
         lda   FogTable,x
         sta   ForeFld+11040,y
         ldx   ForeFld+10800,y
         lda   FogTable,x
         sta   ForeFld+10800,y
         ldx   ForeFld+3360,y
         lda   FogTable,x
         sta   ForeFld+3360,y
         tyx
         ldal  BackFld+42480,x
         sta   ForeFld+42480,x
         ldal  BackFld+17520,x
         sta   ForeFld+17520,x
         ldal  BackFld+13680,x
         sta   ForeFld+13680,x
         ldal  BackFld+2160,x
         sta   ForeFld+2160,x
         iny
         iny
         iny
         nop

FogT62   ldx   ForeFld+35280,y
         lda   FogTable,x
         sta   ForeFld+35280,y
         ldx   ForeFld+24480,y
         lda   FogTable,x
         sta   ForeFld+24480,y
         ldx   ForeFld+11280,y
         lda   FogTable,x
         sta   ForeFld+11280,y
         tyx
         ldal  BackFld+18720,x
         sta   ForeFld+18720,x
         ldal  BackFld+17760,x
         sta   ForeFld+17760,x
         ldal  BackFld+1920,x
         sta   ForeFld+1920,x
         iny
         iny
         iny
         nop

FogT63   ldx   ForeFld+35520,y
         lda   FogTable,x
         sta   ForeFld+35520,y
         ldx   ForeFld+24720,y
         lda   FogTable,x
         sta   ForeFld+24720,y
         tyx
         ldal  BackFld+42720,x
         sta   ForeFld+42720,x
         ldal  BackFld+30720,x
         sta   ForeFld+30720,x
         ldal  BackFld+25920,x
         sta   ForeFld+25920,x
         ldal  BackFld+18000,x
         sta   ForeFld+18000,x
         iny
         iny
         iny
         nop

FogT64   ldx   ForeFld+27600,y
         lda   FogTable,x
         sta   ForeFld+27600,y
         ldx   ForeFld+25200,y
         lda   FogTable,x
         sta   ForeFld+25200,y
         ldx   ForeFld+24960,y
         lda   FogTable,x
         sta   ForeFld+24960,y
         ldx   ForeFld+11520,y
         lda   FogTable,x
         sta   ForeFld+11520,y
         ldx   ForeFld+1920,y
         lda   FogTable,x
         sta   ForeFld+1920,y
         tyx
         ldal  BackFld+30960,x
         sta   ForeFld+30960,x
         ldal  BackFld+18480,x
         sta   ForeFld+18480,x
         ldal  BackFld+3360,x
         sta   ForeFld+3360,x
         iny
         iny
         iny
         nop

FogT65   ldx   ForeFld+35760,y
         lda   FogTable,x
         sta   ForeFld+35760,y
         ldx   ForeFld+25440,y
         lda   FogTable,x
         sta   ForeFld+25440,y
         ldx   ForeFld+2400,y
         lda   FogTable,x
         sta   ForeFld+2400,y
         ldx   ForeFld+2160,y
         lda   FogTable,x
         sta   ForeFld+2160,y
         tyx
         ldal  BackFld+31200,x
         sta   ForeFld+31200,x
         ldal  BackFld+19680,x
         sta   ForeFld+19680,x
         ldal  BackFld+18240,x
         sta   ForeFld+18240,x
         ldal  BackFld+3600,x
         sta   ForeFld+3600,x
         iny
         iny
         iny
         nop

FogT66   ldx   ForeFld+39840,y
         lda   FogTable,x
         sta   ForeFld+39840,y
         ldx   ForeFld+25920,y
         lda   FogTable,x
         sta   ForeFld+25920,y
         ldx   ForeFld+25680,y
         lda   FogTable,x
         sta   ForeFld+25680,y
         ldx   ForeFld+2640,y
         lda   FogTable,x
         sta   ForeFld+2640,y
         tyx
         ldal  BackFld+6480,x
         sta   ForeFld+6480,x
         iny
         iny
         iny
         nop

FogT67   ldx   ForeFld+27840,y
         lda   FogTable,x
         sta   ForeFld+27840,y
         ldx   ForeFld+3600,y
         lda   FogTable,x
         sta   ForeFld+3600,y
         ldx   ForeFld+2880,y
         lda   FogTable,x
         sta   ForeFld+2880,y
         tyx
         ldal  BackFld+42960,x
         sta   ForeFld+42960,x
         ldal  BackFld+31440,x
         sta   ForeFld+31440,x
         ldal  BackFld+23280,x
         sta   ForeFld+23280,x
         ldal  BackFld+6720,x
         sta   ForeFld+6720,x
         iny
         iny
         iny
         nop

FogT68   ldx   ForeFld+40080,y
         lda   FogTable,x
         sta   ForeFld+40080,y
         ldx   ForeFld+39600,y
         lda   FogTable,x
         sta   ForeFld+39600,y
         ldx   ForeFld+39360,y
         lda   FogTable,x
         sta   ForeFld+39360,y
         ldx   ForeFld+28080,y
         lda   FogTable,x
         sta   ForeFld+28080,y
         ldx   ForeFld+6480,y
         lda   FogTable,x
         sta   ForeFld+6480,y
         tyx
         ldal  BackFld+31680,x
         sta   ForeFld+31680,x
         ldal  BackFld+23040,x
         sta   ForeFld+23040,x
         iny
         iny
         iny
         nop

FogT69   ldx   ForeFld+36000,y
         lda   FogTable,x
         sta   ForeFld+36000,y
         ldx   ForeFld+11760,y
         lda   FogTable,x
         sta   ForeFld+11760,y
         ldx   ForeFld+3360,y
         lda   FogTable,x
         sta   ForeFld+3360,y
         tyx
         ldal  BackFld+43200,x
         sta   ForeFld+43200,x
         ldal  BackFld+31920,x
         sta   ForeFld+31920,x
         ldal  BackFld+22800,x
         sta   ForeFld+22800,x
         ldal  BackFld+7200,x
         sta   ForeFld+7200,x
         ldal  BackFld+6960,x
         sta   ForeFld+6960,x
         ldal  BackFld+2880,x
         sta   ForeFld+2880,x
         iny
         iny
         iny
         nop

FogT70   ldx   ForeFld+40320,y
         lda   FogTable,x
         sta   ForeFld+40320,y
         ldx   ForeFld+39120,y
         lda   FogTable,x
         sta   ForeFld+39120,y
         ldx   ForeFld+38880,y
         lda   FogTable,x
         sta   ForeFld+38880,y
         ldx   ForeFld+28320,y
         lda   FogTable,x
         sta   ForeFld+28320,y
         ldx   ForeFld+23280,y
         lda   FogTable,x
         sta   ForeFld+23280,y
         ldx   ForeFld+6720,y
         lda   FogTable,x
         sta   ForeFld+6720,y
         ldx   ForeFld+3120,y
         lda   FogTable,x
         sta   ForeFld+3120,y
         ldx   ForeFld+2880,y
         lda   FogTable,x
         sta   ForeFld+2880,y
         tyx
         ldal  BackFld+43440,x
         sta   ForeFld+43440,x
         ldal  BackFld+32160,x
         sta   ForeFld+32160,x
         ldal  BackFld+22560,x
         sta   ForeFld+22560,x
         ldal  BackFld+7440,x
         sta   ForeFld+7440,x
         iny
         iny
         iny
         nop

FogT71   ldx   ForeFld+28560,y
         lda   FogTable,x
         sta   ForeFld+28560,y
         ldx   ForeFld+6960,y
         lda   FogTable,x
         sta   ForeFld+6960,y
         tyx
         ldal  BackFld+43680,x
         sta   ForeFld+43680,x
         ldal  BackFld+32400,x
         sta   ForeFld+32400,x
         ldal  BackFld+7920,x
         sta   ForeFld+7920,x
         ldal  BackFld+7680,x
         sta   ForeFld+7680,x
         iny
         iny
         iny
         nop

FogT72   ldx   ForeFld+40560,y
         lda   FogTable,x
         sta   ForeFld+40560,y
         ldx   ForeFld+38640,y
         lda   FogTable,x
         sta   ForeFld+38640,y
         tyx
         ldal  BackFld+43920,x
         sta   ForeFld+43920,x
         ldal  BackFld+36000,x
         sta   ForeFld+36000,x
         ldal  BackFld+32640,x
         sta   ForeFld+32640,x
         ldal  BackFld+22320,x
         sta   ForeFld+22320,x
         ldal  BackFld+22080,x
         sta   ForeFld+22080,x
         ldal  BackFld+19920,x
         sta   ForeFld+19920,x
         ldal  BackFld+8400,x
         sta   ForeFld+8400,x
         ldal  BackFld+8160,x
         sta   ForeFld+8160,x
         iny
         iny
         iny
         nop

FogT73   ldx   ForeFld+41040,y
         lda   FogTable,x
         sta   ForeFld+41040,y
         ldx   ForeFld+40800,y
         lda   FogTable,x
         sta   ForeFld+40800,y
         ldx   ForeFld+38400,y
         lda   FogTable,x
         sta   ForeFld+38400,y
         ldx   ForeFld+28800,y
         lda   FogTable,x
         sta   ForeFld+28800,y
         ldx   ForeFld+7200,y
         lda   FogTable,x
         sta   ForeFld+7200,y
         tyx
         ldal  BackFld+44400,x
         sta   ForeFld+44400,x
         ldal  BackFld+44160,x
         sta   ForeFld+44160,x
         ldal  BackFld+35760,x
         sta   ForeFld+35760,x
         ldal  BackFld+33120,x
         sta   ForeFld+33120,x
         ldal  BackFld+32880,x
         sta   ForeFld+32880,x
         ldal  BackFld+21840,x
         sta   ForeFld+21840,x
         ldal  BackFld+8880,x
         sta   ForeFld+8880,x
         ldal  BackFld+8640,x
         sta   ForeFld+8640,x
         iny
         iny
         iny
         nop

FogT74   tyx
         ldal  BackFld+44640,x
         sta   ForeFld+44640,x
         ldal  BackFld+35520,x
         sta   ForeFld+35520,x
         ldal  BackFld+33360,x
         sta   ForeFld+33360,x
         ldal  BackFld+21600,x
         sta   ForeFld+21600,x
         ldal  BackFld+20160,x
         sta   ForeFld+20160,x
         ldal  BackFld+11760,x
         sta   ForeFld+11760,x
         ldal  BackFld+9120,x
         sta   ForeFld+9120,x
         iny
         iny
         iny
         nop

FogT75   ldx   ForeFld+41280,y
         lda   FogTable,x
         sta   ForeFld+41280,y
         ldx   ForeFld+38160,y
         lda   FogTable,x
         sta   ForeFld+38160,y
         ldx   ForeFld+29040,y
         lda   FogTable,x
         sta   ForeFld+29040,y
         ldx   ForeFld+7440,y
         lda   FogTable,x
         sta   ForeFld+7440,y
         tyx
         ldal  BackFld+44880,x
         sta   ForeFld+44880,x
         ldal  BackFld+33840,x
         sta   ForeFld+33840,x
         ldal  BackFld+33600,x
         sta   ForeFld+33600,x
         ldal  BackFld+23280,x
         sta   ForeFld+23280,x
         ldal  BackFld+21360,x
         sta   ForeFld+21360,x
         ldal  BackFld+9600,x
         sta   ForeFld+9600,x
         ldal  BackFld+9360,x
         sta   ForeFld+9360,x
         iny
         iny
         iny
         nop

FogT76   ldx   ForeFld+41760,y
         lda   FogTable,x
         sta   ForeFld+41760,y
         ldx   ForeFld+41520,y
         lda   FogTable,x
         sta   ForeFld+41520,y
         ldx   ForeFld+37920,y
         lda   FogTable,x
         sta   ForeFld+37920,y
         tyx
         ldal  BackFld+45360,x
         sta   ForeFld+45360,x
         ldal  BackFld+45120,x
         sta   ForeFld+45120,x
         ldal  BackFld+35280,x
         sta   ForeFld+35280,x
         ldal  BackFld+34080,x
         sta   ForeFld+34080,x
         ldal  BackFld+23520,x
         sta   ForeFld+23520,x
         ldal  BackFld+21120,x
         sta   ForeFld+21120,x
         ldal  BackFld+11520,x
         sta   ForeFld+11520,x
         ldal  BackFld+9840,x
         sta   ForeFld+9840,x
         iny
         iny
         iny
         nop

FogT77   ldx   ForeFld+42000,y
         lda   FogTable,x
         sta   ForeFld+42000,y
         ldx   ForeFld+37680,y
         lda   FogTable,x
         sta   ForeFld+37680,y
         tyx
         ldal  BackFld+45600,x
         sta   ForeFld+45600,x
         ldal  BackFld+35040,x
         sta   ForeFld+35040,x
         ldal  BackFld+34320,x
         sta   ForeFld+34320,x
         ldal  BackFld+29040,x
         sta   ForeFld+29040,x
         ldal  BackFld+23760,x
         sta   ForeFld+23760,x
         ldal  BackFld+11280,x
         sta   ForeFld+11280,x
         iny
         iny
         iny
         nop

FogT78   ldx   ForeFld+42480,y
         lda   FogTable,x
         sta   ForeFld+42480,y
         ldx   ForeFld+42240,y
         lda   FogTable,x
         sta   ForeFld+42240,y
         ldx   ForeFld+37440,y
         lda   FogTable,x
         sta   ForeFld+37440,y
         ldx   ForeFld+15360,y
         lda   FogTable,x
         sta   ForeFld+15360,y
         ldx   ForeFld+15120,y
         lda   FogTable,x
         sta   ForeFld+15120,y
         ldx   ForeFld+14880,y
         lda   FogTable,x
         sta   ForeFld+14880,y
         ldx   ForeFld+14640,y
         lda   FogTable,x
         sta   ForeFld+14640,y
         tyx
         ldal  BackFld+45840,x
         sta   ForeFld+45840,x
         ldal  BackFld+34800,x
         sta   ForeFld+34800,x
         ldal  BackFld+34560,x
         sta   ForeFld+34560,x
         ldal  BackFld+20400,x
         sta   ForeFld+20400,x
         ldal  BackFld+11040,x
         sta   ForeFld+11040,x
         ldal  BackFld+10080,x
         sta   ForeFld+10080,x
         ldal  BackFld+7440,x
         sta   ForeFld+7440,x
         iny
         iny
         iny
         nop

FogT79   ldx   ForeFld+42720,y
         lda   FogTable,x
         sta   ForeFld+42720,y
         ldx   ForeFld+37200,y
         lda   FogTable,x
         sta   ForeFld+37200,y
         ldx   ForeFld+36960,y
         lda   FogTable,x
         sta   ForeFld+36960,y
         ldx   ForeFld+31920,y
         lda   FogTable,x
         sta   ForeFld+31920,y
         ldx   ForeFld+16560,y
         lda   FogTable,x
         sta   ForeFld+16560,y
         ldx   ForeFld+16320,y
         lda   FogTable,x
         sta   ForeFld+16320,y
         ldx   ForeFld+16080,y
         lda   FogTable,x
         sta   ForeFld+16080,y
         ldx   ForeFld+15840,y
         lda   FogTable,x
         sta   ForeFld+15840,y
         ldx   ForeFld+15600,y
         lda   FogTable,x
         sta   ForeFld+15600,y
         ldx   ForeFld+14400,y
         lda   FogTable,x
         sta   ForeFld+14400,y
         tyx
         ldal  BackFld+46080,x
         sta   ForeFld+46080,x
         ldal  BackFld+40320,x
         sta   ForeFld+40320,x
         ldal  BackFld+28800,x
         sta   ForeFld+28800,x
         ldal  BackFld+24000,x
         sta   ForeFld+24000,x
         ldal  BackFld+20880,x
         sta   ForeFld+20880,x
         ldal  BackFld+20640,x
         sta   ForeFld+20640,x
         ldal  BackFld+10800,x
         sta   ForeFld+10800,x
         ldal  BackFld+10560,x
         sta   ForeFld+10560,x
         ldal  BackFld+10320,x
         sta   ForeFld+10320,x
         jmp   BackLoop
