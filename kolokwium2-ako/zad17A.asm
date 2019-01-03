.686
.model flat
public _avg_wd

.data
.code
_avg_wd PROC
	push ebp
	mov ebp, esp
	push ebx
	push esi
	push edi
	push ecx
	mov ebx, [ebp+8] ; n
	mov esi, [ebp+12] ; tablica
	mov edi, [ebp+16]	; wagi
	mov ecx, 0
	finit
	fldz	; st(0) = wynik
mnoz_wagi:	; Sum from i=0 to n waga(i)*tablica(i)
	fld dword PTR [esi+ 4*ecx]
; st(0)= tablica	st(1)=wynik
	fld dword PTR [edi+4*ecx]
; st(0)=wagi	st(1)=tablica	st(2)=wynik
	fmulp st(1), st(0)
; st(0)=wagi*tablica	st(1)=wynik
	faddp st(1), st(0)
	inc ecx
	cmp ecx, ebx
	jnz mnoz_wagi
; st(0)=wynik_licznik
	fldz
; st(0)=wynik_mianownika	st(1)=wynik_licznika
	mov ecx, 0
dodawaj_wagi:
	fadd dword PTR [edi+4*ecx]	; dodaj na st(0) kolejna wage
	inc ecx
	cmp ecx, ebx
	jnz dodawaj_wagi
	fdivp st(1), st(0)	; podziel licznik przez mianownik i zdejmij mianownik (st(0) przed dzieleniem)

	pop ecx
	pop edi
	pop ebx
	pop ebp
	ret
_avg_wd ENDP
END