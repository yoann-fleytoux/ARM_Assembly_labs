/* fichier d'entete pour la bibliotheque de traitement */
/* des chaines de caracteres de type ChaineDyn  */

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <setjmp.h>

/* definition du type chaine de caracteres ChaineDyn */

typedef char * PointeurCar;

typedef struct
{
    int nbCar;
    PointeurCar ptrCar;
} ChaineDyn;


/* prototypes des S/P de la bibliotheque    */

void creerChaineVide (ChaineDyn * ch) ;

void convertirChaine (ChaineDyn * ch1, const char * ch2, jmp_buf ptRep) ;

int longueurChaine (const ChaineDyn ch) ;

void copierChaine (ChaineDyn * ch1, const ChaineDyn ch2, jmp_buf ptRep) ; 

void collerChaine (ChaineDyn * ch1, const ChaineDyn ch2, jmp_buf ptRep) ;

int comparerChaine (const ChaineDyn ch1, const ChaineDyn ch2) ;

void extraireSousChaine (ChaineDyn * ch1, const ChaineDyn ch2, const int p, const int n, jmp_buf ptRep) ;

void entrerChaine (ChaineDyn * ch1, FILE * f, const int n, jmp_buf ptRep) ; 

void sortirChaine (const ChaineDyn ch1, FILE * f, jmp_buf ptRep) ; 

void libererChaine (ChaineDyn * ch) ;

