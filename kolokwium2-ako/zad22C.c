// #include <stdio.h>
// 
// __int64 sortowanie(unsigned __int64* tab, unsigned int n);
// 
// #define ROZMIAR 5
// 
// int main()
// {
// 	__int64 tab[ROZMIAR] = { 312, 0x7FFFFFFFFFFFFFFF, 0x7FFFFFFFFFFFFFF1,  0x7FFFFFFFFFFFFFF5, 0x7FFFFFFFFFFFFFF7 };
// 	printf("dane \n");
// 	for (int i = 0; i < ROZMIAR; i++)
// 	{
// 		printf("%llx, ", tab[i]);
// 	}
// 	printf("\Max: ");
// 	printf("%llx", sortowanie(tab, ROZMIAR));
// 	printf("\nPo sortowaniu\n");
// 	for (int i = 0; i < ROZMIAR; i++)
// 	{
// 		printf("%llx, ", tab[i]);
// 	}
// 	return 0;
// }