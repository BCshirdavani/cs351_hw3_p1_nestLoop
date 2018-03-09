/*----------------------------------------------
/
/	Author:		Beau Shirdavani
/	Date:		March 6, 2018
/	Description:	CS 351
/			HW 03 part 1
/			nested loop with ARM
/
/----------------------------------------------*/

/* Data Section */
.data
i: .word 0
j: .word 0
return: .word 0
blank: .asciz "_"
star: .asciz "*"
formatStr: .asciz "%d"


/* Code Section */

.text
.global main
main:
	ldr r1, addrOfReturn
	str lr, [r1]
	
loopRow:
	ldr r0, addrOfBlank	/* print leading blank	*/
	bl printf		/* print leading blank	*/		
	ldr r3, addrOfI		/* i++	*/
	ldr r5, [r3]		/* i++	*/
	add r5, r5, #1		/* i++	*/
	str r5, [r3]
	cmp r5, #8		/* (i < 8)	*/
	blt loopRow	

	ldr r1, addrOfReturn
	ldr lr, [r1]

bx lr

.global printf

addrOfI: .word i
addrOfJ: .word j
addrOfReturn: .word return
addrOfBlank: .word blank
addrOfStar: .word star
addrOfFormatStr: .word formatStr
