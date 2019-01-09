#include <stdio.h>
#include <wchar.h>

wchar_t* ASCII_na_UTF16(char* znaki, int n);

int main() {
	char* tekst = "123456789";
	wchar_t* tekst3 = ASCII_na_UTF16(tekst, 9);
	printf("%s", tekst3);
	return 0;
}