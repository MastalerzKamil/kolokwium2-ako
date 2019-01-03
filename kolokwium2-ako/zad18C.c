#include <stdio.h>


unsigned int NWD(unsigned int a, unsigned int b);
unsigned int NWD_C(unsigned int a, unsigned int b)
{
	unsigned int wyn;
	if (a == b) wyn = a;
	else if (a > b) wyn = NWD(a - b, b);
	else wyn = NWD(a, b - a);
	return wyn;
}



int main()
{
	int a = 75, b = 69;
	printf("%d\n", NWD(a, b));
	printf("%d", NWD_C(a, b));

	return 0;
}