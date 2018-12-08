.686
.model flat
public _kopia_tablicy
extern _malloc: PROC

.data
rozmiar_liczby	dw 4
rozmiar_tablicy	dd ?
.code
_kopia_tablicy PROC
	push ebp
	mov ebp, esp
	push esi
	push edi
	push ebx
	push ecx
	push edx

	mov ecx, [ebp+12]	; n
	mov esi, [ebp+8]	; tabl
	mov ax, cx
	mul rozmiar_liczby	; bo tyle zajmuje jedna liczba
	mov rozmiar_tablicy, eax	; zapamietanie rozmiary w docelowej tablicy 
	push eax	; argument do malloca
	call _malloc
	add esp, 4
; w eax adres nowej tablicy
	cmp eax, 0
	jz koniec_programu
	mov ecx, 0	; potrzebne do petli
	mov edi, eax	; docelowy adres zapisu
ptl:
	mov ebx, [esi+4*ecx]	; wartosc z tablicy
	bt ebx, 0	; sprawdzenie czy parzysta
	jc nie_parzysta
	clc
	mov [edi], ebx	; zapis do tablicy parzystych
	add edi, 4
nie_parzysta:
	inc ecx
	cmp ecx, rozmiar_tablicy
	jnz ptl
koniec_programu:
	pop edx
	pop ecx
	pop ebx
	pop edi
	pop esi
	pop ebp
	ret
_kopia_tablicy ENDP
END