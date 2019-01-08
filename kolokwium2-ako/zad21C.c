#include <stdio.h>

float float_razy_float(float a, float b);

int main()
{
	float a = -2.5;
	float b = -2.0;

	float a2 = 0.25;
	float b2 = 2.0;

	float a3 = 25.25;
	float b3 = 4.0;
	float wynik = float_razy_float(a, b);
	float wynik2 = float_razy_float(a2, b2);
	float wynik3 = float_razy_float(a3, b3);
	printf("-2 * -2.5 = %f\n", wynik);
	printf("0.25 * 2.0 = %f\n", wynik2);
	printf("25.25 * 4.0 = %f\n", wynik3);

	return 0;
}