#include <stdio.h>

typedef unsigned int MIESZ32;

float miesz2float(MIESZ32 p);

int main()
{
	MIESZ32 a = 0x00000180;			// 1.5
	MIESZ32 a2 = 0x00000980;			// 9.5
	MIESZ32 a3 = 0x00000040;			// 0.25
	float fa = miesz2float(a);
	float fa2 = miesz2float(a2);
	float fa3 = miesz2float(a3);
	printf("%f, %f, %f\n", fa, fa2, fa3);
	return 0;
}