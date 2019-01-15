@ S/P convertirChaine
	.include "defTypes.s"
@ parametres
	.equiv	ch1, 8		@ mise a jour, passage par adresse
	.equiv	ch2, 12		@ entree, passage par adresse (tableau)
	.equiv	ptRep, 16 	@ entree, passage par valeur
@ variables locales
	.equiv	lgCh2, -4
	.equiv	ptrAlloc, -8

	.section .rodata
ERR_ALLOC:
	.asciz	"**** erreur malloc"

	.text
	.align	2
.CERR_ALLOC:
	.word	ERR_ALLOC

	.global	convertirChaine
convertirChaine:
	stmfd	sp!, {r0-r2}
	stmfd	sp!, {fp, lr}
	mov	fp, sp
	sub	sp, sp, #2*4

	ldr	r0, [fp, #ch2]
	bl	strlen
	str	r0, [fp, #lgCh2]
.Lsi1:
	cmp	r0, #0
	bne	.Lsin1
	mov	r1, #NULL
	str	r1, [fp, #ptrAlloc]
	b	.Lfsi1
.Lsin1:
	bl	malloc
	str	r0, [fp, #ptrAlloc]
.Lsi2:
	cmp	r0, #NULL
	bne	.Lfsi2
	ldr	r0, [fp, #ptRep]
	ldr	r1, .CERR_ALLOC
	bl	longjmp
.Lfsi2:
	ldr	r1, [fp, #ch2]
	ldr	r2, [fp, #lgCh2]
	bl	memcpy
.Lfsi1:
.Lsi3:
	ldr	r0, [fp, #ch1]
	ldr	r0, [r0, #ptrCar]
	cmp	r0, #NULL
	beq	.Lfsi3
	bl	free
.Lfsi3:
	ldr	r0, [fp, #ch1]
	ldr	r1, [fp, #lgCh2]
	str	r1, [r0, #nbCar]
	ldr	r2, [fp, #ptrAlloc]
	str	r2, [r0, #ptrCar]

	mov	sp, fp
	ldmfd	sp!, {fp, lr}
	add	sp, sp,	#3*4
	mov	pc, lr
