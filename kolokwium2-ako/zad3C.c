#include <stdio.h>

char* komunikat(char* tekst);

int main()
{
	char* tekst = komunikat("slowo");
	printf("wynik: %s\n", tekst);
	return 0;
}