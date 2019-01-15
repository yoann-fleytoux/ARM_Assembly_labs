@ S/P comparerChaine
	.include "defTypes.s"
@ parametres
	.equiv	ch1, 8		@ entrée, passage par valeur
	.equiv	ch2, 16		@ entrée, passage par valeur
	.equiv	ptRep, 24	@ entrée, passage par valeur

	.global	comparerChaine
comparerChaine:
	stmfd	sp!, {r0-r3}
	stmfd	sp!, {r4-r9}
	stmfd	sp!, {fp, lr}
	mov	fp, sp

.Lsi1:
	cmp r0, r2
	bgt	.Lsin1
	mov r4, r0
	b .Lfsi1
.Lsin1:
	mov r4, r2
.Lfsi1:

	mov r6, #0

.Ltq1:
	cmp r6, #0
	bne .Lftq1
.Lsi2:
	cmp r4, #0
	ble .Lsin2
.Lsi3:
	ldrb r7, [r1]
	ldrb r8, [r3]
	cmp r7, r8
	bne .Lsin3
	add r1, r1, #1
	add r3, r3, #1
	sub r4, r4, #1
	b .Lfsi3
.Lsin3:
	mov r6, #1
.Lfsi3:
	b .Lfsi2
.Lsin2:
	mov r6, #1
.Lfsi2:
	b .Ltq1
.Lftq1:
	
.Lsi4:
	cmp r4, #0
	beq .Lsin4
.Lsi5:
	ldrb r7, [r1]
	ldrb r8, [r3]
	cmp r7, r8
	ble .Lsin5
	mov r9, #1
	b .Lfsi5
.Lsin5:
	mov r9, #-1
.Lfsi5:
	b .Lfsi4
.Lsin4:
.Lsi6:
	cmp r0, r2
	bne .Lsin6
	mov r9, #0
	b .Lfsi6
.Lsin6:
.Lsi7:
	cmp r0, r2
	ble .Lsin7
	mov r9, #1
	b .Lfsi7
.Lsin7:
	mov r9, #-1
.Lfsi7:
.Lfsi6:
.Lfsi4:

	mov r0, r9

	mov	sp, fp
	ldmfd	sp!, {fp, lr}
	ldmfd	sp!, {r4-r9}
	add	sp, sp,	#4*4
	mov	pc, lr
