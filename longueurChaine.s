@ S/P longueurChaine

	.include "defTypes.s"

@ parametres
@ r0 <=> ch.nbCar   : passage par valeur
@ r1 <=> ch.ptrCar  : passage par valeur

	.text
	.align	2

	.global longueurChaine
longueurChaine:
	mov	pc, lr
