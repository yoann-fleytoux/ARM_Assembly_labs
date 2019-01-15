@ S/P sortirChaine
	.include "defTypes.s"
@ parametres
@	.equiv	ch, 8		@ entree, passage par valeur, inutile
@	.equiv	fic, 16		@ mise-à-jour, passage par adresse, inutile
	.equiv	ptRep, 20 	@ entree, passage par valeur
	
	.section .rodata
ERR_FIC:
	.asciz	"**** erreur fichier"

	.text
	.align	2
.CERR_FIC:
	.word	ERR_FIC

	.global	sortirChaine
sortirChaine:
	stmfd	sp!, {r0-r3}
	stmfd	sp!, {fp, lr}
	mov	fp, sp

	mov	r3, r0
	mov	r0, r1
	mov	r1, r3
	mov r3, r2
	mov	r2, #1
	bl	fwrite

.Lsi1:
	cmp	r0, #1
	bne	.Lsin1
	b	.Lfsi1
.Lsin1:
	ldr	r0, [fp, #ptRep]
	ldr	r1, .CERR_FIC
	bl	longjmp
.Lfsi1:

	mov	sp, fp
	ldmfd	sp!, {fp, lr}
	add	sp, sp,	#4*4
	mov	pc, lr
