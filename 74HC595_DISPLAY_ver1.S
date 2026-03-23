#riscv32-unknown-elf-as -g 74HC595_DISPLAY.S -o 74HC595_DISPLAY.o
#riscv32-unknown-elf-ld -T CH32V003.ld -Map=final.map 74HC595_DISPLAY.O
#riscv32-unknown-elf-objcopy -O ihex a.out 74HC595_DISPLAY.hex
#PC1= RSK , PC5 = SCK , PC6 = DIO of display (has common anode 3641BY display on board)

.equ SRAM_start, 0x20000000
.equ SRAM_end, 0x20000800
.equ STACK, 0x20000800
################################
# CH32V003 register define
#################################
.equ TIM2_BASE, 	0x40000000
.equ W_WDG_BASE, 	0x40002C00
.equ I_WDG_BASE, 	0x40003000
.equ I2C_BASE, 		0x40005400
.equ PWR_BASE, 		0x40007000
.equ AFIO_BASE, 	0x40010000
.equ EXTI_BASE, 	0x40010400
.equ PORTA_BASE, 	0x40010800
.equ PORTC_BASE, 	0x40011000
.equ PORTD_BASE, 	0x40011400
.equ ADC_BASE, 		0x40012400
.equ TIM1_BASE, 	0x40012C00
.equ SPI_BASE, 		0x40013000
.equ USART_BASE, 	0x40013800
.equ DMA_BASE, 		0x40020000
.equ RCC_BASE, 		0x40021000
.equ FLASH_INTERFACE_BASE, 0x40022000
.equ EXTENDED_MEM_BASE, 0x40023800
.equ CORE_PRIVATE_BASE, 0xE0000000
.equ FLASH_BASE, 	0x08000000


.equ R32_PWR_CTLR, 	0x40007000 	#Power control register
.equ R32_PWR_CSR, 	0x40007004 	#Power control/status register
.equ R32_PWR_AWUCSR, 	0x40007008 	#Auto-wakeup control/status register
.equ R32_PWR_AWUWR, 	0x4000700C	#Auto-wakeup window comparison value register
.equ R32_PWR_AWUPSC, 	0x40007010 	#Auto-wakeup crossover factor register
.equ R32_RCC_CTLR, 	0x40021000 	#Clock control register 0x0000xx83
.equ R32_RCC_CFGR0, 	0x40021004 	#Clock configuration register 0 0x00000000
.equ R32_RCC_INTR, 	0x40021008 	#Clock interrupt register 0x00000000
.equ R32_RCC_APB2PRSTR, 0x4002100C 	#APB2 peripheral reset register 0x00000000
.equ R32_RCC_APB1PRSTR, 0x40021010 	# APB1 peripheral reset register 0x00000000
.equ R32_RCC_AHBPCENR, 	0x40021014 	#AHB peripheral clock enable register 0x00000014
.equ R32_RCC_APB2PCENR, 0x40021018 	#APB2 peripheral clock enable register 0x00000000
.equ R32_RCC_APB1PCENR, 0x4002101C 	#APB1 peripheral clock enable register 0x00000000
.equ R32_RCC_RSTSCKR, 	0x40021024   	#Control/status register

.equ R16_IWDG_CTLR, 	0x40003000 	#Control register 0x0000
.equ R16_IWDG_PSCR, 	0x40003004	#Prescaler register 0x0000
.equ R16_IWDG_RLDR,	0x40003008 	#Reload register 0x0FFF
.equ R16_IWDG_STATR, 	0x4000300C 	#Status register

.equ R16_WWDG_CTLR, 	0x40002C00 	#Control register 0x007F
.equ R16_WWDG_CFGR, 	0x40002C04 	#Configuration Register 0x007F
.equ R16_WWDG_STATR, 	0x40002C08 	#Status Register

.equ R32_EXTI_INTENR, 	0x40010400 	#Interrupt enable register 0x00000000
.equ R32_EXTI_EVENR,  	0x40010404 	#Event enable register 0x00000000
.equ R32_EXTI_RTENR, 	0x40010408 	#Rising edge trigger enable register 0x00000000
.equ R32_EXTI_FTENR, 	0x4001040C 	#Falling edge trigger enable register 0x00000000
.equ R32_EXTI_SWIEVR, 	0x40010410 	#Soft interrupt event register 0x00000000
.equ R32_EXTI_INTFR, 	0x40010414 	#Interrupt flag register

.equ R32_PFIC_ISR1, 	0xE000E000 	#PFIC interrupt enable status register 1
.equ R32_PFIC_ISR2, 	0xE000E004 	#PFIC interrupt enable status register 2 
.equ R32_PFIC_IPR1, 	0xE000E020 	#PFIC interrupt pending status register 1 
.equ R32_PFIC_IPR2, 	0xE000E024 	#PFIC interrupt pending status register 2 
.equ R32_PFIC_ITHRESDR, 0xE000E040 	#PFIC interrupt priority threshold configuration register
.equ R32_PFIC_CFGR, 	0xE000E048 	#PFIC interrupt configuration register
.equ R32_PFIC_GISR, 	0xE000E04C 	#PFIC interrupt global status register 
.equ R32_PFIC_VTFIDR, 	0xE000E050 	#PFIC VTF interrupt ID configuration register
.equ R32_PFIC_VTFADDRR0, 0xE000E060 	#PFIC VTF interrupt 0 offset address register
.equ R32_PFIC_VTFADDRR1, 0xE000E064 	#PFIC VTF interrupt 1 offset address register
.equ R32_PFIC_IENR1, 	0xE000E100	#PFIC interrupt enable setting register 1 
.equ R32_PFIC_IENR2, 	0xE000E104 	#PFIC interrupt enable setting register 2 
.equ R32_PFIC_IRER1, 	0xE000E180 	#PFIC interrupt enable clear register 1 
.equ R32_PFIC_IRER2, 	0xE000E184 	#PFIC interrupt enable clear register 2 
.equ R32_PFIC_IPSR1, 	0xE000E200 	#PFIC interrupt pending setting register 1 
.equ R32_PFIC_IPSR2, 	0xE000E204 	#PFIC interrupt pending setting register 2 
.equ R32_PFIC_IPRR1, 	0xE000E280 	#PFIC interrupt hang clear register 1 
.equ R32_PFIC_IPRR2, 	0xE000E284 	#PFIC interrupt hang clear register 2 
.equ R32_PFIC_IACTR1, 	0xE000E300 	#PFIC interrupt activation status register1
.equ R32_PFIC_IACTR2, 	0xE000E304 	#PFIC interrupt activation status register2
.equ R32_PFIC_IPRIOR1, 	0xE000E400 	#PFIC interrupt priority configuration register
.equ R32_PFIC_IPRIOR2, 	0xE000E401 	#PFIC interrupt priority configuration register
.equ R32_PFIC_SCTLR, 	0xE000ED10 	#PFIC system control register

.equ INTSYSCR, 		0x804 		#Interrupt System Control Register
.equ MTVEC, 		0x305 		#Exception Entry Base Address Register
.equ DBGMCU_CR, 	0x7C0  		#Debug MCU Configuration Register (CSR)
 
.equ R32_STK_CTLR, 	0xE000F000 	#System count control register 
.equ R32_STK_SR, 	0xE000F004 	#System count status register 
.equ R32_STK_CNTR, 	0xE000F008	# System counter low register 
.equ R32_STK_CMPR, 	0xE000F010 	#Counting comparison low register


.equ R32_GPIOA_CFGLR, 	0x40010800 	#PA port configuration register low 0x44444444
.equ R32_GPIOC_CFGLR, 	0x40011000 	#PC port configuration register low 0x44444444
.equ R32_GPIOD_CFGLR, 	0x40011400 	#PD port configuration register low 0x44444444
.equ R32_GPIOA_INDR, 	0x40010808 	#PA port input data register 0x0000XXXX
.equ R32_GPIOC_INDR, 	0x40011008 	#PC port input data register 0x0000XXXX
.equ R32_GPIOD_INDR, 	0x40011408 	#PD port input data register 0x0000XXXX
.equ R32_GPIOA_OUTDR, 	0x4001080C 	#PA port output data register 0x00000000
.equ R32_GPIOC_OUTDR, 	0x4001100C 	#PC port output data register 0x00000000
.equ R32_GPIOD_OUTDR, 	0x4001140C 	#PD port output data register 0x00000000
.equ R32_GPIOA_BSHR, 	0x40010810 	#PA port set/reset register 0x00000000
.equ R32_GPIOC_BSHR, 	0x40011010 	#PC port set/reset register 0x00000000
.equ R32_GPIOD_BSHR, 	0x40011410 	#PD port set/reset register 0x00000000
.equ R32_GPIOA_BCR, 	0x40010814 	#PA port reset register 0x00000000
.equ R32_GPIOC_BCR, 	0x40011014 	#PC port reset register
.equ R32_GPIOD_BCR, 	0x40011414 	#PD port reset register 0x00000000
.equ R32_GPIOA_LCKR, 	0x40010818 	#PA port configuration lock register 0x00000000
.equ R32_GPIOC_LCKR, 	0x40011018 	#PC port configuration lock register 0x00000000
.equ R32_GPIOD_LCKR, 	0x40011418 	#PD port configuration lock register 
.equ R32_AFIO_PCFR1, 	0x40010004	#AFIO Remap Register 1
.equ R32_AFIO_EXTICR, 	0x40010008 	#External interrupt configuration register 1

.equ R32_DMA_INTFR, 	0x40020000 	#DMA interrupt status register 0x00000000
.equ R32_DMA_INTFCR, 	0x40020004 	#DMA interrupt flag clear register 0x00000000
.equ R32_DMA_CFGR1, 	0x40020008 	#DMA channel 1 configuration register 0x00000000
.equ R32_DMA_CNTR1, 	0x4002000C 	#DMA channel 1 number of data register
.equ R32_DMA_PADDR1, 	0x40020010 	#DMA channel 1 peripheral address register 0x00000000
.equ R32_DMA_MADDR1, 	0x40020014 	#DMA channel 1 memory address register 0x00000000
.equ R32_DMA_CFGR2, 	0x4002001C 	#DMA channel 2 configuration register 0x00000000
.equ R32_DMA_CNTR2, 	0x40020020 	#DMA channel 2 number of data register 0x00000000
.equ R32_DMA_PADDR2, 	0x40020024 	#DMA channel 2 peripheral address register 0x00000000
.equ R32_DMA_MADDR2, 	0x40020028 	#DMA channel 2 memory address register 0x00000000
.equ R32_DMA_CFGR3, 	0x40020030 	#DMA channel 3 configuration register 0x00000000
.equ R32_DMA_CNTR3, 	0x40020034 	#DMA channel 3 number of data register 0x00000000
.equ R32_DMA_PADDR3, 	0x40020038 	#DMA channel 3 peripheral address register 0x00000000
.equ R32_DMA_MADDR3, 	0x4002003C 	#DMA channel 3 memory address register 0x00000000
.equ R32_DMA_CFGR4, 	0x40020044 	#DMA channel 4 configuration register 0x00000000
.equ R32_DMA_CNTR4, 	0x40020048 	#DMA channel 4 number of data register 0x00000000
.equ R32_DMA_PADDR4, 	0x4002004C 	#DMA channel 4 peripheral address register 0x00000000
.equ R32_DMA_MADDR4, 	0x40020050 	#DMA channel 4 memory address register 0x00000000
.equ R32_DMA_CFGR5, 	0x40020058	#DMA channel 5 configuration register 0x00000000
.equ R32_DMA_CNTR5, 	0x4002005C 	#DMA channel 5 number of data register 0x00000000
.equ R32_DMA_PADDR5, 	0x40020060 	#DMA channel 5 peripheral address register 0x00000000
.equ R32_DMA_MADDR5, 	0x40020064 	#DMA channel 5 memory address register 0x00000000
.equ R32_DMA_CFGR6, 	0x4002006C 	#DMA channel 6 configuration register 0x00000000
.equ R32_DMA_CNTR6, 	0x40020070 	#DMA channel 6 number of data register 0x00000000
.equ R32_DMA_PADDR6, 	0x40020074 	#DMA channel 6 peripheral address register 0x00000000
.equ R32_DMA_MADDR6, 	0x40020078 	#DMA channel 6 memory address register 0x00000000
.equ R32_DMA_CFGR7, 	0x40020080 	#DMA channel 7 configuration register 0x00000000
.equ R32_DMA_CNTR7, 	0x40020084 	#DMA channel 7 number of data register 0x00000000
.equ R32_DMA_PADDR7, 	0x40020088 	#DMA channel 7 peripheral address register 0x00000000
.equ R32_DMA_MADDR7, 	0x4002008C 	#DMA channel 7 memory address register


.equ R32_ADC_STATR, 	0x40012400 	#ADC status register 0x00000000
.equ R32_ADC_CTLR1, 	0x40012404 	#ADC control register 1 0x00000000
.equ R32_ADC_CTLR2, 	0x40012408 	#ADC control register 2 0x00000000
.equ R32_ADC_SAMPTR1, 	0x4001240C 	#ADC sample time register 1 0x00000000
.equ R32_ADC_SAMPTR2, 	0x40012410 	#ADC sample time register 2 0x00000000
.equ R32_ADC_IOFR1, 	0x40012414 	#ADC injected channel data offset register 1 0x00000000
.equ R32_ADC_IOFR2, 	0x40012418 	#ADC injected channel data offset register 2 0x00000000
.equ R32_ADC_IOFR3, 	0x4001241C 	#ADC injected channel data offset register 3 0x00000000
.equ R32_ADC_IOFR4, 	0x40012420 	#ADC injected channel data offset register 4 0x00000000
.equ R32_ADC_WDHTR, 	0x40012424 	#ADC watchdog high threshold register 0x00000000
.equ R32_ADC_WDLTR, 	0x40012428 	#ADC watchdog low threshold register 0x00000000
.equ R32_ADC_RSQR1, 	0x4001242C 	#ADC regular sequence register 1 0x00000000
.equ R32_ADC_RSQR2, 	0x40012430 	#ADC regular sequence register 2 0x00000000
.equ R32_ADC_RSQR3, 	0x40012434 	#ADC regular sequence register 3 0x00000000
.equ R32_ADC_ISQR, 	0x40012438 	#ADC injected sequence register 0x00000000
.equ R32_ADC_IDATAR1, 	0x4001243C 	#ADC injected data register 1 0x00000000
.equ R32_ADC_IDATAR2, 	0x40012440 	#ADC injected data register 2 0x00000000
.equ R32_ADC_IDATAR3, 	0x40012444 	#ADC injected data register 3 0x00000000
.equ R32_ADC_IDATAR4, 	0x40012448 	#ADC injected data register 4 0x00000000
.equ R32_ADC_RDATAR, 	0x4001244C 	#ADC regular data register 0x00000000
.equ R32_ADC_DLYR, 	0x40012450 	#ADC delayed data register


.equ R16_TIM1_CTLR1, 	0x40012C00 	#Control register 1 0x0000
.equ R16_TIM1_CTLR2, 	0x40012C04 	#Control register 2 0x0000
.equ R16_TIM1_SMCFGR, 	0x40012C08 	#Slave mode control register 0x0000
.equ R16_TIM1_DMAINTENR, 0x40012C0C 	#DMA/interrupt enable register 0x0000
.equ R16_TIM1_INTFR, 	0x40012C10 	#Interrupt status register 0x0000
.equ R16_TIM1_SWEVGR, 	0x40012C14 	#Event generation register 0x0000
.equ R16_TIM1_CHCTLR1, 	0x40012C18 	#Compare/capture control register 1 0x0000
.equ R16_TIM1_CHCTLR2, 	0x40012C1C 	#Compare/capture control register 2 0x0000
.equ R16_TIM1_CCER, 	0x40012C20 	#Compare/capture enable register 0x0000
.equ R16_TIM1_CNT, 	0x40012C24 	#Counters 0x0000
.equ R16_TIM1_PSC, 	0x40012C28 	#Counting clock prescaler 0x0000
.equ R16_TIM1_ATRLR, 	0x40012C2C 	#Auto-reload value register 0x0000
.equ R16_TIM1_RPTCR, 	0x40012C30 	#Recurring count value register 0x0000
.equ R16_TIM1_CH1CVR, 	0x40012C34 	#Compare/capture register 1 0x0000
.equ R16_TIM1_CH2CVR, 	0x40012C38 	#Compare/capture register 2 0x0000
.equ R16_TIM1_CH3CVR, 	0x40012C3C 	#Compare/capture register 3 0x0000
.equ R16_TIM1_CH4CVR, 	0x40012C40 	#Compare/capture register 4 0x0000
.equ R16_TIM1_BDTR, 	0x40012C44 	#Brake and deadband registers 0x0000
.equ R16_TIM1_DMACFGR, 	0x40012C48 	#DMA control register 0x0000
.equ R16_TIM1_DMAADR, 	0x40012C4C 	#DMA address register for continuous mode


.equ R16_TIM2_CTLR1, 	0x40000000 	#TIM2 control register1 0x0000
.equ R16_TIM2_CTLR2, 	0x40000004 	#TIM2 control register2 0x0000
.equ R16_TIM2_SMCFGR, 	0x40000008 	#TIM2 Slave mode control register 0x0000
.equ R16_TIM2_DMAINTENR, 0x4000000C 	#TIM2 DMA/interrupt enable register
.equ R16_TIM2_INTFR, 	0x40000010 	#TIM2 interrupt status register 0x0000
.equ R16_TIM2_SWEVGR, 	0x40000014 	#TIM2 event generation register 0x0000
.equ R16_TIM2_CHCTLR1, 	0x40000018 	#TIM2 compare/capture control register1 0x0000
.equ R16_TIM2_CHCTLR2, 	0x4000001C 	#TIM2 compare/capture control register2 0x0000
.equ R16_TIM2_CCER, 	0x40000020 	#TIM2 compare/capture enable register 0x0000
.equ R16_TIM2_CNT, 	0x40000024 	#TIM2 counter 0x0000
.equ R16_TIM2_PSC, 	0x40000028 	#TIM2 count clock prescaler 0x0000
.equ R16_TIM2_ATRLR, 	0x4000002C 	#TIM2 auto-reload register 0x0000
.equ R16_TIM2_CH1CVR, 	0x40000034 	#TIM2 compare/capture register1 0x0000
.equ R16_TIM2_CH2CVR, 	0x40000038 	#TIM2 compare/capture register2 0x0000
.equ R16_TIM2_CH3CVR, 	0x4000003C 	#TIM2 compare/capture register3 0x0000
.equ R16_TIM2_CH4CVR, 	0x40000040 	#TIM2 compare/capture register4 0x0000
.equ R16_TIM2_DMACFGR, 	0x40000048 	#TIM2 DMA control register 0x0000
.equ R16_TIM2_DMAADR, 	0x4000004C 	#TIM2 DMA address register in continuous mode
  

.equ R32_USART_STATR, 	0x40013800 	#UASRT status register 0x000000C0
.equ R32_USART_DATAR, 	0x40013804 	#UASRT data register 0x000000XX
.equ R32_USART_BRR, 	0x40013808 	#UASRT baud rate register 0x00000000
.equ R32_USART_CTLR1, 	0x4001380C 	#UASRT control register 1 0x00000000
.equ R32_USART_CTLR2, 	0x40013810 	#UASRT control register 2 0x00000000
.equ R32_USART_CTLR3, 	0x40013814 	#UASRT control register 3 0x00000000
.equ R32_USART_GPR, 	0x40013818 	#UASRT protection time and prescaler register


.equ R16_I2C_CTLR1, 	0x40005400 	#I2C control register 1 0x0000
.equ R16_I2C_CTLR2, 	0x40005404 	#I2C control register 2 0x0000
.equ R16_I2C_OADDR1, 	0x40005408 	#I2C address register 1 0x0000
.equ R16_I2C_OADDR2, 	0x4000540C 	#I2C address register 2 0x0000
.equ R16_I2C_DATAR,  	0x40005410 	#I2C data register 0x0000
.equ R16_I2C_STAR1,  	0x40005414 	#I2C status register 1 0x0000
.equ R16_I2C_STAR2,  	0x40005418 	#I2C status register 2 0x0000
.equ R16_I2C_CKCFGR, 	0x4000541C 	#I2C clock register

.equ R16_SPI_CTLR1, 	0x40013000 	#SPI Control register1 0x0000
.equ R16_SPI_CTLR2, 	0x40013004 	#SPI Control register2 0x0000
.equ R16_SPI_STATR, 	0x40013008 	#SPI Status register 0x0002
.equ R16_SPI_DATAR, 	0x4001300C 	#SPI Data register 0x0000
.equ R16_SPI_CRCR,  	0x40013010 	#SPI Polynomial register 0x0007
.equ R16_SPI_RCRCR, 	0x40013014 	#SPI Receive CRC register 0x0000
.equ R16_SPI_TCRCR, 	0x40013018 	#SPI Transmit CRC register 0x0000
.equ R16_SPI_HSCR,  	0x40013024 	#SPI High-speed control register

.equ R16_ESIG_FLACAP, 	0x1FFFF7E0 	#Flash capacity register 0xXXXX
.equ R32_ESIG_UNIID1, 	0x1FFFF7E8 	#UID register 1 0xXXXXXXXX
.equ R32_ESIG_UNIID2, 	0x1FFFF7EC 	#UID register 2 0xXXXXXXXX
.equ R32_ESIG_UNIID3,  	0x1FFFF7F0 	#UID register 3 

.equ R32_FLASH_ACTLR, 	0x40022000 	#Control register
.equ R32_FLASH_KEYR,  	0x40022004 	#FPEC key register X
.equ R32_FLASH_OBKEYR, 	0x40022008 	#OBKEY register X
.equ R32_FLASH_STATR, 	0x4002200C 	#Status register 0x00008000
.equ R32_FLASH_CTLR,  	0x40022010 	#Configuration register 0x00008080
.equ R32_FLASH_ADDR, 	0x40022014 	#Address register X
.equ R32_FLASH_OBR,  	0x4002201C 	#Select word register 0x03FFFFFE
.equ R32_FLASH_WPR,  	0x40022020 	#Write protection register 0xFFFFFFF
.equ R32_FLASH_MODEKEYR,  0x40022024 	#Extended key register X
.equ R32_FLASH_BOOT_MODEKEYR,  0x40022028 #Unlock BOOT key register

.equ R32_EXTEN_CTR, 	0x40023800 	#Configure extended control registers

.equ PFIC_KEY1, 	0xFA050000
.equ PFIC_KEY2, 	0xBCAF0000
.equ PFIC_KEY3, 	0xBEEF0000
.equ mstatus, 		0x300
.equ mtvec, 		0x305
.equ intsyscr, 		0x804
.equ mepc, 		0x341

.equ  SYSTICK_SR_CNTIF,   (1<<0)
.equ  SYSTICK_CTLR_STE ,  (1<<0)
.equ  SYSTICK_CTLR_STIE,  (1<<1)
.equ  SYSTICK_CTLR_STCLK, (1<<2)
.equ  SYSTICK_CTLR_STRE,  (1<<3)
.equ  SYSTICK_CTLR_SWIE,  (1<<31) 

###############################
.equ buffer,    0x20000004
.equ buffer1,  	0x20000008
.equ state , 	0x2000000C
.equ input_count,  0x20000010
.equ CURRENT_DIGIT_INDEX, 0x20000014
.equ fraction,  0x20000018		# stores 1 second measure window overflow for slow signals
.equ fraction2, 0x2000001C
.equ result_lo, 0x20000020
.equ result_hi, 0x20000024
.equ modulo ,   0x20000028 
.equ scratch,   0x2000002C
.equ result1,   0x20000030		# 10 bytes used by print function from 0(mem)
.equ result2,   0x20000034		# till 9(mem) , 2 bytes in mem1
.equ dividend , 0x20000038
.equ divisor, 	0x2000003C
.equ DISPLAY_RAM,  0x20000040
.equ DISPLAY_RAM1, 0x20000044
.equ DP_STATE,	0x20000048
.equ mem,	0x2000004C








.macro push val
  	addi sp, sp, -4
  	sw \val, 0(sp)
.endm

.macro pop val
  	lw \val, 0(sp)
  	addi sp, sp, 4
.endm


.macro micros val
  	addi sp,sp,-4
  	sw t1,0(sp)
  	li t1,\val
  	call delayus
  	lw t1,0(sp)
  	addi sp,sp,4
.endm

.macro debug tp
  	addi sp,sp,-8
  	sw a5,0(sp)
  	sw gp,4(sp)
  	la a5, result_lo
  	mv gp,\tp
  	sw gp, 0(a5)
  	call convert_to_decimal_signed
  	pos 0,0
  	call displayresult2		# display value in LCD
  	call delay1S			# delay 1 second
  	lw gp,4(sp)
  	lw a5,0(sp)
  	addi sp,sp,8
.endm

.align 9
vtable:
  j start		#  
.align 2
  .word   0x00000000 # RESERVED 1
  .word   NMI_IRQhandler
  .word   HardFault_IRQhandler
  .word   0x00000000 # RESERVED 4
  .word   0x00000000 # RESERVED 5
  .word   0x00000000 # RESERVED 6
  .word   0x00000000 # RESERVED 7
  .word   0x00000000 # RESERVED 8
  .word   0x00000000 # RESERVED 9
  .word   0x00000000 # RESERVED 10
  .word   0x00000000 # RESERVED 11
  .word   SysTick_IRQhandler	#; place the address of the mtime ISR subroutine in the vector table position 7,assembler will store isr address here, longs 0x00000000 # RESERVED 12	
  .word   0x00000000 # RESERVED 13
  .word   SW_Software_IRQhandler
  .word   0x00000000 # RESERVED 15
  .word   WWDG_IRQhandler
  .word   PVD_IRQhandler
  .word   FLASH_IRQhandler
  .word   RCC_IRQhandler
  .word   EXTI7_0_IRQhandler
  .word   AWU_IRQhandler
  .word   DMA1_CH1_IRQhandler
  .word   DMA1_CH2_IRQhandler
  .word   DMA1_CH3_IRQhandler
  .word   DMA1_CH4_IRQhandler
  .word   DMA1_CH5_IRQhandler
  .word   DMA1_CH6_IRQhandler
  .word   DMA1_CH7_IRQhandler
  .word  ADC1_IRQhandler				# ADC1 interrupt vector
  .word  I2C1_EV_IRQhandler
  .word  I2C1_ER_IRQhandler
  .word  USART1_IRQhandler
  .word  SPI1_IRQhandler
  .word  TIM1BRK_IRQhandler
  .word  TIM1UP_IRQhandler
  .word  TIM1TRG_COM_IRQhandler
  .word  TIM1CC_IRQhandler
  .word  TIM2_IRQhandler



.text
.section .isr_vectors
  .weak   NMI_IRQhandler
  .weak   HardFault_IRQhandler
  .weak   SysTick_IRQhandler	#; place the address of the mtime ISR subroutine in the vector table position 7,assembler will store isr address here, longs 0x00000000 # RESERVED 12	
  .weak   SW_Software_IRQhandler
  .weak   WWDG_IRQhandler
  .weak   PVD_IRQhandler
  .weak   FLASH_IRQhandler
  .weak   RCC_IRQhandler
  .weak   EXTI7_0_IRQhandler
  .weak   AWU_IRQhandler
  .weak   DMA1_CH1_IRQhandler
  .weak   DMA1_CH2_IRQhandler
  .weak   DMA1_CH3_IRQhandler
  .weak   DMA1_CH4_IRQhandler
  .weak   DMA1_CH5_IRQhandler
  .weak   DMA1_CH6_IRQhandler
  .weak   DMA1_CH7_IRQhandler
  .weak  ADC1_IRQhandler				# ADC1 interrupt vector
  .weak  I2C1_EV_IRQhandler
  .weak  I2C1_ER_IRQhandler
  .weak  USART1_IRQhandler
  .weak  SPI1_IRQhandler
  .weak  TIM1BRK_IRQhandler
  .weak  TIM1UP_IRQhandler
  .weak  TIM1TRG_COM_IRQhandler
  .weak  TIM1CC_IRQhandler
  .weak  TIM2_IRQhandler


.align 2
.text
.global start
start:

    	li sp, STACK			# load stack pointer with stack end address
	 
    	la t0, vtable			#BASEADDR[31:2],The interrupt vector table base address,which needs to be 1KB aligned
    	ori t0, t0, 3			#BASEADDR[31:2],1: Identify by absolute address,1: Address offset based on interrupt number *4
    	csrrw zero, mtvec,t0		# write t0 mtvec
   	la t0,main
	csrw	mepc,t0
          				#csrw	mepc,t0 :mepc updated with address of main
	mret

  
.align 4

main:        
#Enable GPIO clocks & AFIO in APB2 clock register
        
    	la x10,R32_RCC_APB2PCENR	# load address of APB2PCENR register to x10 ,for enabling GPIO A,D,C peripherals
	lw x11,0(x10)			# load contents from peripheral register R32_RCC_APB2PCENR pointed by x10
	li x7,((1<<2)|(1<<4)|(1<<5)|(1<<0)|(1<<12))	# 1<<IOPA_EN,1<<IOPC_EN,1<<IOPD_EN,1<<AFIOEN,1<<SPI enable port A,C,D and AFIO functions
	or x11,x11,x7			# or values 
	sw x11,0(x10)			# store modified enable values in R32_RCC_APB2PCENR
	la x10,R32_RCC_APB1PCENR
	lw x11,0(x10)
	ori x11,x11,(1<<0)		# timer2 clock enable
	sw x11,0(x10)

#configure GPIO PortC as multiplex push-pull output for SPI
	li x10,R32_GPIOC_CFGLR		# load pointer x10 with address of R32_GPIOC_CFGLR , SPI = RCK,SCK,DIO is on portC PC1,PC5,PC6
	lw x11,0(x10)			# load contents from register pointed by x10
	li x7,~((0xf<<4)|(0xf<<20)|(0xf<<24))	# clear pc1,pc5,pc6 for SPI = RCK,DIO,SCK
	and x11,x11,x7			# clear  mode and cnf bits for selected pin C1,C2
	li x7,((0x3<<4)|(0xB<<20)|(0xB<<24))	# PC1=push-pull,PC5,PC6 = multiplex pushpull output 50mhz , 0b1011
	or x11,x11,x7			# OR value to register
	sw x11,0(x10)			# store in R32_GPIOC_CFGLR

SPI_CONFIG:
	li x10,R32_RCC_APB1PRSTR	# set pointer to clock control  peripheral reset register 
	lw x11,0(x10)			# load contents to x11
	li x7,(1<<12)			# shift 1 to 12th bit position
	or x11,x11,x7			# OR with x11
	sw x11,0(x10)			# set bit 12 of R32_RCC_APB1PRSTR to reset SPI peripheral
	not x7,x7			# invert values in x7
	and x11,x11,x7			# and x11 to write a 0 in 21st bit
	sw x11,0(x10)			# store 0 in 12th bit to restart SPI engine
	li x10,R16_SPI_CTLR1
	lh x11,0(x10)
	li x7,((1<<2)|(1<<3)|(1<<8)|(1<<9)|(1<<6))	# MSTR,BR(FHCLK /4),SSI,SSM,SPE
	or x11,x11,x7			# SPI with software NSS is used
	sh x11,0(x10)


timer2_for_10ms:			# used for refreshing display @ 100Hz
	la x10,R16_TIM2_PSC
	li x11,7			# fck_PSC/PSC[15:0]+1,8MHz/7+1 =1000000 (1Mhz) = 1000000count/sec
	sw x11,0(x10)
	la x10,R16_TIM2_ATRLR
	li x11,10000			# max reload every 10ms  (frequency = 1000000/10000 =100hZ)1000000count/1000ms =1000count/1ms
	sw x11,0(x10)

	la x10,R16_TIM2_DMAINTENR
	lw x11,0(x10)
	li x7,(1<<0)			# enable update interrupt
	or x11,x11,x7
	sw x11,0(x10)
	la x10,R16_TIM2_CTLR1
	lw x11,0(x10)
	la x7,((0<<1)|(1<<2)|(1<<7))	# UDIS =0 ,URS =1,ARPE=1,
	or x11,x11,x7
	sw x11,0(x10)
	la x10,R16_TIM2_SWEVGR
	lw x11,0(x10)
	li x7,(1<<0)			# 1<<UG, generate update event to load all values immediately
	or x11,x11,x7
	sw x11,0(x10)
	la x10,R16_TIM2_INTFR
	lw x11,0(x10)
	li x7,0xFFFFFFFA		# 0<<UIF  clear update interrupt flag
	and x11,x11,x7
	sw x11,0(x10)

	la x10,R16_TIM2_CTLR1
	lw x11,0(x10)
	ori x11,x11,(1<<0)		# enable timer 2
	sw x11,0(x10)	


PFIC_CONFIG:
	la x10,R32_PFIC_CFGR		# reset core PFIC register for interrupts
	lw x11,0(x10)
	li x7,((PFIC_KEY3<<16)|(1<<7))	# key3  and SYSRESET , reference manual tells to do it
	or x11,x11,x7
	sw x11,0(x10)			# store back new values
	la x10,R32_PFIC_IENR2		# PFIC Interrupt Enable in core PFIC
	lw x11,0(x10)
	li x7,(1<<6)			# enabled  TIM2 interrupts in PFIC. #38 interrupt is timer2
	or x11,x11,x7
	sw x11,0(x10)			# store back new values

# enabling GLOBAL INTERRUPTS
	li t0, 0x88			# load MPIE and MIE bits , 1<<MIE in mstatus is enabling GLOBAL INTERRUPTS
	csrw mstatus,t0 		# csrrw the values in t0,

######################
	li x7,2				# decimal point on 2nd digit  -123.4 . 8 positions available by loading 1,2,4,8,10,20,40,80 individually or combinations
	la a0,DP_STATE			# global variable for decimal point map
	sw x7,0(a0)			# store value
counter_example:
	li a0,0				# argument for SPLIT_24BIT in a0 , start with 0
example_loop:
	call SPLIT_24BIT_SIGNED 	# converts a 24 bit number in a0 to a signed output in DISPLAY_RAM			
	call check_n_add_DP		# reads DISPLAY_RAM and adds decimal point based on DP_STATE
	call delay1ms			# 1 ms delay
	addi a0,a0,1			# increase a0 number by 1
	li a1,0xfffff			# compare with max display value
	bne a0,a1,example_loop		# if less jump to example loop
	li a0,0				# load start  value if already max value is reached
	j example_loop			# re start loop
here:
			

	j here

delay1ms:
	addi sp,sp,-8 			# push RA
	sw ra,0(sp) 			# push RA
	sw t1,4(sp) 
	li t1,2010 			# load an arbitarary value 20000000 to t1 register 
loop1ms:
	addi t1,t1,-1 			# subtract 1 from t1
	bne t1,zero,loop1ms 		# if t1 not equal to 0 branch to label loop
	lw t1,4(sp)
	lw ra,0(sp) 			# POP RA
	addi sp,sp,8 			# pop RA 
	ret   


#Subroutines
#################################################################
#SPI1_SEND_16BIT sends 16bit data to display with SPI.PC1,PC5,PC6
#################################################################
# --- Input: x7 = Byte for 2nd chip, x8 = Byte for 1st chip ---
SPI1_SEND_16BIT:
    	addi sp, sp, -36
    	sw ra,0(sp)
	sw t0,4(sp)
	sw t1,8(sp)
	sw tp,12(sp)
	sw gp,16(sp)
	sw t2,20(sp)
	sw s1,24(sp)
	sw t2,28(sp)
	sw s0,32(sp)

    	# 1. Pull Latch (RCK/PC1) LOW
    	li   t0, 0x00000002        # Pin PC1 mask
    	la   t1, R32_GPIOC_BCR     # Port C Bit Clear Register
    	sw   t0, 0(t1)

    	# 2. Transmit First Byte (x7)
    	la   t1, R16_SPI_DATAR     # SPI Data Register
    	sb   x7, 0(t1)             # Write font data x8
wait_tx1:
    	la   tp, R16_SPI_STATR     # Use t4 for status to avoid touching x7/x8
    	lhu  gp, 0(tp)
    	andi gp, gp, 0x02          # Check TXE (Transmit Empty)
    	beqz gp, wait_tx1

    	# 3. Transmit Second Byte (x8)
    	sb   x8, 0(t1)             # Start SPI shift
wait_tx2:
    	lhu  gp, 0(tp)             # Re-read Status Register
    	andi gp, gp, 0x80          # Check BSY (Busy) bit
    	bnez gp, wait_tx2          # Wait until hardware is totally finished

    	# 4. Pull Latch (RCK/PC1) HIGH to update LEDs
    	la   t1, R32_GPIOC_BSHR    # Port C Bit Set Register
    	sw   t0, 0(t1)

	lw s0,32(sp)
	lw t2,28(sp)
	lw s1,24(sp)
	lw t2,20(sp)
	lw gp,16(sp)
	lw tp,12(sp)
	lw t1,8(sp)
	lw t0,4(sp)
    	lw ra,0(sp)
    	addi sp, sp, 36
    	ret
#########################################################
#UPDATES display with data in DISPLAY_RAM
# Variables= DISPLAY_RAM
# look up tables, DIGIT_SELECT_TABLE,REMAP_TABLE
##########################################################
# --- Subroutine: REFRESH_DISPLAY ---
# Expects 8 bytes in DISPLAY_RAM (Segment Fonts)
REFRESH_DISPLAY:
    	addi sp, sp, -36
    	sw ra, 0(sp)
    	sw s1, 4(sp)        	# DISPLAY_RAM base
    	sw tp, 8(sp)        	# DIGIT_SELECT_TABLE base
    	sw a2, 12(sp)         	# REMAP_TABLE base
    	sw gp, 16(sp)         	# Loop counter (0-7)
	sw t0,20(sp)
	sw t1,24(sp)
	sw t2,28(sp)
	sw s0,32(sp)

    	la   s1, DISPLAY_RAM
    	la   tp, DIGIT_SELECT_TABLE
    	la   a2, REMAP_TABLE
    	li   gp, 0             # Start at digit 0

refresh_loop:
    	# 1. Get the remapped index
    	add  t0, a2, gp        # Pointer to REMAP_TABLE[gp]
    	lbu  t0, 0(t0)         # Get physical index (e.g., 3)

    	# 2. Load Font using the remapped index
    	add  t1, s1, t0        # Pointer to DISPLAY_RAM[physical_index]
    	lbu  x7, 0(t1)         # Load Font

    	# 3. Load Position using the logical index (Direct)
    	add  t1, tp, gp        # Pointer to DIGIT_SELECT_TABLE[gp]
    	lbu  x8, 0(t1)         # Load Position

    	# 4. Send to SPI 
    	call SPI1_SEND_16BIT

    	# 5. Delay
    	li   t0, 2000
delay_loop:
    	addi t0, t0, -1
    	bnez t0, delay_loop

    	# 6. Anti-Ghosting (Clear)
    	li   x8, 0x00
    	li   x7, 0xFF
    	call SPI1_SEND_16BIT

    	# 7. Next Digit
    	addi gp, gp, 1
    	li   t0, 8
    	blt  gp, t0, refresh_loop
	lw s0,32(sp)
	lw t2,28(sp)
	lw t1,24(sp)
	lw t0,20(sp)
    	lw gp, 16(sp)
    	lw a2, 12(sp)
    	lw tp, 8(sp)
    	lw s1, 4(sp)
    	lw ra, 0(sp)
    	addi sp, sp, 36
    	ret

###############################################################################
#SPLIT_24BIT used to convert 24 bit number to 7 SEGMENT fonts in DISPLAY_RAM
##############################################################################

# Input: x10 = Number to convert
# Output: DISPLAY_RAM filled (Common Anode, Blanked)
SPLIT_24BIT:
	addi sp,sp,-44
	sw ra,0(sp)
	sw tp,4(sp)
	sw gp,8(sp)
	sw t0,12(sp)
	sw t1,16(sp)
	sw t2,20(sp)
	sw s0,24(sp)
	sw s1,28(sp)
	sw a1,32(sp)
	sw a0,36(sp)
	sw a2,40(sp)

    	la   s1, POWERS_10
    	la   t0, DISPLAY_RAM
    	la   a1, DIGIT_TABLE_CA
    	li   t1, 8              # 8 digits
    	li   tp, 0              # Blanking flag (0 = blanking)

digit_loop:
    	lw   gp, 0(s1)          # Load 10,000,000... 1,000,000... etc.
    	li   t2, 0              # Digit counter (0-9)

sub_loop:
    	bltu a0, gp, done_sub  # Can we subtract the power of 10?
    	sub  a0, a0, gp
    	addi t2, t2, 1          # Increment digit
    	j    sub_loop

done_sub:
    	# --- Blanking Logic ---
    	bnez t2, show_digit     # If digit > 0, we must show it
    	bnez tp, show_digit     # If a previous digit was shown, show this 0
    	li   s0, 1
    	beq  t1, s0, show_digit # Always show the very last digit (Units)
    
    	li   a2, 0xFF           # BLANK (Common Anode)
	j    store_ram

show_digit:
    	li   tp, 1              # Set flag: no more blanking for this number
    	add  a2, a1, t2         # Table Base + Digit
    	lb   a2, 0(a2)          # Load Font Pattern

store_ram:
    	sb   a2, 0(t0)
    	addi s1, s1, 4          # Next power of 10
    	addi t0, t0, 1          # Next RAM byte
    	addi t1, t1, -1         # Next digit position
    	bnez t1, digit_loop
    

	lw a2,40(sp)
	lw a0,36(sp)
	lw a1,32(sp)
	lw s1,28(sp)
	lw s0,24(sp)
	lw t2,20(sp)
	lw t1,16(sp)
	lw t0,12(sp)
	lw gp,8(sp)
	lw tp,4(sp)
	lw ra,0(sp)
	addi sp,sp,44
	ret

##############################################################################
# Updates display 
#Global Variable: CURRENT_DIGIT_INDEX (0-7),DISPLAY_RAM (8bytes)
# ro data table = DIGIT_SELECT_TABLE (actual digit position on board)
##############################################################################
REFRESH_SINGLE_DIGIT:
	addi sp,sp,-28
	sw ra,0(sp)
	sw t0,4(sp)
	sw t1,8(sp)
	sw s1,12(sp)
	sw tp,16(sp)
	sw t2,20(sp)
	sw s0,24(sp)

    	la   t0, CURRENT_DIGIT_INDEX
    	lb   t1, 0(t0)          # Which digit are we on? (0-7)

    	# 1. Load font and position bitmask for THIS digit only
    	la   s1, DISPLAY_RAM
    	add  s1, s1, t1
    	lbu  x7, 0(s1)          # Font

    	la   tp, DIGIT_SELECT_TABLE
    	add  tp, tp, t1
    	lbu  x8, 0(tp)          # Position
    
    	call SPI1_SEND_16BIT    # Update hardware

    	# 2. Increment index for next time
    	addi t1, t1, 1
    	andi t1, t1, 0x07       # Keep it 0-7
    	sb   t1, 0(t0)

	lw s0,24(sp)
	lw t2,20(sp)
	lw tp,16(sp)
	lw s1,12(sp)
	lw t1,8(sp)
	lw t0,4(sp)
	lw ra,0(sp)
	addi sp,sp,28
    	ret
###########################################
# Input: a0 = Signed 32-bit value
#        a1 = Decimal position (0=No DP, 1=Far Right, 8=Far Left)
# Output: Fills DISPLAY_RAM (8 bytes)

SPLIT_24BIT_SIGNED:
	addi sp,sp,-44
	sw ra,0(sp)
	sw tp,4(sp)
	sw gp,8(sp)
	sw t0,12(sp)
	sw t1,16(sp)
	sw t2,20(sp)
	sw s0,24(sp)
	sw s1,28(sp)
	sw a1,32(sp)
	sw a0,36(sp)
	sw a2,40(sp)
    
    	la   s1, POWERS_10
    	la   t0, DISPLAY_RAM
    	la   a1, DIGIT_TABLE_CA
    	li   t1, 8              # 8 digits
    	li   tp, 0              # Blanking flag (0 = blanking)
check_sign:
    	# --- Step 1: Handle Sign ---
    	bgez a0, digit_loop
    	neg  a0, a0             # Make it positive for the math
    	li   gp, 0xBF           # '-' segment pattern for Common Anode
    	sb   gp, 0(t0)          # Place '-' at the far left (Index 0)
    	addi t0, t0, 1          # Shift start of numbers to the right
    	addi t1, t1,-1         	# We have 1 less digit space
    	addi s1,s1,4		# we start from next power of 10 as the top is taken

digit_loop_signed:
    	lw   gp, 0(s1)          # Load 10,000,000... 1,000,000... etc.
    	li   t2, 0              # Digit counter (0-9)

sub_loop_signed:
    	bltu a0, gp, done_sub_signed  # Can we subtract the power of 10?
    	sub  a0, a0, gp
    	addi t2, t2, 1          # Increment digit
    	j    sub_loop_signed

done_sub_signed:
    	# --- Blanking Logic ---
    	bnez t2, show_digit_signed      # If digit > 0, we must show it
    	bnez tp, show_digit_signed      # If a previous digit was shown, show this 0
    	li   s0, 1
    	beq  t1, s0, show_digit_signed  # Always show the very last digit (Units)
    
    	li   a2, 0xFF           	# BLANK (Common Anode)
	j    store_ram_signed

show_digit_signed:
    	li   tp, 1              # Set flag: no more blanking for this number
    	add  a2, a1, t2         # Table Base + Digit
    	lb   a2, 0(a2)          # Load Font Pattern

store_ram_signed:
    	sb   a2, 0(t0)
    	addi s1, s1, 4          # Next power of 10
    	addi t0, t0, 1          # Next RAM byte
    	addi t1, t1, -1         # Next digit position
    	bnez t1, digit_loop_signed

	lw a2,40(sp)
	lw a0,36(sp)
	lw a1,32(sp)
	lw s1,28(sp)
	lw s0,24(sp)
	lw t2,20(sp)
	lw t1,16(sp)
	lw t0,12(sp)
	lw gp,8(sp)
	lw tp,4(sp)
	lw ra,0(sp)
	addi sp,sp,44
	ret    
######################################################
# DP_STATE should be loaded with DP position.
# global variable = DP_STATE, DISPLAY_RAM,DISPLAY_RAM1
######################################################
check_n_add_DP:
	addi sp,sp,-32
	sw ra,0(sp)
	sw tp,4(sp)
	sw gp,8(sp)
	sw t0,12(sp)
	sw t1,16(sp)
	sw t2,20(sp)
	sw a1,24(sp)
	sw a2,28(sp)
	
	la   t0, DISPLAY_RAM	# point to DISPLAY_RAM with display fonts
	addi t0,t0,7		# increase address to last digit at left side of display
    	la   a1, DP_STATE	# point to address where DP location is stored
    	li   t1, 8              # 8 digits
    	li   tp, 0              # position counter
	
	lbu gp,0(a1)		# load DP map from DP_STATE
	li t2,1			# mask register to identify DP position
dp_loop:
	and a2,gp,t2		# a2 flags if DP is valid for current digit
	bnez a2,add_DP
	j next_digit
add_DP:
	lbu a2,0(t0)		# load the byte from display ram
	andi a2,a2,0x7f         # and with 0x7f to enable DP
	sb a2,0(t0)		# store back DP to the selected digit
next_digit:
	addi t0,t0,-1		# decrease DISPLAY_RAM address towards left from right , from unit to highest position
	slli t2,t2,1		# increase the DP bit mask
	addi tp,tp,1		# increase digit counter
	bne tp,t1,dp_loop	# if tp not equal to 8 continue to check for DP

	lw a2,28(sp)
	lw a1,24(sp)
	lw t2,20(sp)
	lw t1,16(sp)
	lw t0,12(sp)
	lw gp,8(sp)
	lw tp,4(sp)
	lw ra,0(sp)
	addi sp,sp,32
	ret


#################

TIM2_IRQhandler:
	addi sp,sp,-60    		# push all registers
	sw x15,56(sp)
	sw x14,52(sp)
	sw x13,48(sp)
	sw x12,44(sp)
	sw x11,40(sp)
	sw x10,36(sp)
	sw x9,32(sp)
	sw x8,28(sp)
	sw x7,24(sp)
	sw x6,20(sp)
	sw x5,16(sp)
	sw x4,12(sp)
	sw x3,8(sp)
	sw x2,4(sp)
	sw x1,0(sp)
	
###########

	la x10,R16_TIM2_INTFR
	lw x11,0(x10)
	li x7,~1			# 0<<UIF
	and x11,x11,x7
	sw x11,0(x10)
	
	call REFRESH_DISPLAY

############
	lw x1,0(sp)
	lw x2,4(sp)
	lw x3,8(sp)
	lw x4,12(sp)
	lw x5,16(sp)
	lw x6,20(sp)
	lw x7,24(sp)
	lw x8,28(sp)
	lw x9,32(sp)
	lw x10,36(sp)
	lw x11,40(sp)
	lw x12,44(sp)
	lw x13,48(sp)
	lw x14,52(sp)
	lw x15,56(sp)
	addi sp,sp,60
	mret
##################################

.section .rodata    
.align 2 
DIGIT_TABLE_CA:
    .byte 0xC0, 0xF9, 0xA4, 0xB0, 0x99, 0x92, 0x82, 0xF8, 0x80, 0x90  # 0-9
    .byte 0x88, 0x83, 0xC6, 0xA1, 0x86, 0x8E                          # A-F
    .byte 0xBF                                                        # - (Dash)
    .byte 0xFF                                                        # Blank

.section .rodata    
.align 2 
# Position Selector (sent as the 'x7' byte in  SPI routine)
# Assuming Left-to-Right order:
DIGIT_SELECT_TABLE:
    .byte 0x80    # Digit 1 (Far Left)
    .byte 0x40    # Digit 2
    .byte 0x20    # Digit 3
    .byte 0x10    # Digit 4
    .byte 0x08    # Digit 5
    .byte 0x04    # Digit 6
    .byte 0x02    # Digit 7
    .byte 0x01    # Digit 8 (Far Right)

.section .rodata    
.align 2 
# Maps Logical Digit (0-7) to Physical RAM Index
# To get 01234567 on screen, we read RAM in this order:
REMAP_TABLE:
    .byte 3, 2, 1, 0, 7, 6, 5, 4


.section .rodata    
.align 2 

POWERS_10: .word 10000000, 1000000, 100000, 10000, 1000, 100, 10, 1
