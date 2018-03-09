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
newline: .asciz "\n"

/* Code Section */

.text
.global main
main:
	ldr r1, addrOfReturn
	str lr, [r1]
	
loopRow:
	ldr r3, addrOfI		/* j = i for inner col loop	*/
	ldr r4, [r3]		/* j = i for inner col loop	*/
	ldr r3, addrOfJ		/* j = i for inner col loop	*/
	str r4, [r3]		/* j = i for inner col loop	*/
	bl loopLblank		/* send to loop for leading blanks	*/

	ldr r0, addrOfNewline	/* print newline for each row	*/
	bl printf		/* print newline for each row	*/		
	ldr r3, addrOfI		/* i++	*/
	ldr r5, [r3]		/* i++	*/
	add r5, r5, #1		/* i++	*/
	str r5, [r3]
	ldr r2, addrOfJ		/* j = i for inner col loop	*/
	str r5, [r2]		/* j = i for inner col loop	*/
	cmp r5, #8		/* (i < 8)	*/
	blt loopRow	

	ldr r1, addrOfReturn
	ldr lr, [r1]


loopLblank:
	ldr r0, addrOfBlank	/* load blank char	*/
	bl printf		/* print blank		*/
	ldr r3, addrOfJ		/* j++	*/
	ldr r5, [r3]		/* j++	*/
	add r5, r5, #1		/* j++	*/
	str r5, [r3]
	cmp r5, #8		/* (j < 8)	*/
	blt loopLblank
	
	/* finish the inner pyramid conditionals here */
	
end:
	bx lr

.global printf

addrOfI: .word i
addrOfJ: .word j
addrOfReturn: .word return
addrOfBlank: .word blank
addrOfStar: .word star
addrOfFormatStr: .word formatStr
addrOfNewline: .word newline
