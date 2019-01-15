@ S/P entrerChaine
	.include "defTypes.s"
@ parametres
	.equiv	ch, 8		@ mise-à-jour, passage par adresse
	.equiv	fic, 12		@ entrée, passage par adresse
	.equiv	lg, 16		@ entrée, passage par valeur
	.equiv	ptRep, 20 	@ entree, passage par valeur
@ variables locales
	.equiv	ptrAlloc, -4
	
	.section .rodata
ERR_ALLOC:
	.asciz	"**** erreur malloc"
ERR_FIC:
	.asciz	"**** erreur fichier"
ERR_PARAM:
	.asciz	"**** erreur parametre"

	.text
	.align	2
.CERR_ALLOC:
	.word	ERR_ALLOC
.CERR_FIC:
	.word	ERR_FIC
.CERR_PARAM:
	.word	ERR_PARAM

	.global	entrerChaine
entrerChaine:
	stmfd	sp!, {r0-r3}
	stmfd	sp!, {fp, lr}
	mov	fp, sp
	sub	sp, sp, #1*4

.Lsi1:
	cmp r2, #0
	blt	.Lsin1
	b	.Lfsi1
.Lsin1:
	ldr	r0, [fp, #ptRep]
	ldr	r1, .CERR_PARAM
	bl	longjmp
.Lfsi1:

.Lsi2:
	cmp r2, #0
	beq	.Lsin2
	b	.Lfsi2
.Lsin2:
	bl	libererChaine
.Lfsi2:
	mov	r0, r2
	add	r0, r0, #1
	bl	malloc
	str	r0, [fp, #ptrAlloc]
	
.Lsi3:
	cmp r0, #NULL
	beq	.Lsin3
	b	.Lfsi3
.Lsin3:
	ldr	r0, [fp, #ptRep]
	ldr	r1, .CERR_ALLOC
	bl	longjmp
.Lfsi3:
	ldr	r1, [fp, #lg]
	add	r1, r1, #1
	ldr r2, [fp, #fic]
	bl	fgets
	
.Lsi4:
	cmp r0, #NULL
	beq	.Lsin4
	b	.Lfsi4
.Lsin4:
	ldr	r0, [fp, #ptrAlloc]
	bl	free
	ldr	r0, [fp, #ptRep]
	ldr	r1, .CERR_FIC
	bl	longjmp
.Lfsi4:
	ldr	r0, [fp, #ch]
	ldr	r1, [fp, #ptrAlloc]
	ldr	r2, [fp, #ptRep]
	bl	convertirChaine
	ldr	r0, [fp, #ptrAlloc]
	bl	free

	mov	sp, fp
	ldmfd	sp!, {fp, lr}
	add	sp, sp,	#4*4
	mov	pc, lr
