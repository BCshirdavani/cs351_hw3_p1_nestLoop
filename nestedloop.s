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
i: .word 1
j: .word 1
return: .word 0
blank: .asciz "_"
blankO: .asciz "-"
star: .asciz "*"
formatStr: .asciz "%d"
newline: .asciz "\n"

/* Code Section */
.text
.global main
main:
	ldr r1, addrOfReturn
	str lr, [r1]
    b test_1

@ first outer loop, ROWS
loop_1:
    @ ldr r1, addrOfReturn
	@ str lr, [r1]
    @ reset j = i for loop_2
    ldr r5, addrOfI
    ldr r6, [r5] 
    ldr r7, addrOfJ
    str r6, [r7]
    b test_2

    loop_2:
        @ print blank
        ldr r0, addrOfBlankO
        push {lr}
        bl printf
        pop {lr}
        @ j++
        ldr r5, addrOfJ
        ldr r6, [r5]
        add r6, r6, #1
        str r6, [r5]

    test_2:
        @ if j < 8
        ldr r5, addrOfJ
        ldr r6, [r5]
        cmp r6, #8
        blt loop_2

    @ j = 1 , to start final loop
    ldr r5, addrOfJ
    ldr r6, [r5]
    mov r6, #1
    str r6, [r5]
    b test_3

    loop_3:
        ldr r5, addrOfI
        ldr r6, [r5]
        ldr r7, addrOfJ
        ldr r8, [r7]

        @ cond_1: (i == rows)
        cmp r6, #8
        beq starPrint
        @ cond_2: (j == 1)
        cmp r8, #1
        beq starPrint
        @ cond_3: (j == 2*i-1)
        cmp r7, r8
        beq starPrint
        @ cond_else: print blank, and skip starPrint
        ldr r0, addrOfBlank
        push {lr}
        bl printf
        pop {lr}
        @ j++
        ldr r5, addrOfJ
        ldr r6, [r5]
        add r6, r6, #1
        str r6, [r5]
        b test_3

        starPrint:
            @ print the star
            ldr r0, addrOfStar
            push {lr}
            bl printf
            pop {lr}
            @ j++
            ldr r5, addrOfJ
            ldr r6, [r5]
            add r6, r6, #1
            str r6, [r5]


    test_3:
        @ for(j = 1; j <= (2*i-1); j++)
        ldr r5, addrOfJ
        ldr r6, [r5]
        @ (2 * i - 1)
        ldr r7, addrOfI
        ldr r8, [r7]
        mov r8, r8, LSL #1
        sub r8, r8, #1 
        @ if ( j <= 2*i-1 )
        cmp r6, r8
        ble loop_3


    @ print newline
    ldr r0, addrOfNewline
    push {lr}
    bl printf
    pop {lr}
    @ i++
    ldr r5, addrOfI
    ldr r6, [r5]
    add r6, r6, #1
    str r6, [r5]

@ test for ROW loop
test_1:
    @ was i < 8, changed to <= 8
    @ if i <= 8
    ldr r5, addrOfI
    ldr r6, [r5]
    cmp r6, #8
    ble loop_1  @ was blt, now ble

end:
    bx lr

.global printf

addrOfI: .word i
addrOfJ: .word j
addrOfReturn: .word return
addrOfBlank: .word blank
addrOfBlankO: .word blankO
addrOfStar: .word star
addrOfFormatStr: .word formatStr
addrOfNewline: .word newline
