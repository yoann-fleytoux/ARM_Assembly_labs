#
# makefile pour la compilation separee des TP ARM
#
# fichier de directives pour generer le programme de test: testChaine
#
EXE = testChaine

LISTE1 = creerChaineVide.o convertirChaine.o libererChaine.o
LISTE2 = longueurChaine.o copierChaine.o collerChaine.o sortirChaine.o
LISTE3 = entrerChaine.o extraireSousChaine.o comparerChaine.o
OBJETS = ${EXE}.o ${LISTE1} ${LISTE2} ${LISTE3}

#
# production du fichier executable
#
${EXE}: ${OBJETS}
	arm-elf-gcc -g ${OBJETS} -o ${EXE}

#
# compilation du fichier C
#
${EXE}.o: ${EXE}.c chaine.h
	arm-elf-gcc -c -g ${EXE}.c

#
# assemblage des fichiers ASSEMBLEUR
#
    
creerChaineVide.o: creerChaineVide.s defTypes.s
	arm-elf-as -g creerChaineVide.s -o creerChaineVide.o
    
convertirChaine.o: convertirChaine.s defTypes.s
	arm-elf-as -g convertirChaine.s -o convertirChaine.o

libererChaine.o: libererChaine.s defTypes.s
	arm-elf-as -g libererChaine.s -o libererChaine.o

longueurChaine.o: longueurChaine.s defTypes.s
	arm-elf-as -g longueurChaine.s -o longueurChaine.o

copierChaine.o: copierChaine.s defTypes.s
	arm-elf-as -g copierChaine.s -o copierChaine.o

sortirChaine.o: sortirChaine.s chaine.h
	arm-elf-as -g sortirChaine.s -o sortirChaine.o

entrerChaine.o: entrerChaine.s chaine.h
	arm-elf-as -g entrerChaine.s -o entrerChaine.o

extraireSousChaine.o: extraireSousChaine.s chaine.h
	arm-elf-as -g extraireSousChaine.s -o extraireSousChaine.o

comparerChaine.o: comparerChaine.s chaine.h
	arm-elf-as -g comparerChaine.s -o comparerChaine.o
	
#
# compilation des fichiers C
#

collerChaine.o: collerChaine.c chaine.h
	arm-elf-gcc -c -g collerChaine.c

#sortirChaine.o: sortirChaine.c chaine.h
#	arm-elf-gcc -c -g sortirChaine.c

#entrerChaine.o: entrerChaine.c chaine.h
#	arm-elf-gcc -c -g entrerChaine.c

#extraireSousChaine.o: extraireSousChaine.c chaine.h
#	arm-elf-gcc -c -g extraireSousChaine.c

#comparerChaine.o: comparerChaine.c chaine.h
#	arm-elf-gcc -c -g comparerChaine.c

