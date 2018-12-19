#include <stdio.h>

int* szukaj_elem_min(int tablica[], int n);

int main()
{
	int pomiary[7] = {6,7,4,0,2,1,1};
	int* wsk;
	wsk = szukaj_elem_min(pomiary, 7);
	printf("\nElement minimalny = %d\n", *wsk);
	return 0;
}