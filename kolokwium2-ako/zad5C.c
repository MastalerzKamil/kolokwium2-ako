#include <stdio.h>

void szyfruj(char* tekst);

int main()
{
	char* tekst = "ako";
	szyfruj(tekst);
	printf("zaszyfrowany: %s\n",tekst);
	return 0;
}