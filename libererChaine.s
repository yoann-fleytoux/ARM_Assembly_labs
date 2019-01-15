@ S/P libererChaine

	.include "defTypes.s"

@ parametres
@ r0 <=> ch : passage par adresse

	.text
	.align	2

	.global	libererChaine
libererChaine:
	stmfd	sp!, {r4, lr}
	mov	r4, r0
	ldr	r0, [r4, #ptrCar]
	bl	free
	mov	r1, #0
	str	r1, [r4, #nbCar]
	mov	r1, #NULL
	str	r1, [r4, #ptrCar]
	ldmfd	sp!, {r4, pc}
