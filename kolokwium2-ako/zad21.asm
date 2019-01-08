.686
.model flat
public _float_razy_float

.data
.code
_float_razy_float PROC
	push ebp
	mov ebp, esp
	push ebx
	push esi
	push edi

; cala operacja polega na pomnozeniu mantys i dodaniu wykladnikow

; wydobycie wykladnikow
	mov esi, [ebp+8]	; a
	mov edi, [ebp+12]	; b
	shl esi, 1	; wykasuj bit znaku
	shr esi, 24	; wydobadz znormalizowany wykladnik a
	sub esi, 127
	shl edi, 1
	shr edi, 24
	sub edi, 127	; usuniecie normalizacji z b
	add esi, edi
	add esi, 127
	push esi	; zapamietaj wykladnik wynikowy

; dodawanie matys
	mov esi, [ebp+8]	; a
	mov edi, [ebp+12]	; b
	shl esi, 9
	shr esi, 9	; wydobadz mantyse a
	shl edi, 9
	shr edi, 9

	add esi, 00800000h	; dodanie niejawnych jedynek
	add edi, 00800000h

	mov eax, 0
	mov edx, 0
	mov eax, esi	; iloczyn do eax
	mul edi	; pomnoz mantysy. Wynik w EDX:EAX
	bt edx, 15 ;sprawdzenie czy wynik jest wiekszy lub rowny 2
	jnc wieksza_od_2

wieksza_od_2:
	push edx
	shr eax, 23	; przesun w celu zminimalizowania do rozmiaru float (32-bitow)
	shl edx, 9	; zostawiam miejsce na bit znaku
	or eax, edx
	pop edx
	and eax, 007FFFFFh

	pop ebx	; zdejmij wykladnik wynikowy
	shl ebx, 23	; przesun wykladnik na jego miejsce (przed bitem znaku)

	or eax, ebx
; ustawianie bitu znaku
	mov esi, [ebp+8]
	mov edi, [ebp+12]
	shl esi, 31
	shr esi, 31
	shl edi, 31
	shr edi, 31
	xor esi, edi	; dodanie bitu znaku wynikowego
	or eax, esi
	push eax
	fld dword ptr [esp]
	add esp, 4
	pop edi
	pop esi
	pop ebx
	pop ebp
	ret
_float_razy_float ENDP
END