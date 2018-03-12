/*----------------------------------------------
/
/	Author:		Beau Shirdavani
/	Date:		March 6, 2018
/	Description:	CS 351
/			HW 03 part 1
/			nested loop with ARM - v2
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

	@ if (i <= (2*i-1) : go to loop for inner pyramid
	ldr r7, addrOfI
	ldr r8, [r7]	
	@ mul r8, r8, #2	/* 	2*i		*/
	@ add r8, #0, r8, LSL #1	/* 	2*i		*/
	mov r8, r8, LSL #1	/* 	2*i		*/
	sub r8, r8, #1	/* 	2*i-1	*/
	ldr r9, addrOfJ
	ldr r10, [r9]
	cmp r10, r8
	ble inPYRloop	/*	loop while j <= 2*i-1	*/

	ldr r0, addrOfNewline	/* print newline for each row	*/
	bl printf		    /* print newline for each row	*/		
	ldr r3, addrOfI		/* i++	*/
	ldr r5, [r3]		/* i++	*/
	add r5, r5, #1		/* i++	*/
	str r5, [r3]
	ldr r2, addrOfJ		/* j = i for inner col loop	*/
	str r5, [r2]		/* j = i for inner col loop	*/
	cmp r5, #8		    /* (i < 8)	*/
	blt loopRow	
    b beforeend

	@ inner pyramid loop
	inPYRloop:
		@ if (i == 8) print star
		ldr r5, addrOfI
		ldr r6, [r5]
		cmp r6, #8
		beq starPRINTER
		@ if (j == 1) print star
		ldr r5, addrOfJ
		ldr r6, [r5]
		cmp r6, #1
		beq starPRINTER
		@ if (j == 2*i-1) print star
		ldr r5, addrOfJ
		ldr r6, [r5] 
		ldr r7, addrOfI
		ldr r8, [r7]
		@ mul r8, r8, #2
		@ add r8, #0, r8, LSL #1	/* 	2*i		*/
		mov r8, r8, LSL #1	/* 	2*i		*/
		sub r8, r8, #1
		cmp r6, r8
		beq starPRINTER
		@ else print blank
		push {lr}
		ldr r0, addrOfBlank
		bl printf
		pop {lr}
		endINpyramid:
		b end

			@ print stars from conditions of inner loop
			starPRINTER:
				push {lr}
				ldr r0, addrOfStar
				bl printf
				pop {lr}
				b endINpyramid 	/*	exit the inner loop, without printing spaces	*/

loopLblank:
        push {lr}
        ldr r0, addrOfBlank     /* load blank char      */
        bl printf               /* print blank          */
        pop {lr}

        ldr r3, addrOfJ         /* j++  */
        ldr r5, [r3]            /* j++  */
        add r5, r5, #1          /* j++  */
        str r5, [r3]
        cmp r5, #8              /* (j < 8)      */
        blt loopLblank

        @ printPYRAMID:
        @         push {lr}
        @         ldr r0, addrOfStar
        @         bl printf
        @         pop {lr}

        b end


beforeend:
    ldr r1, addrOfReturn
    ldr lr, [r1]
	
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
