@ S/P extraireSousChaine
	.include "defTypes.s"
@ parametres
	.equiv	ch1, 8		@ mise-à-jour, passage par adresse
	.equiv	ch2, 12		@ entrée, passage par valeur
	.equiv	p, 20		@ entrée, passage par valeur
	.equiv	lg, 24 	@ entree, passage par valeur
	.equiv	ptRep, 28	@ entrée, passage par valeur
@ variables locales
	.equiv	ptrAlloc, -4
	.equiv	lgCh2, -8
	.equiv	lgSousCh2, -12
	
	.section .rodata
ERR_ALLOC:
	.asciz	"**** erreur malloc"
ERR_PARAM:
	.asciz	"**** erreur parametre"

	.text
	.align	2
.CERR_ALLOC:
	.word	ERR_ALLOC
.CERR_PARAM:
	.word	ERR_PARAM

	.global	extraireSousChaine
extraireSousChaine:
	stmfd	sp!, {r0-r3}
	stmfd	sp!, {fp, lr}
	mov	fp, sp
	sub	sp, sp, #3*4

	str r1, [fp, #lgCh2]

.Lsi1:
	cmp r3, #1
	blt	.Lsin1
	cmp r3, r1
	bgt	.Lsin1
	ldr r0, [fp, #lg]
	cmp r0, #0
	blt .Lsin1
	b	.Lfsi1
.Lsin1:
	ldr	r0, [fp, #ptRep]
	ldr	r1, .CERR_PARAM
	bl	longjmp
.Lfsi1:

	sub r1, r1, r3
	add r1, r1, #1

.Lsi2:
	cmp r1, r0
	ble	.Lfsi2
.Lsin2:
	mov r1, r0
.Lfsi2:

	str r1, [fp, #lgSousCh2]
	
.Lsi3:
	cmp r1, #0
	bne	.Lsin3
	mov r3, #NULL
	str r3, [fp, #ptrAlloc]
	b	.Lfsi3
.Lsin3:
	mov r0, r1
	bl malloc
	str r0, [fp, #ptrAlloc]
.Lsi3_1:
	cmp r0, #NULL
	bne .Lfsi3_1
	ldr	r0, [fp, #ptRep]
	ldr	r1, .CERR_ALLOC
	bl	longjmp
.Lfsi3_1:
	ldr r1, [fp, #ch2+ptrCar]
	ldr r3, [fp, #p]
	add r1, r1, r3
	sub r1, r1, #1
	ldr r2, [fp, #lgSousCh2]
	bl memcpy
.Lfsi3:

	ldr	r0, [fp, #ch1+ptrCar]

.Lsi4:
	cmp r0, #NULL
	beq .Lfsi4
	bl free
.Lfsi4:

	ldr r0, [fp, #ch1]
	ldr r1, [fp, #lgSousCh2]
	str r1, [r0, #nbCar]
	ldr r2, [fp, #ptrAlloc]
	str r2, [r0, #ptrCar]

	mov	sp, fp
	ldmfd	sp!, {fp, lr}
	add	sp, sp,	#4*4
	mov	pc, lr
