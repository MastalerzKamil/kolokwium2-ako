.686
.model flat
public _main
extern _ExitProcess@4 : PROC

.data
test_float			dd 12.25
mantysa				dq 0
double_wykladnik	dw 0
znak				dw 0
liczba_double		dw 4 dup (?)
.code
_main PROC
	mov esi, offset test_float
	mov edx, [esi]
	bt edx, 31
	jnc dodatnia
	mov znak, 8000h	; ustaw bit znaku jako ujemny (najstarszy bit jako 1)
dodatnia:
	mov eax, [esi]
	shl eax, 1 ; wymazanie znaku z edi
	shr eax, 24 ; wymazanie mantysy z edi
	sub eax, 127	; wyciagniecie przesuniecia
	add eax, 1023	; stworz wykladnik double
	mov double_wykladnik, ax
; tworzenie mantysy
	mov eax, [esi]
	shl eax, 9	; wymazanie wykladnika i znaku z zrodlowej liczby
	mov dword PTR mantysa, eax	; zapisz mantyse ktora sie nie zmienia
	mov eax, 0
	mov ax,  double_wykladnik
	shl ax, 4	; zostaw miejesce na znak. Po wyonaniu sytuacja 0xxxxxxxxxxx0000
	mov bx, word ptr double_wykladnik
	sal bx, 4	;uzupelnij ax pierwszymi 4 bitami
	and bx, 000Fh	; maska dla 4 bitow
	or ax, bx	; zlacz 4 bity i zapisz w ax
	or ax, znak	; sklej symbol znaku z 0wwwwwwwwwwwmmmm
	mov edi, offset liczba_double
	mov [edi], ax	; przenies ax do obszaru pamieci ze skonwertowana liczba
	mov eax, dword PTR mantysa
	shl eax, 4	; 4 bity zostaly juz zapisane
	mov [edi+2], eax	; zapisz pozostale bity mantysy
	mov eax, 0
	mov [edi+6], ax	; double zajmuje 64 bity wiec w pozostale miejsca wpisz 0
	push 0
	call _ExitProcess@4
_main ENDP
END