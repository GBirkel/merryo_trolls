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

FogT0    ldx   ForegPeaField+36720,y
         lda   FogTable,x
         sta   ForegPeaField+36720,y
         ldx   ForegPeaField+24000,y
         lda   FogTable,x
         sta   ForegPeaField+24000,y
         ldx   ForegPeaField+16800,y
         lda   FogTable,x
         sta   ForegPeaField+16800,y
         ldx   ForegPeaField+14160,y
         lda   FogTable,x
         sta   ForegPeaField+14160,y
         ldx   ForegPeaField+7440,y
         lda   FogTable,x
         sta   ForegPeaField+7440,y
         tyx
         ldal  BackgPeaField+40560,x
         sta   ForegPeaField+40560,x
         ldal  BackgPeaField+3840,x
         sta   ForegPeaField+3840,x
         ldal  BackgPeaField+3600,x
         sta   ForegPeaField+3600,x
         iny
         iny
         iny
         nop

FogT1    ldx   ForegPeaField+43200,y
         lda   FogTable,x
         sta   ForegPeaField+43200,y
         ldx   ForegPeaField+42960,y
         lda   FogTable,x
         sta   ForegPeaField+42960,y
         ldx   ForegPeaField+36480,y
         lda   FogTable,x
         sta   ForegPeaField+36480,y
         ldx   ForegPeaField+32160,y
         lda   FogTable,x
         sta   ForegPeaField+32160,y
         ldx   ForegPeaField+31680,y
         lda   FogTable,x
         sta   ForegPeaField+31680,y
         ldx   ForegPeaField+17040,y
         lda   FogTable,x
         sta   ForegPeaField+17040,y
         ldx   ForegPeaField+13920,y
         lda   FogTable,x
         sta   ForegPeaField+13920,y
         ldx   ForegPeaField+13680,y
         lda   FogTable,x
         sta   ForegPeaField+13680,y
         tyx
         ldal  BackgPeaField+40800,x
         sta   ForegPeaField+40800,x
         ldal  BackgPeaField+28560,x
         sta   ForegPeaField+28560,x
         ldal  BackgPeaField+4320,x
         sta   ForegPeaField+4320,x
         ldal  BackgPeaField+4080,x
         sta   ForegPeaField+4080,x
         iny
         iny
         iny
         nop

FogT2    ldx   ForegPeaField+43440,y
         lda   FogTable,x
         sta   ForegPeaField+43440,y
         ldx   ForegPeaField+40320,y
         lda   FogTable,x
         sta   ForegPeaField+40320,y
         ldx   ForegPeaField+32400,y
         lda   FogTable,x
         sta   ForegPeaField+32400,y
         ldx   ForegPeaField+31440,y
         lda   FogTable,x
         sta   ForegPeaField+31440,y
         ldx   ForegPeaField+13440,y
         lda   FogTable,x
         sta   ForegPeaField+13440,y
         ldx   ForegPeaField+7680,y
         lda   FogTable,x
         sta   ForegPeaField+7680,y
         ldx   ForegPeaField+3600,y
         lda   FogTable,x
         sta   ForegPeaField+3600,y
         tyx
         ldal  BackgPeaField+41040,x
         sta   ForegPeaField+41040,x
         ldal  BackgPeaField+4560,x
         sta   ForegPeaField+4560,x
         iny
         iny
         iny
         nop

FogT3    ldx   ForegPeaField+43920,y
         lda   FogTable,x
         sta   ForegPeaField+43920,y
         ldx   ForegPeaField+43680,y
         lda   FogTable,x
         sta   ForegPeaField+43680,y
         ldx   ForegPeaField+32640,y
         lda   FogTable,x
         sta   ForegPeaField+32640,y
         ldx   ForegPeaField+31200,y
         lda   FogTable,x
         sta   ForegPeaField+31200,y
         ldx   ForegPeaField+17280,y
         lda   FogTable,x
         sta   ForegPeaField+17280,y
         ldx   ForegPeaField+13200,y
         lda   FogTable,x
         sta   ForegPeaField+13200,y
         tyx
         ldal  BackgPeaField+41280,x
         sta   ForegPeaField+41280,x
         ldal  BackgPeaField+28320,x
         sta   ForegPeaField+28320,x
         ldal  BackgPeaField+5040,x
         sta   ForegPeaField+5040,x
         ldal  BackgPeaField+4800,x
         sta   ForegPeaField+4800,x
         iny
         iny
         iny
         nop

FogT4    ldx   ForegPeaField+44160,y
         lda   FogTable,x
         sta   ForegPeaField+44160,y
         ldx   ForegPeaField+36240,y
         lda   FogTable,x
         sta   ForegPeaField+36240,y
         ldx   ForegPeaField+30960,y
         lda   FogTable,x
         sta   ForegPeaField+30960,y
         ldx   ForegPeaField+17520,y
         lda   FogTable,x
         sta   ForegPeaField+17520,y
         ldx   ForegPeaField+7920,y
         lda   FogTable,x
         sta   ForegPeaField+7920,y
         ldx   ForegPeaField+3840,y
         lda   FogTable,x
         sta   ForegPeaField+3840,y
         tyx
         iny
         iny
         iny
         nop

FogT5    ldx   ForegPeaField+44400,y
         lda   FogTable,x
         sta   ForegPeaField+44400,y
         ldx   ForegPeaField+40560,y
         lda   FogTable,x
         sta   ForegPeaField+40560,y
         ldx   ForegPeaField+30720,y
         lda   FogTable,x
         sta   ForegPeaField+30720,y
         ldx   ForegPeaField+17760,y
         lda   FogTable,x
         sta   ForegPeaField+17760,y
         tyx
         ldal  BackgPeaField+41520,x
         sta   ForegPeaField+41520,x
         ldal  BackgPeaField+5520,x
         sta   ForegPeaField+5520,x
         ldal  BackgPeaField+5280,x
         sta   ForegPeaField+5280,x
         iny
         iny
         iny
         nop

FogT6    ldx   ForegPeaField+44880,y
         lda   FogTable,x
         sta   ForegPeaField+44880,y
         ldx   ForegPeaField+44640,y
         lda   FogTable,x
         sta   ForegPeaField+44640,y
         ldx   ForegPeaField+32880,y
         lda   FogTable,x
         sta   ForegPeaField+32880,y
         ldx   ForegPeaField+30480,y
         lda   FogTable,x
         sta   ForegPeaField+30480,y
         ldx   ForegPeaField+18000,y
         lda   FogTable,x
         sta   ForegPeaField+18000,y
         ldx   ForegPeaField+4080,y
         lda   FogTable,x
         sta   ForegPeaField+4080,y
         tyx
         ldal  BackgPeaField+41760,x
         sta   ForegPeaField+41760,x
         ldal  BackgPeaField+5760,x
         sta   ForegPeaField+5760,x
         iny
         iny
         iny
         nop

FogT7    ldx   ForegPeaField+45120,y
         lda   FogTable,x
         sta   ForegPeaField+45120,y
         ldx   ForegPeaField+8160,y
         lda   FogTable,x
         sta   ForegPeaField+8160,y
         ldx   ForegPeaField+4320,y
         lda   FogTable,x
         sta   ForegPeaField+4320,y
         tyx
         ldal  BackgPeaField+6000,x
         sta   ForegPeaField+6000,x
         iny
         iny
         iny
         nop

FogT8    ldx   ForegPeaField+45360,y
         lda   FogTable,x
         sta   ForegPeaField+45360,y
         ldx   ForegPeaField+4560,y
         lda   FogTable,x
         sta   ForegPeaField+4560,y
         tyx
         ldal  BackgPeaField+42000,x
         sta   ForegPeaField+42000,x
         ldal  BackgPeaField+24000,x
         sta   ForegPeaField+24000,x
         ldal  BackgPeaField+6240,x
         sta   ForegPeaField+6240,x
         ldal  BackgPeaField+240,x
         sta   ForegPeaField+240,x
         iny
         iny
         iny
         nop

FogT9    ldx   ForegPeaField+45600,y
         lda   FogTable,x
         sta   ForegPeaField+45600,y
         ldx   ForegPeaField+40800,y
         lda   FogTable,x
         sta   ForegPeaField+40800,y
         ldx   ForegPeaField+30240,y
         lda   FogTable,x
         sta   ForegPeaField+30240,y
         ldx   ForegPeaField+28320,y
         lda   FogTable,x
         sta   ForegPeaField+28320,y
         tyx
         ldal  BackgPeaField+18000,x
         sta   ForegPeaField+18000,x
         ldal  BackgPeaField+8160,x
         sta   ForegPeaField+8160,x
         ldal  BackgPeaField+6480,x
         sta   ForegPeaField+6480,x
         iny
         iny
         iny
         nop

FogT10   ldx   ForegPeaField+45840,y
         lda   FogTable,x
         sta   ForegPeaField+45840,y
         ldx   ForegPeaField+4800,y
         lda   FogTable,x
         sta   ForegPeaField+4800,y
         tyx
         ldal  BackgPeaField+42240,x
         sta   ForegPeaField+42240,x
         ldal  BackgPeaField+6720,x
         sta   ForegPeaField+6720,x
         iny
         iny
         iny
         nop

FogT11   ldx   ForegPeaField+33120,y
         lda   FogTable,x
         sta   ForegPeaField+33120,y
         ldx   ForegPeaField+30000,y
         lda   FogTable,x
         sta   ForegPeaField+30000,y
         ldx   ForegPeaField+28560,y
         lda   FogTable,x
         sta   ForegPeaField+28560,y
         ldx   ForegPeaField+12960,y
         lda   FogTable,x
         sta   ForegPeaField+12960,y
         ldx   ForegPeaField+5040,y
         lda   FogTable,x
         sta   ForegPeaField+5040,y
         tyx
         ldal  BackgPeaField+7920,x
         sta   ForegPeaField+7920,x
         ldal  BackgPeaField+6960,x
         sta   ForegPeaField+6960,x
         iny
         iny
         iny
         nop

FogT12   ldx   ForegPeaField+46080,y
         lda   FogTable,x
         sta   ForegPeaField+46080,y
         ldx   ForegPeaField+28800,y
         lda   FogTable,x
         sta   ForegPeaField+28800,y
         tyx
         ldal  BackgPeaField+36240,x
         sta   ForegPeaField+36240,x
         ldal  BackgPeaField+7680,x
         sta   ForegPeaField+7680,x
         ldal  BackgPeaField+7440,x
         sta   ForegPeaField+7440,x
         ldal  BackgPeaField+480,x
         sta   ForegPeaField+480,x
         iny
         iny
         iny
         nop

FogT13   ldx   ForegPeaField+29760,y
         lda   FogTable,x
         sta   ForegPeaField+29760,y
         ldx   ForegPeaField+29040,y
         lda   FogTable,x
         sta   ForegPeaField+29040,y
         ldx   ForegPeaField+5280,y
         lda   FogTable,x
         sta   ForegPeaField+5280,y
         tyx
         ldal  BackgPeaField+24240,x
         sta   ForegPeaField+24240,x
         ldal  BackgPeaField+7200,x
         sta   ForegPeaField+7200,x
         iny
         iny
         iny
         nop

FogT14   ldx   ForegPeaField+29280,y
         lda   FogTable,x
         sta   ForegPeaField+29280,y
         ldx   ForegPeaField+12720,y
         lda   FogTable,x
         sta   ForegPeaField+12720,y
         tyx
         ldal  BackgPeaField+42480,x
         sta   ForegPeaField+42480,x
         ldal  BackgPeaField+24480,x
         sta   ForegPeaField+24480,x
         ldal  BackgPeaField+720,x
         sta   ForegPeaField+720,x
         iny
         iny
         iny
         nop

FogT15   ldx   ForegPeaField+12480,y
         lda   FogTable,x
         sta   ForegPeaField+12480,y
         tyx
         ldal  BackgPeaField+40800,x
         sta   ForegPeaField+40800,x
         ldal  BackgPeaField+36480,x
         sta   ForegPeaField+36480,x
         iny
         iny
         iny
         nop

FogT16   ldx   ForegPeaField+33360,y
         lda   FogTable,x
         sta   ForegPeaField+33360,y
         ldx   ForegPeaField+29520,y
         lda   FogTable,x
         sta   ForegPeaField+29520,y
         ldx   ForegPeaField+20640,y
         lda   FogTable,x
         sta   ForegPeaField+20640,y
         tyx
         ldal  BackgPeaField+24720,x
         sta   ForegPeaField+24720,x
         ldal  BackgPeaField+960,x
         sta   ForegPeaField+960,x
         iny
         iny
         iny
         nop

FogT17   ldx   ForegPeaField+20880,y
         lda   FogTable,x
         sta   ForegPeaField+20880,y
         ldx   ForegPeaField+20400,y
         lda   FogTable,x
         sta   ForegPeaField+20400,y
         ldx   ForegPeaField+18000,y
         lda   FogTable,x
         sta   ForegPeaField+18000,y
         ldx   ForegPeaField+12240,y
         lda   FogTable,x
         sta   ForegPeaField+12240,y
         tyx
         ldal  BackgPeaField+36720,x
         sta   ForegPeaField+36720,x
         ldal  BackgPeaField+24960,x
         sta   ForegPeaField+24960,x
         ldal  BackgPeaField+1200,x
         sta   ForegPeaField+1200,x
         iny
         iny
         iny
         nop

FogT18   ldx   ForegPeaField+21120,y
         lda   FogTable,x
         sta   ForegPeaField+21120,y
         tyx
         ldal  BackgPeaField+40560,x
         sta   ForegPeaField+40560,x
         ldal  BackgPeaField+36960,x
         sta   ForegPeaField+36960,x
         ldal  BackgPeaField+25200,x
         sta   ForegPeaField+25200,x
         ldal  BackgPeaField+1440,x
         sta   ForegPeaField+1440,x
         iny
         iny
         iny
         nop

FogT19   ldx   ForegPeaField+21600,y
         lda   FogTable,x
         sta   ForegPeaField+21600,y
         ldx   ForegPeaField+21360,y
         lda   FogTable,x
         sta   ForegPeaField+21360,y
         ldx   ForegPeaField+20160,y
         lda   FogTable,x
         sta   ForegPeaField+20160,y
         ldx   ForegPeaField+12000,y
         lda   FogTable,x
         sta   ForegPeaField+12000,y
         tyx
         ldal  BackgPeaField+37200,x
         sta   ForegPeaField+37200,x
         ldal  BackgPeaField+25440,x
         sta   ForegPeaField+25440,x
         ldal  BackgPeaField+1680,x
         sta   ForegPeaField+1680,x
         iny
         iny
         iny
         nop

FogT20   ldx   ForegPeaField+42480,y
         lda   FogTable,x
         sta   ForegPeaField+42480,y
         ldx   ForegPeaField+33600,y
         lda   FogTable,x
         sta   ForegPeaField+33600,y
         ldx   ForegPeaField+22080,y
         lda   FogTable,x
         sta   ForegPeaField+22080,y
         ldx   ForegPeaField+21840,y
         lda   FogTable,x
         sta   ForegPeaField+21840,y
         tyx
         ldal  BackgPeaField+40320,x
         sta   ForegPeaField+40320,x
         ldal  BackgPeaField+37440,x
         sta   ForegPeaField+37440,x
         ldal  BackgPeaField+29040,x
         sta   ForegPeaField+29040,x
         ldal  BackgPeaField+25680,x
         sta   ForegPeaField+25680,x
         ldal  BackgPeaField+5280,x
         sta   ForegPeaField+5280,x
         iny
         iny
         iny
         nop

FogT21   ldx   ForegPeaField+22320,y
         lda   FogTable,x
         sta   ForegPeaField+22320,y
         ldx   ForegPeaField+19920,y
         lda   FogTable,x
         sta   ForegPeaField+19920,y
         ldx   ForegPeaField+18240,y
         lda   FogTable,x
         sta   ForegPeaField+18240,y
         tyx
         ldal  BackgPeaField+40080,x
         sta   ForegPeaField+40080,x
         ldal  BackgPeaField+37920,x
         sta   ForegPeaField+37920,x
         ldal  BackgPeaField+37680,x
         sta   ForegPeaField+37680,x
         ldal  BackgPeaField+29280,x
         sta   ForegPeaField+29280,x
         ldal  BackgPeaField+25920,x
         sta   ForegPeaField+25920,x
         ldal  BackgPeaField+1920,x
         sta   ForegPeaField+1920,x
         iny
         iny
         iny
         nop

FogT22   ldx   ForegPeaField+22560,y
         lda   FogTable,x
         sta   ForegPeaField+22560,y
         ldx   ForegPeaField+18480,y
         lda   FogTable,x
         sta   ForegPeaField+18480,y
         ldx   ForegPeaField+240,y
         lda   FogTable,x
         sta   ForegPeaField+240,y
         tyx
         ldal  BackgPeaField+39840,x
         sta   ForegPeaField+39840,x
         ldal  BackgPeaField+38160,x
         sta   ForegPeaField+38160,x
         ldal  BackgPeaField+29520,x
         sta   ForegPeaField+29520,x
         ldal  BackgPeaField+26160,x
         sta   ForegPeaField+26160,x
         ldal  BackgPeaField+5040,x
         sta   ForegPeaField+5040,x
         iny
         iny
         iny
         nop

FogT23   ldx   ForegPeaField+29040,y
         lda   FogTable,x
         sta   ForegPeaField+29040,y
         ldx   ForegPeaField+22800,y
         lda   FogTable,x
         sta   ForegPeaField+22800,y
         ldx   ForegPeaField+18720,y
         lda   FogTable,x
         sta   ForegPeaField+18720,y
         ldx   ForegPeaField+9360,y
         lda   FogTable,x
         sta   ForegPeaField+9360,y
         tyx
         ldal  BackgPeaField+39600,x
         sta   ForegPeaField+39600,x
         ldal  BackgPeaField+38400,x
         sta   ForegPeaField+38400,x
         ldal  BackgPeaField+29760,x
         sta   ForegPeaField+29760,x
         ldal  BackgPeaField+26640,x
         sta   ForegPeaField+26640,x
         ldal  BackgPeaField+26400,x
         sta   ForegPeaField+26400,x
         ldal  BackgPeaField+12000,x
         sta   ForegPeaField+12000,x
         ldal  BackgPeaField+2400,x
         sta   ForegPeaField+2400,x
         ldal  BackgPeaField+2160,x
         sta   ForegPeaField+2160,x
         iny
         iny
         iny
         nop

FogT24   ldx   ForegPeaField+19200,y
         lda   FogTable,x
         sta   ForegPeaField+19200,y
         ldx   ForegPeaField+18960,y
         lda   FogTable,x
         sta   ForegPeaField+18960,y
         ldx   ForegPeaField+9840,y
         lda   FogTable,x
         sta   ForegPeaField+9840,y
         ldx   ForegPeaField+9600,y
         lda   FogTable,x
         sta   ForegPeaField+9600,y
         ldx   ForegPeaField+9120,y
         lda   FogTable,x
         sta   ForegPeaField+9120,y
         ldx   ForegPeaField+480,y
         lda   FogTable,x
         sta   ForegPeaField+480,y
         tyx
         ldal  BackgPeaField+39360,x
         sta   ForegPeaField+39360,x
         ldal  BackgPeaField+38880,x
         sta   ForegPeaField+38880,x
         ldal  BackgPeaField+38640,x
         sta   ForegPeaField+38640,x
         ldal  BackgPeaField+30000,x
         sta   ForegPeaField+30000,x
         ldal  BackgPeaField+26880,x
         sta   ForegPeaField+26880,x
         ldal  BackgPeaField+2880,x
         sta   ForegPeaField+2880,x
         ldal  BackgPeaField+2640,x
         sta   ForegPeaField+2640,x
         iny
         iny
         iny
         nop

FogT25   ldx   ForegPeaField+23040,y
         lda   FogTable,x
         sta   ForegPeaField+23040,y
         ldx   ForegPeaField+19680,y
         lda   FogTable,x
         sta   ForegPeaField+19680,y
         ldx   ForegPeaField+19440,y
         lda   FogTable,x
         sta   ForegPeaField+19440,y
         ldx   ForegPeaField+10080,y
         lda   FogTable,x
         sta   ForegPeaField+10080,y
         ldx   ForegPeaField+8880,y
         lda   FogTable,x
         sta   ForegPeaField+8880,y
         tyx
         ldal  BackgPeaField+27360,x
         sta   ForegPeaField+27360,x
         ldal  BackgPeaField+27120,x
         sta   ForegPeaField+27120,x
         ldal  BackgPeaField+12240,x
         sta   ForegPeaField+12240,x
         ldal  BackgPeaField+4800,x
         sta   ForegPeaField+4800,x
         ldal  BackgPeaField+3120,x
         sta   ForegPeaField+3120,x
         iny
         iny
         iny
         nop

FogT26   ldx   ForegPeaField+42240,y
         lda   FogTable,x
         sta   ForegPeaField+42240,y
         ldx   ForegPeaField+42000,y
         lda   FogTable,x
         sta   ForegPeaField+42000,y
         ldx   ForegPeaField+33840,y
         lda   FogTable,x
         sta   ForegPeaField+33840,y
         ldx   ForegPeaField+10320,y
         lda   FogTable,x
         sta   ForegPeaField+10320,y
         ldx   ForegPeaField+8640,y
         lda   FogTable,x
         sta   ForegPeaField+8640,y
         ldx   ForegPeaField+8400,y
         lda   FogTable,x
         sta   ForegPeaField+8400,y
         ldx   ForegPeaField+720,y
         lda   FogTable,x
         sta   ForegPeaField+720,y
         tyx
         ldal  BackgPeaField+39120,x
         sta   ForegPeaField+39120,x
         ldal  BackgPeaField+30240,x
         sta   ForegPeaField+30240,x
         ldal  BackgPeaField+27600,x
         sta   ForegPeaField+27600,x
         ldal  BackgPeaField+12480,x
         sta   ForegPeaField+12480,x
         ldal  BackgPeaField+3360,x
         sta   ForegPeaField+3360,x
         iny
         iny
         iny
         nop

FogT27   ldx   ForegPeaField+10560,y
         lda   FogTable,x
         sta   ForegPeaField+10560,y
         ldx   ForegPeaField+960,y
         lda   FogTable,x
         sta   ForegPeaField+960,y
         tyx
         ldal  BackgPeaField+30480,x
         sta   ForegPeaField+30480,x
         ldal  BackgPeaField+29040,x
         sta   ForegPeaField+29040,x
         ldal  BackgPeaField+27840,x
         sta   ForegPeaField+27840,x
         ldal  BackgPeaField+4560,x
         sta   ForegPeaField+4560,x
         ldal  BackgPeaField+3840,x
         sta   ForegPeaField+3840,x
         ldal  BackgPeaField+3600,x
         sta   ForegPeaField+3600,x
         iny
         iny
         iny
         nop

FogT28   ldx   ForegPeaField+34080,y
         lda   FogTable,x
         sta   ForegPeaField+34080,y
         ldx   ForegPeaField+8160,y
         lda   FogTable,x
         sta   ForegPeaField+8160,y
         ldx   ForegPeaField+1440,y
         lda   FogTable,x
         sta   ForegPeaField+1440,y
         ldx   ForegPeaField+1200,y
         lda   FogTable,x
         sta   ForegPeaField+1200,y
         tyx
         ldal  BackgPeaField+30720,x
         sta   ForegPeaField+30720,x
         ldal  BackgPeaField+28320,x
         sta   ForegPeaField+28320,x
         ldal  BackgPeaField+28080,x
         sta   ForegPeaField+28080,x
         ldal  BackgPeaField+15840,x
         sta   ForegPeaField+15840,x
         ldal  BackgPeaField+4320,x
         sta   ForegPeaField+4320,x
         ldal  BackgPeaField+4080,x
         sta   ForegPeaField+4080,x
         iny
         iny
         iny
         nop

FogT29   ldx   ForegPeaField+12480,y
         lda   FogTable,x
         sta   ForegPeaField+12480,y
         ldx   ForegPeaField+11040,y
         lda   FogTable,x
         sta   ForegPeaField+11040,y
         ldx   ForegPeaField+10800,y
         lda   FogTable,x
         sta   ForegPeaField+10800,y
         ldx   ForegPeaField+1920,y
         lda   FogTable,x
         sta   ForegPeaField+1920,y
         ldx   ForegPeaField+1680,y
         lda   FogTable,x
         sta   ForegPeaField+1680,y
         tyx
         ldal  BackgPeaField+28560,x
         sta   ForegPeaField+28560,x
         ldal  BackgPeaField+23040,x
         sta   ForegPeaField+23040,x
         ldal  BackgPeaField+15600,x
         sta   ForegPeaField+15600,x
         iny
         iny
         iny
         nop

FogT30   ldx   ForegPeaField+2160,y
         lda   FogTable,x
         sta   ForegPeaField+2160,y
         tyx
         ldal  BackgPeaField+28800,x
         sta   ForegPeaField+28800,x
         ldal  BackgPeaField+15360,x
         sta   ForegPeaField+15360,x
         iny
         iny
         iny
         nop

FogT31   ldx   ForegPeaField+41760,y
         lda   FogTable,x
         sta   ForegPeaField+41760,y
         ldx   ForegPeaField+34320,y
         lda   FogTable,x
         sta   ForegPeaField+34320,y
         ldx   ForegPeaField+2400,y
         lda   FogTable,x
         sta   ForegPeaField+2400,y
         tyx
         ldal  BackgPeaField+46080,x
         sta   ForegPeaField+46080,x
         ldal  BackgPeaField+22800,x
         sta   ForegPeaField+22800,x
         ldal  BackgPeaField+16080,x
         sta   ForegPeaField+16080,x
         iny
         iny
         iny
         nop

FogT32   ldx   ForegPeaField+12240,y
         lda   FogTable,x
         sta   ForegPeaField+12240,y
         ldx   ForegPeaField+2640,y
         lda   FogTable,x
         sta   ForegPeaField+2640,y
         tyx
         ldal  BackgPeaField+22560,x
         sta   ForegPeaField+22560,x
         ldal  BackgPeaField+16320,x
         sta   ForegPeaField+16320,x
         iny
         iny
         iny
         nop

FogT33   ldx   ForegPeaField+34560,y
         lda   FogTable,x
         sta   ForegPeaField+34560,y
         ldx   ForegPeaField+30720,y
         lda   FogTable,x
         sta   ForegPeaField+30720,y
         ldx   ForegPeaField+12000,y
         lda   FogTable,x
         sta   ForegPeaField+12000,y
         tyx
         ldal  BackgPeaField+45840,x
         sta   ForegPeaField+45840,x
         ldal  BackgPeaField+16800,x
         sta   ForegPeaField+16800,x
         ldal  BackgPeaField+16560,x
         sta   ForegPeaField+16560,x
         ldal  BackgPeaField+11040,x
         sta   ForegPeaField+11040,x
         iny
         iny
         iny
         nop

FogT34   ldx   ForegPeaField+41520,y
         lda   FogTable,x
         sta   ForegPeaField+41520,y
         ldx   ForegPeaField+24960,y
         lda   FogTable,x
         sta   ForegPeaField+24960,y
         ldx   ForegPeaField+24720,y
         lda   FogTable,x
         sta   ForegPeaField+24720,y
         ldx   ForegPeaField+24480,y
         lda   FogTable,x
         sta   ForegPeaField+24480,y
         ldx   ForegPeaField+15360,y
         lda   FogTable,x
         sta   ForegPeaField+15360,y
         ldx   ForegPeaField+11760,y
         lda   FogTable,x
         sta   ForegPeaField+11760,y
         ldx   ForegPeaField+2880,y
         lda   FogTable,x
         sta   ForegPeaField+2880,y
         tyx
         ldal  BackgPeaField+45600,x
         sta   ForegPeaField+45600,x
         ldal  BackgPeaField+22320,x
         sta   ForegPeaField+22320,x
         ldal  BackgPeaField+17040,x
         sta   ForegPeaField+17040,x
         iny
         iny
         iny
         nop

FogT35   ldx   ForegPeaField+34800,y
         lda   FogTable,x
         sta   ForegPeaField+34800,y
         ldx   ForegPeaField+30480,y
         lda   FogTable,x
         sta   ForegPeaField+30480,y
         ldx   ForegPeaField+24240,y
         lda   FogTable,x
         sta   ForegPeaField+24240,y
         ldx   ForegPeaField+11520,y
         lda   FogTable,x
         sta   ForegPeaField+11520,y
         tyx
         ldal  BackgPeaField+45360,x
         sta   ForegPeaField+45360,x
         ldal  BackgPeaField+22080,x
         sta   ForegPeaField+22080,x
         ldal  BackgPeaField+17280,x
         sta   ForegPeaField+17280,x
         iny
         iny
         iny
         nop

FogT36   ldx   ForegPeaField+41280,y
         lda   FogTable,x
         sta   ForegPeaField+41280,y
         ldx   ForegPeaField+35040,y
         lda   FogTable,x
         sta   ForegPeaField+35040,y
         ldx   ForegPeaField+25200,y
         lda   FogTable,x
         sta   ForegPeaField+25200,y
         ldx   ForegPeaField+24000,y
         lda   FogTable,x
         sta   ForegPeaField+24000,y
         ldx   ForegPeaField+23760,y
         lda   FogTable,x
         sta   ForegPeaField+23760,y
         ldx   ForegPeaField+15600,y
         lda   FogTable,x
         sta   ForegPeaField+15600,y
         ldx   ForegPeaField+11280,y
         lda   FogTable,x
         sta   ForegPeaField+11280,y
         tyx
         ldal  BackgPeaField+45120,x
         sta   ForegPeaField+45120,x
         ldal  BackgPeaField+21840,x
         sta   ForegPeaField+21840,x
         ldal  BackgPeaField+10800,x
         sta   ForegPeaField+10800,x
         iny
         iny
         iny
         nop

FogT37   ldx   ForegPeaField+35280,y
         lda   FogTable,x
         sta   ForegPeaField+35280,y
         ldx   ForegPeaField+23520,y
         lda   FogTable,x
         sta   ForegPeaField+23520,y
         ldx   ForegPeaField+15840,y
         lda   FogTable,x
         sta   ForegPeaField+15840,y
         ldx   ForegPeaField+11040,y
         lda   FogTable,x
         sta   ForegPeaField+11040,y
         ldx   ForegPeaField+7920,y
         lda   FogTable,x
         sta   ForegPeaField+7920,y
         tyx
         ldal  BackgPeaField+17520,x
         sta   ForegPeaField+17520,x
         iny
         iny
         iny
         nop

FogT38   ldx   ForegPeaField+35520,y
         lda   FogTable,x
         sta   ForegPeaField+35520,y
         ldx   ForegPeaField+30240,y
         lda   FogTable,x
         sta   ForegPeaField+30240,y
         ldx   ForegPeaField+23280,y
         lda   FogTable,x
         sta   ForegPeaField+23280,y
         ldx   ForegPeaField+3120,y
         lda   FogTable,x
         sta   ForegPeaField+3120,y
         tyx
         ldal  BackgPeaField+44880,x
         sta   ForegPeaField+44880,x
         ldal  BackgPeaField+21600,x
         sta   ForegPeaField+21600,x
         iny
         iny
         iny
         nop

FogT39   ldx   ForegPeaField+36000,y
         lda   FogTable,x
         sta   ForegPeaField+36000,y
         ldx   ForegPeaField+35760,y
         lda   FogTable,x
         sta   ForegPeaField+35760,y
         ldx   ForegPeaField+23040,y
         lda   FogTable,x
         sta   ForegPeaField+23040,y
         ldx   ForegPeaField+10800,y
         lda   FogTable,x
         sta   ForegPeaField+10800,y
         ldx   ForegPeaField+7680,y
         lda   FogTable,x
         sta   ForegPeaField+7680,y
         tyx
         ldal  BackgPeaField+44640,x
         sta   ForegPeaField+44640,x
         iny
         iny
         iny
         nop

FogT40   ldx   ForegPeaField+41040,y
         lda   FogTable,x
         sta   ForegPeaField+41040,y
         ldx   ForegPeaField+36240,y
         lda   FogTable,x
         sta   ForegPeaField+36240,y
         ldx   ForegPeaField+30000,y
         lda   FogTable,x
         sta   ForegPeaField+30000,y
         ldx   ForegPeaField+22800,y
         lda   FogTable,x
         sta   ForegPeaField+22800,y
         ldx   ForegPeaField+3360,y
         lda   FogTable,x
         sta   ForegPeaField+3360,y
         tyx
         ldal  BackgPeaField+32880,x
         sta   ForegPeaField+32880,x
         ldal  BackgPeaField+32640,x
         sta   ForegPeaField+32640,x
         ldal  BackgPeaField+25200,x
         sta   ForegPeaField+25200,x
         iny
         iny
         iny
         nop

FogT41   ldx   ForegPeaField+46080,y
         lda   FogTable,x
         sta   ForegPeaField+46080,y
         ldx   ForegPeaField+36480,y
         lda   FogTable,x
         sta   ForegPeaField+36480,y
         ldx   ForegPeaField+32640,y
         lda   FogTable,x
         sta   ForegPeaField+32640,y
         ldx   ForegPeaField+22560,y
         lda   FogTable,x
         sta   ForegPeaField+22560,y
         ldx   ForegPeaField+7440,y
         lda   FogTable,x
         sta   ForegPeaField+7440,y
         tyx
         ldal  BackgPeaField+33360,x
         sta   ForegPeaField+33360,x
         ldal  BackgPeaField+33120,x
         sta   ForegPeaField+33120,x
         iny
         iny
         iny
         nop

FogT42   ldx   ForegPeaField+32880,y
         lda   FogTable,x
         sta   ForegPeaField+32880,y
         ldx   ForegPeaField+22320,y
         lda   FogTable,x
         sta   ForegPeaField+22320,y
         ldx   ForegPeaField+7200,y
         lda   FogTable,x
         sta   ForegPeaField+7200,y
         ldx   ForegPeaField+6960,y
         lda   FogTable,x
         sta   ForegPeaField+6960,y
         tyx
         ldal  BackgPeaField+44400,x
         sta   ForegPeaField+44400,x
         ldal  BackgPeaField+33600,x
         sta   ForegPeaField+33600,x
         ldal  BackgPeaField+11520,x
         sta   ForegPeaField+11520,x
         ldal  BackgPeaField+3360,x
         sta   ForegPeaField+3360,x
         iny
         iny
         iny
         nop

FogT43   ldx   ForegPeaField+45840,y
         lda   FogTable,x
         sta   ForegPeaField+45840,y
         ldx   ForegPeaField+36720,y
         lda   FogTable,x
         sta   ForegPeaField+36720,y
         ldx   ForegPeaField+22080,y
         lda   FogTable,x
         sta   ForegPeaField+22080,y
         ldx   ForegPeaField+21600,y
         lda   FogTable,x
         sta   ForegPeaField+21600,y
         ldx   ForegPeaField+17520,y
         lda   FogTable,x
         sta   ForegPeaField+17520,y
         ldx   ForegPeaField+6720,y
         lda   FogTable,x
         sta   ForegPeaField+6720,y
         tyx
         ldal  BackgPeaField+33840,x
         sta   ForegPeaField+33840,x
         ldal  BackgPeaField+24960,x
         sta   ForegPeaField+24960,x
         ldal  BackgPeaField+15840,x
         sta   ForegPeaField+15840,x
         ldal  BackgPeaField+11280,x
         sta   ForegPeaField+11280,x
         ldal  BackgPeaField+3120,x
         sta   ForegPeaField+3120,x
         iny
         iny
         iny
         nop

FogT44   ldx   ForegPeaField+21840,y
         lda   FogTable,x
         sta   ForegPeaField+21840,y
         ldx   ForegPeaField+6480,y
         lda   FogTable,x
         sta   ForegPeaField+6480,y
         tyx
         ldal  BackgPeaField+41040,x
         sta   ForegPeaField+41040,x
         ldal  BackgPeaField+34080,x
         sta   ForegPeaField+34080,x
         iny
         iny
         iny
         nop

FogT45   ldx   ForegPeaField+36960,y
         lda   FogTable,x
         sta   ForegPeaField+36960,y
         ldx   ForegPeaField+11520,y
         lda   FogTable,x
         sta   ForegPeaField+11520,y
         ldx   ForegPeaField+6240,y
         lda   FogTable,x
         sta   ForegPeaField+6240,y
         ldx   ForegPeaField+6000,y
         lda   FogTable,x
         sta   ForegPeaField+6000,y
         tyx
         ldal  BackgPeaField+32880,x
         sta   ForegPeaField+32880,x
         ldal  BackgPeaField+24720,x
         sta   ForegPeaField+24720,x
         ldal  BackgPeaField+15600,x
         sta   ForegPeaField+15600,x
         ldal  BackgPeaField+11040,x
         sta   ForegPeaField+11040,x
         ldal  BackgPeaField+10800,x
         sta   ForegPeaField+10800,x
         ldal  BackgPeaField+2880,x
         sta   ForegPeaField+2880,x
         iny
         iny
         iny
         nop

FogT46   ldx   ForegPeaField+45600,y
         lda   FogTable,x
         sta   ForegPeaField+45600,y
         ldx   ForegPeaField+17280,y
         lda   FogTable,x
         sta   ForegPeaField+17280,y
         ldx   ForegPeaField+5760,y
         lda   FogTable,x
         sta   ForegPeaField+5760,y
         tyx
         ldal  BackgPeaField+41280,x
         sta   ForegPeaField+41280,x
         ldal  BackgPeaField+34320,x
         sta   ForegPeaField+34320,x
         ldal  BackgPeaField+15360,x
         sta   ForegPeaField+15360,x
         ldal  BackgPeaField+10560,x
         sta   ForegPeaField+10560,x
         ldal  BackgPeaField+10320,x
         sta   ForegPeaField+10320,x
         ldal  BackgPeaField+2640,x
         sta   ForegPeaField+2640,x
         iny
         iny
         iny
         nop

FogT47   ldx   ForegPeaField+11280,y
         lda   FogTable,x
         sta   ForegPeaField+11280,y
         ldx   ForegPeaField+5520,y
         lda   FogTable,x
         sta   ForegPeaField+5520,y
         ldx   ForegPeaField+5280,y
         lda   FogTable,x
         sta   ForegPeaField+5280,y
         tyx
         ldal  BackgPeaField+41520,x
         sta   ForegPeaField+41520,x
         ldal  BackgPeaField+30000,x
         sta   ForegPeaField+30000,x
         ldal  BackgPeaField+15120,x
         sta   ForegPeaField+15120,x
         iny
         iny
         iny
         nop

FogT48   ldx   ForegPeaField+44400,y
         lda   FogTable,x
         sta   ForegPeaField+44400,y
         ldx   ForegPeaField+5040,y
         lda   FogTable,x
         sta   ForegPeaField+5040,y
         tyx
         ldal  BackgPeaField+14880,x
         sta   ForegPeaField+14880,x
         ldal  BackgPeaField+10080,x
         sta   ForegPeaField+10080,x
         ldal  BackgPeaField+2400,x
         sta   ForegPeaField+2400,x
         iny
         iny
         iny
         nop

FogT49   ldx   ForegPeaField+32880,y
         lda   FogTable,x
         sta   ForegPeaField+32880,y
         ldx   ForegPeaField+4800,y
         lda   FogTable,x
         sta   ForegPeaField+4800,y
         tyx
         ldal  BackgPeaField+34560,x
         sta   ForegPeaField+34560,x
         ldal  BackgPeaField+24480,x
         sta   ForegPeaField+24480,x
         ldal  BackgPeaField+14640,x
         sta   ForegPeaField+14640,x
         ldal  BackgPeaField+9840,x
         sta   ForegPeaField+9840,x
         ldal  BackgPeaField+2160,x
         sta   ForegPeaField+2160,x
         iny
         iny
         iny
         nop

FogT50   ldx   ForegPeaField+44640,y
         lda   FogTable,x
         sta   ForegPeaField+44640,y
         ldx   ForegPeaField+37200,y
         lda   FogTable,x
         sta   ForegPeaField+37200,y
         ldx   ForegPeaField+4560,y
         lda   FogTable,x
         sta   ForegPeaField+4560,y
         tyx
         ldal  BackgPeaField+45600,x
         sta   ForegPeaField+45600,x
         ldal  BackgPeaField+41760,x
         sta   ForegPeaField+41760,x
         ldal  BackgPeaField+34800,x
         sta   ForegPeaField+34800,x
         ldal  BackgPeaField+1920,x
         sta   ForegPeaField+1920,x
         iny
         iny
         iny
         nop

FogT51   ldx   ForegPeaField+44880,y
         lda   FogTable,x
         sta   ForegPeaField+44880,y
         ldx   ForegPeaField+33120,y
         lda   FogTable,x
         sta   ForegPeaField+33120,y
         ldx   ForegPeaField+17040,y
         lda   FogTable,x
         sta   ForegPeaField+17040,y
         ldx   ForegPeaField+4320,y
         lda   FogTable,x
         sta   ForegPeaField+4320,y
         tyx
         ldal  BackgPeaField+35040,x
         sta   ForegPeaField+35040,x
         ldal  BackgPeaField+24240,x
         sta   ForegPeaField+24240,x
         ldal  BackgPeaField+14400,x
         sta   ForegPeaField+14400,x
         ldal  BackgPeaField+9600,x
         sta   ForegPeaField+9600,x
         iny
         iny
         iny
         nop

FogT52   ldx   ForegPeaField+4080,y
         lda   FogTable,x
         sta   ForegPeaField+4080,y
         tyx
         ldal  BackgPeaField+35280,x
         sta   ForegPeaField+35280,x
         ldal  BackgPeaField+11280,x
         sta   ForegPeaField+11280,x
         iny
         iny
         iny
         nop

FogT53   ldx   ForegPeaField+45120,y
         lda   FogTable,x
         sta   ForegPeaField+45120,y
         ldx   ForegPeaField+33360,y
         lda   FogTable,x
         sta   ForegPeaField+33360,y
         ldx   ForegPeaField+26880,y
         lda   FogTable,x
         sta   ForegPeaField+26880,y
         tyx
         ldal  BackgPeaField+35760,x
         sta   ForegPeaField+35760,x
         ldal  BackgPeaField+35520,x
         sta   ForegPeaField+35520,x
         iny
         iny
         iny
         nop

FogT54   ldx   ForegPeaField+33600,y
         lda   FogTable,x
         sta   ForegPeaField+33600,y
         ldx   ForegPeaField+26640,y
         lda   FogTable,x
         sta   ForegPeaField+26640,y
         ldx   ForegPeaField+3840,y
         lda   FogTable,x
         sta   ForegPeaField+3840,y
         ldx   ForegPeaField+1920,y
         lda   FogTable,x
         sta   ForegPeaField+1920,y
         tyx
         ldal  BackgPeaField+42000,x
         sta   ForegPeaField+42000,x
         ldal  BackgPeaField+37200,x
         sta   ForegPeaField+37200,x
         ldal  BackgPeaField+36240,x
         sta   ForegPeaField+36240,x
         ldal  BackgPeaField+36000,x
         sta   ForegPeaField+36000,x
         ldal  BackgPeaField+14160,x
         sta   ForegPeaField+14160,x
         ldal  BackgPeaField+11520,x
         sta   ForegPeaField+11520,x
         iny
         iny
         iny
         nop

FogT55   ldx   ForegPeaField+45600,y
         lda   FogTable,x
         sta   ForegPeaField+45600,y
         ldx   ForegPeaField+33840,y
         lda   FogTable,x
         sta   ForegPeaField+33840,y
         ldx   ForegPeaField+26400,y
         lda   FogTable,x
         sta   ForegPeaField+26400,y
         tyx
         ldal  BackgPeaField+36720,x
         sta   ForegPeaField+36720,x
         ldal  BackgPeaField+36480,x
         sta   ForegPeaField+36480,x
         ldal  BackgPeaField+24000,x
         sta   ForegPeaField+24000,x
         ldal  BackgPeaField+19200,x
         sta   ForegPeaField+19200,x
         ldal  BackgPeaField+17040,x
         sta   ForegPeaField+17040,x
         ldal  BackgPeaField+12000,x
         sta   ForegPeaField+12000,x
         ldal  BackgPeaField+11760,x
         sta   ForegPeaField+11760,x
         iny
         iny
         iny
         nop

FogT56   ldx   ForegPeaField+45360,y
         lda   FogTable,x
         sta   ForegPeaField+45360,y
         ldx   ForegPeaField+27120,y
         lda   FogTable,x
         sta   ForegPeaField+27120,y
         ldx   ForegPeaField+9600,y
         lda   FogTable,x
         sta   ForegPeaField+9600,y
         ldx   ForegPeaField+2160,y
         lda   FogTable,x
         sta   ForegPeaField+2160,y
         tyx
         ldal  BackgPeaField+36960,x
         sta   ForegPeaField+36960,x
         ldal  BackgPeaField+30240,x
         sta   ForegPeaField+30240,x
         ldal  BackgPeaField+13920,x
         sta   ForegPeaField+13920,x
         ldal  BackgPeaField+12240,x
         sta   ForegPeaField+12240,x
         iny
         iny
         iny
         nop

FogT57   ldx   ForegPeaField+34080,y
         lda   FogTable,x
         sta   ForegPeaField+34080,y
         ldx   ForegPeaField+26160,y
         lda   FogTable,x
         sta   ForegPeaField+26160,y
         ldx   ForegPeaField+9840,y
         lda   FogTable,x
         sta   ForegPeaField+9840,y
         tyx
         ldal  BackgPeaField+18960,x
         sta   ForegPeaField+18960,x
         ldal  BackgPeaField+12480,x
         sta   ForegPeaField+12480,x
         iny
         iny
         iny
         nop

FogT58   ldx   ForegPeaField+34320,y
         lda   FogTable,x
         sta   ForegPeaField+34320,y
         ldx   ForegPeaField+25920,y
         lda   FogTable,x
         sta   ForegPeaField+25920,y
         ldx   ForegPeaField+24000,y
         lda   FogTable,x
         sta   ForegPeaField+24000,y
         ldx   ForegPeaField+10080,y
         lda   FogTable,x
         sta   ForegPeaField+10080,y
         tyx
         ldal  BackgPeaField+42240,x
         sta   ForegPeaField+42240,x
         ldal  BackgPeaField+12720,x
         sta   ForegPeaField+12720,x
         iny
         iny
         iny
         nop

FogT59   ldx   ForegPeaField+34560,y
         lda   FogTable,x
         sta   ForegPeaField+34560,y
         ldx   ForegPeaField+10320,y
         lda   FogTable,x
         sta   ForegPeaField+10320,y
         tyx
         ldal  BackgPeaField+19440,x
         sta   ForegPeaField+19440,x
         ldal  BackgPeaField+17280,x
         sta   ForegPeaField+17280,x
         ldal  BackgPeaField+13200,x
         sta   ForegPeaField+13200,x
         ldal  BackgPeaField+12960,x
         sta   ForegPeaField+12960,x
         iny
         iny
         iny
         nop

FogT60   ldx   ForegPeaField+34800,y
         lda   FogTable,x
         sta   ForegPeaField+34800,y
         ldx   ForegPeaField+27360,y
         lda   FogTable,x
         sta   ForegPeaField+27360,y
         ldx   ForegPeaField+10560,y
         lda   FogTable,x
         sta   ForegPeaField+10560,y
         ldx   ForegPeaField+3600,y
         lda   FogTable,x
         sta   ForegPeaField+3600,y
         tyx
         ldal  BackgPeaField+30480,x
         sta   ForegPeaField+30480,x
         ldal  BackgPeaField+13440,x
         sta   ForegPeaField+13440,x
         iny
         iny
         iny
         nop

FogT61   ldx   ForegPeaField+35040,y
         lda   FogTable,x
         sta   ForegPeaField+35040,y
         ldx   ForegPeaField+24240,y
         lda   FogTable,x
         sta   ForegPeaField+24240,y
         ldx   ForegPeaField+11040,y
         lda   FogTable,x
         sta   ForegPeaField+11040,y
         ldx   ForegPeaField+10800,y
         lda   FogTable,x
         sta   ForegPeaField+10800,y
         ldx   ForegPeaField+3360,y
         lda   FogTable,x
         sta   ForegPeaField+3360,y
         tyx
         ldal  BackgPeaField+42480,x
         sta   ForegPeaField+42480,x
         ldal  BackgPeaField+17520,x
         sta   ForegPeaField+17520,x
         ldal  BackgPeaField+13680,x
         sta   ForegPeaField+13680,x
         ldal  BackgPeaField+2160,x
         sta   ForegPeaField+2160,x
         iny
         iny
         iny
         nop

FogT62   ldx   ForegPeaField+35280,y
         lda   FogTable,x
         sta   ForegPeaField+35280,y
         ldx   ForegPeaField+24480,y
         lda   FogTable,x
         sta   ForegPeaField+24480,y
         ldx   ForegPeaField+11280,y
         lda   FogTable,x
         sta   ForegPeaField+11280,y
         tyx
         ldal  BackgPeaField+18720,x
         sta   ForegPeaField+18720,x
         ldal  BackgPeaField+17760,x
         sta   ForegPeaField+17760,x
         ldal  BackgPeaField+1920,x
         sta   ForegPeaField+1920,x
         iny
         iny
         iny
         nop

FogT63   ldx   ForegPeaField+35520,y
         lda   FogTable,x
         sta   ForegPeaField+35520,y
         ldx   ForegPeaField+24720,y
         lda   FogTable,x
         sta   ForegPeaField+24720,y
         tyx
         ldal  BackgPeaField+42720,x
         sta   ForegPeaField+42720,x
         ldal  BackgPeaField+30720,x
         sta   ForegPeaField+30720,x
         ldal  BackgPeaField+25920,x
         sta   ForegPeaField+25920,x
         ldal  BackgPeaField+18000,x
         sta   ForegPeaField+18000,x
         iny
         iny
         iny
         nop

FogT64   ldx   ForegPeaField+27600,y
         lda   FogTable,x
         sta   ForegPeaField+27600,y
         ldx   ForegPeaField+25200,y
         lda   FogTable,x
         sta   ForegPeaField+25200,y
         ldx   ForegPeaField+24960,y
         lda   FogTable,x
         sta   ForegPeaField+24960,y
         ldx   ForegPeaField+11520,y
         lda   FogTable,x
         sta   ForegPeaField+11520,y
         ldx   ForegPeaField+1920,y
         lda   FogTable,x
         sta   ForegPeaField+1920,y
         tyx
         ldal  BackgPeaField+30960,x
         sta   ForegPeaField+30960,x
         ldal  BackgPeaField+18480,x
         sta   ForegPeaField+18480,x
         ldal  BackgPeaField+3360,x
         sta   ForegPeaField+3360,x
         iny
         iny
         iny
         nop

FogT65   ldx   ForegPeaField+35760,y
         lda   FogTable,x
         sta   ForegPeaField+35760,y
         ldx   ForegPeaField+25440,y
         lda   FogTable,x
         sta   ForegPeaField+25440,y
         ldx   ForegPeaField+2400,y
         lda   FogTable,x
         sta   ForegPeaField+2400,y
         ldx   ForegPeaField+2160,y
         lda   FogTable,x
         sta   ForegPeaField+2160,y
         tyx
         ldal  BackgPeaField+31200,x
         sta   ForegPeaField+31200,x
         ldal  BackgPeaField+19680,x
         sta   ForegPeaField+19680,x
         ldal  BackgPeaField+18240,x
         sta   ForegPeaField+18240,x
         ldal  BackgPeaField+3600,x
         sta   ForegPeaField+3600,x
         iny
         iny
         iny
         nop

FogT66   ldx   ForegPeaField+39840,y
         lda   FogTable,x
         sta   ForegPeaField+39840,y
         ldx   ForegPeaField+25920,y
         lda   FogTable,x
         sta   ForegPeaField+25920,y
         ldx   ForegPeaField+25680,y
         lda   FogTable,x
         sta   ForegPeaField+25680,y
         ldx   ForegPeaField+2640,y
         lda   FogTable,x
         sta   ForegPeaField+2640,y
         tyx
         ldal  BackgPeaField+6480,x
         sta   ForegPeaField+6480,x
         iny
         iny
         iny
         nop

FogT67   ldx   ForegPeaField+27840,y
         lda   FogTable,x
         sta   ForegPeaField+27840,y
         ldx   ForegPeaField+3600,y
         lda   FogTable,x
         sta   ForegPeaField+3600,y
         ldx   ForegPeaField+2880,y
         lda   FogTable,x
         sta   ForegPeaField+2880,y
         tyx
         ldal  BackgPeaField+42960,x
         sta   ForegPeaField+42960,x
         ldal  BackgPeaField+31440,x
         sta   ForegPeaField+31440,x
         ldal  BackgPeaField+23280,x
         sta   ForegPeaField+23280,x
         ldal  BackgPeaField+6720,x
         sta   ForegPeaField+6720,x
         iny
         iny
         iny
         nop

FogT68   ldx   ForegPeaField+40080,y
         lda   FogTable,x
         sta   ForegPeaField+40080,y
         ldx   ForegPeaField+39600,y
         lda   FogTable,x
         sta   ForegPeaField+39600,y
         ldx   ForegPeaField+39360,y
         lda   FogTable,x
         sta   ForegPeaField+39360,y
         ldx   ForegPeaField+28080,y
         lda   FogTable,x
         sta   ForegPeaField+28080,y
         ldx   ForegPeaField+6480,y
         lda   FogTable,x
         sta   ForegPeaField+6480,y
         tyx
         ldal  BackgPeaField+31680,x
         sta   ForegPeaField+31680,x
         ldal  BackgPeaField+23040,x
         sta   ForegPeaField+23040,x
         iny
         iny
         iny
         nop

FogT69   ldx   ForegPeaField+36000,y
         lda   FogTable,x
         sta   ForegPeaField+36000,y
         ldx   ForegPeaField+11760,y
         lda   FogTable,x
         sta   ForegPeaField+11760,y
         ldx   ForegPeaField+3360,y
         lda   FogTable,x
         sta   ForegPeaField+3360,y
         tyx
         ldal  BackgPeaField+43200,x
         sta   ForegPeaField+43200,x
         ldal  BackgPeaField+31920,x
         sta   ForegPeaField+31920,x
         ldal  BackgPeaField+22800,x
         sta   ForegPeaField+22800,x
         ldal  BackgPeaField+7200,x
         sta   ForegPeaField+7200,x
         ldal  BackgPeaField+6960,x
         sta   ForegPeaField+6960,x
         ldal  BackgPeaField+2880,x
         sta   ForegPeaField+2880,x
         iny
         iny
         iny
         nop

FogT70   ldx   ForegPeaField+40320,y
         lda   FogTable,x
         sta   ForegPeaField+40320,y
         ldx   ForegPeaField+39120,y
         lda   FogTable,x
         sta   ForegPeaField+39120,y
         ldx   ForegPeaField+38880,y
         lda   FogTable,x
         sta   ForegPeaField+38880,y
         ldx   ForegPeaField+28320,y
         lda   FogTable,x
         sta   ForegPeaField+28320,y
         ldx   ForegPeaField+23280,y
         lda   FogTable,x
         sta   ForegPeaField+23280,y
         ldx   ForegPeaField+6720,y
         lda   FogTable,x
         sta   ForegPeaField+6720,y
         ldx   ForegPeaField+3120,y
         lda   FogTable,x
         sta   ForegPeaField+3120,y
         ldx   ForegPeaField+2880,y
         lda   FogTable,x
         sta   ForegPeaField+2880,y
         tyx
         ldal  BackgPeaField+43440,x
         sta   ForegPeaField+43440,x
         ldal  BackgPeaField+32160,x
         sta   ForegPeaField+32160,x
         ldal  BackgPeaField+22560,x
         sta   ForegPeaField+22560,x
         ldal  BackgPeaField+7440,x
         sta   ForegPeaField+7440,x
         iny
         iny
         iny
         nop

FogT71   ldx   ForegPeaField+28560,y
         lda   FogTable,x
         sta   ForegPeaField+28560,y
         ldx   ForegPeaField+6960,y
         lda   FogTable,x
         sta   ForegPeaField+6960,y
         tyx
         ldal  BackgPeaField+43680,x
         sta   ForegPeaField+43680,x
         ldal  BackgPeaField+32400,x
         sta   ForegPeaField+32400,x
         ldal  BackgPeaField+7920,x
         sta   ForegPeaField+7920,x
         ldal  BackgPeaField+7680,x
         sta   ForegPeaField+7680,x
         iny
         iny
         iny
         nop

FogT72   ldx   ForegPeaField+40560,y
         lda   FogTable,x
         sta   ForegPeaField+40560,y
         ldx   ForegPeaField+38640,y
         lda   FogTable,x
         sta   ForegPeaField+38640,y
         tyx
         ldal  BackgPeaField+43920,x
         sta   ForegPeaField+43920,x
         ldal  BackgPeaField+36000,x
         sta   ForegPeaField+36000,x
         ldal  BackgPeaField+32640,x
         sta   ForegPeaField+32640,x
         ldal  BackgPeaField+22320,x
         sta   ForegPeaField+22320,x
         ldal  BackgPeaField+22080,x
         sta   ForegPeaField+22080,x
         ldal  BackgPeaField+19920,x
         sta   ForegPeaField+19920,x
         ldal  BackgPeaField+8400,x
         sta   ForegPeaField+8400,x
         ldal  BackgPeaField+8160,x
         sta   ForegPeaField+8160,x
         iny
         iny
         iny
         nop

FogT73   ldx   ForegPeaField+41040,y
         lda   FogTable,x
         sta   ForegPeaField+41040,y
         ldx   ForegPeaField+40800,y
         lda   FogTable,x
         sta   ForegPeaField+40800,y
         ldx   ForegPeaField+38400,y
         lda   FogTable,x
         sta   ForegPeaField+38400,y
         ldx   ForegPeaField+28800,y
         lda   FogTable,x
         sta   ForegPeaField+28800,y
         ldx   ForegPeaField+7200,y
         lda   FogTable,x
         sta   ForegPeaField+7200,y
         tyx
         ldal  BackgPeaField+44400,x
         sta   ForegPeaField+44400,x
         ldal  BackgPeaField+44160,x
         sta   ForegPeaField+44160,x
         ldal  BackgPeaField+35760,x
         sta   ForegPeaField+35760,x
         ldal  BackgPeaField+33120,x
         sta   ForegPeaField+33120,x
         ldal  BackgPeaField+32880,x
         sta   ForegPeaField+32880,x
         ldal  BackgPeaField+21840,x
         sta   ForegPeaField+21840,x
         ldal  BackgPeaField+8880,x
         sta   ForegPeaField+8880,x
         ldal  BackgPeaField+8640,x
         sta   ForegPeaField+8640,x
         iny
         iny
         iny
         nop

FogT74   tyx
         ldal  BackgPeaField+44640,x
         sta   ForegPeaField+44640,x
         ldal  BackgPeaField+35520,x
         sta   ForegPeaField+35520,x
         ldal  BackgPeaField+33360,x
         sta   ForegPeaField+33360,x
         ldal  BackgPeaField+21600,x
         sta   ForegPeaField+21600,x
         ldal  BackgPeaField+20160,x
         sta   ForegPeaField+20160,x
         ldal  BackgPeaField+11760,x
         sta   ForegPeaField+11760,x
         ldal  BackgPeaField+9120,x
         sta   ForegPeaField+9120,x
         iny
         iny
         iny
         nop

FogT75   ldx   ForegPeaField+41280,y
         lda   FogTable,x
         sta   ForegPeaField+41280,y
         ldx   ForegPeaField+38160,y
         lda   FogTable,x
         sta   ForegPeaField+38160,y
         ldx   ForegPeaField+29040,y
         lda   FogTable,x
         sta   ForegPeaField+29040,y
         ldx   ForegPeaField+7440,y
         lda   FogTable,x
         sta   ForegPeaField+7440,y
         tyx
         ldal  BackgPeaField+44880,x
         sta   ForegPeaField+44880,x
         ldal  BackgPeaField+33840,x
         sta   ForegPeaField+33840,x
         ldal  BackgPeaField+33600,x
         sta   ForegPeaField+33600,x
         ldal  BackgPeaField+23280,x
         sta   ForegPeaField+23280,x
         ldal  BackgPeaField+21360,x
         sta   ForegPeaField+21360,x
         ldal  BackgPeaField+9600,x
         sta   ForegPeaField+9600,x
         ldal  BackgPeaField+9360,x
         sta   ForegPeaField+9360,x
         iny
         iny
         iny
         nop

FogT76   ldx   ForegPeaField+41760,y
         lda   FogTable,x
         sta   ForegPeaField+41760,y
         ldx   ForegPeaField+41520,y
         lda   FogTable,x
         sta   ForegPeaField+41520,y
         ldx   ForegPeaField+37920,y
         lda   FogTable,x
         sta   ForegPeaField+37920,y
         tyx
         ldal  BackgPeaField+45360,x
         sta   ForegPeaField+45360,x
         ldal  BackgPeaField+45120,x
         sta   ForegPeaField+45120,x
         ldal  BackgPeaField+35280,x
         sta   ForegPeaField+35280,x
         ldal  BackgPeaField+34080,x
         sta   ForegPeaField+34080,x
         ldal  BackgPeaField+23520,x
         sta   ForegPeaField+23520,x
         ldal  BackgPeaField+21120,x
         sta   ForegPeaField+21120,x
         ldal  BackgPeaField+11520,x
         sta   ForegPeaField+11520,x
         ldal  BackgPeaField+9840,x
         sta   ForegPeaField+9840,x
         iny
         iny
         iny
         nop

FogT77   ldx   ForegPeaField+42000,y
         lda   FogTable,x
         sta   ForegPeaField+42000,y
         ldx   ForegPeaField+37680,y
         lda   FogTable,x
         sta   ForegPeaField+37680,y
         tyx
         ldal  BackgPeaField+45600,x
         sta   ForegPeaField+45600,x
         ldal  BackgPeaField+35040,x
         sta   ForegPeaField+35040,x
         ldal  BackgPeaField+34320,x
         sta   ForegPeaField+34320,x
         ldal  BackgPeaField+29040,x
         sta   ForegPeaField+29040,x
         ldal  BackgPeaField+23760,x
         sta   ForegPeaField+23760,x
         ldal  BackgPeaField+11280,x
         sta   ForegPeaField+11280,x
         iny
         iny
         iny
         nop

FogT78   ldx   ForegPeaField+42480,y
         lda   FogTable,x
         sta   ForegPeaField+42480,y
         ldx   ForegPeaField+42240,y
         lda   FogTable,x
         sta   ForegPeaField+42240,y
         ldx   ForegPeaField+37440,y
         lda   FogTable,x
         sta   ForegPeaField+37440,y
         ldx   ForegPeaField+15360,y
         lda   FogTable,x
         sta   ForegPeaField+15360,y
         ldx   ForegPeaField+15120,y
         lda   FogTable,x
         sta   ForegPeaField+15120,y
         ldx   ForegPeaField+14880,y
         lda   FogTable,x
         sta   ForegPeaField+14880,y
         ldx   ForegPeaField+14640,y
         lda   FogTable,x
         sta   ForegPeaField+14640,y
         tyx
         ldal  BackgPeaField+45840,x
         sta   ForegPeaField+45840,x
         ldal  BackgPeaField+34800,x
         sta   ForegPeaField+34800,x
         ldal  BackgPeaField+34560,x
         sta   ForegPeaField+34560,x
         ldal  BackgPeaField+20400,x
         sta   ForegPeaField+20400,x
         ldal  BackgPeaField+11040,x
         sta   ForegPeaField+11040,x
         ldal  BackgPeaField+10080,x
         sta   ForegPeaField+10080,x
         ldal  BackgPeaField+7440,x
         sta   ForegPeaField+7440,x
         iny
         iny
         iny
         nop

FogT79   ldx   ForegPeaField+42720,y
         lda   FogTable,x
         sta   ForegPeaField+42720,y
         ldx   ForegPeaField+37200,y
         lda   FogTable,x
         sta   ForegPeaField+37200,y
         ldx   ForegPeaField+36960,y
         lda   FogTable,x
         sta   ForegPeaField+36960,y
         ldx   ForegPeaField+31920,y
         lda   FogTable,x
         sta   ForegPeaField+31920,y
         ldx   ForegPeaField+16560,y
         lda   FogTable,x
         sta   ForegPeaField+16560,y
         ldx   ForegPeaField+16320,y
         lda   FogTable,x
         sta   ForegPeaField+16320,y
         ldx   ForegPeaField+16080,y
         lda   FogTable,x
         sta   ForegPeaField+16080,y
         ldx   ForegPeaField+15840,y
         lda   FogTable,x
         sta   ForegPeaField+15840,y
         ldx   ForegPeaField+15600,y
         lda   FogTable,x
         sta   ForegPeaField+15600,y
         ldx   ForegPeaField+14400,y
         lda   FogTable,x
         sta   ForegPeaField+14400,y
         tyx
         ldal  BackgPeaField+46080,x
         sta   ForegPeaField+46080,x
         ldal  BackgPeaField+40320,x
         sta   ForegPeaField+40320,x
         ldal  BackgPeaField+28800,x
         sta   ForegPeaField+28800,x
         ldal  BackgPeaField+24000,x
         sta   ForegPeaField+24000,x
         ldal  BackgPeaField+20880,x
         sta   ForegPeaField+20880,x
         ldal  BackgPeaField+20640,x
         sta   ForegPeaField+20640,x
         ldal  BackgPeaField+10800,x
         sta   ForegPeaField+10800,x
         ldal  BackgPeaField+10560,x
         sta   ForegPeaField+10560,x
         ldal  BackgPeaField+10320,x
         sta   ForegPeaField+10320,x
         jmp   BackLoop
