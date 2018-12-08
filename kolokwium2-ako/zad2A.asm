.686
.model flat
public _kopia_tablicy
extern _malloc PROC

.data
.code

_kopia_tablicy PROC
	push ebp
	mov ebp, esp
	push esi
	push edi
	push ebx
	push ecx

	mov ecx, [ebp+12]	; n
	mov esi, [ebp+8]	; tabl
	push ecx	; argument do malloca
	call _malloc
	add esp, 4
; w eax adres nowej tablicy
	cmp eax, 0
	jz koniec_programu
	mov ecx, [ebp+12]	; potrzebne do petli
ptl:
	mov ebx, [esi+4*ecx]	; wartosc z tablicy
	bt ebx, 0	; sprawdzenie czy parzysta
	jnc nie_parzysta
	clc
	mov [esi], ebx	; zapis do tablicy parzystych
	add esi, 4	; bo kazda liczba zajmuje 4 bajty
nie_parzysta:
	dec ecx
	jnz ptl
koniec_programu:
	pop ecx
	pop ebx
	pop edi
	pop esi
	ret
_kopia_tablicy ENDP