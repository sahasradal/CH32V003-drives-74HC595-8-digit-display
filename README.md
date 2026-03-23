# CH32V003-drives-74HC595-8-digit-display
CH32V003 drives 74HC595 8 digit seven segment display. uses common anode display on module
PC1 connected to RCK , PC5 connected to SCK , PC6 connected to DIO                        .
i have connected on the LHS side of the board
display needs to be constantly refreshed. better to use a timer interrupt every 2ms or 5ms.
decimal point position needs to be loaded in DP_STATE (SRAM), 0 or some combination of 1,2,4,8,10,20,40,80
. Uses 3 look up table . for fonts , address of display and wiring positions of digt on actual board.
The display address is not leniar as 0,1,2,3,4,5,6,7. current - sign is fixed on LHS corner. floating minus yet to be implemented.














<img width="225" height="225" alt="image" src="https://github.com/user-attachments/assets/62d5592a-c6bb-4faa-b33f-aa9b7e1ef7c0" />




