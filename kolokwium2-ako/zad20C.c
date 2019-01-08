#include <stdio.h>
#include <windows.h>

unsigned int liczba_procesorow(SYSTEM_INFO* siSysInfo);
SYSTEM_INFO info;

int main()
{
	
	unsigned int wynik = liczba_procesorow(&info);
	printf("ilosc procesorow %d", wynik);
	return 0;
}