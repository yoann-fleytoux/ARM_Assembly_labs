@ S/P creerChaineVide

	.include "defTypes.s"
@ parametres
@ ro <=> ch : passage par adresse

	.text
	.align	2

	.global	creerChaineVide
creerChaineVide:
	mov	r1, #0
	str	r1, [r0, #nbCar]
	mov	r1, #NULL
	str	r1, [r0, #ptrCar]
	mov     pc, lr
