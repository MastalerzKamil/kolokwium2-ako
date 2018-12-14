.686
.model flat
public _komunikat
extern _ExitProcess@4 : PROC
extern _malloc : PROC

.data
dlugosc_tekstu	dd 0
blad			db  'B³¹d', 0
.code
_komunikat PROC
	push ebp
	mov ebp, esp
	push ebx
	push esi
	push edi

	mov esi, [ebp+8]	; adres tekst
	mov edi, esi	; do SCASB
	mov al, 0
	cld	; aby edi roslo w SCASB
	repne scasb	;  iteruj po tekscie w celu znalezienia dlugosci tekstu (zakonczonego 0). zwiekszaj edi w tym celu
	sub edi, esi	; oblicz dlugosc tekstu
	add edi, 6	; zwieksz dlugosc tekstu o miejsce na dopisek "B³¹d."
	mov dlugosc_tekstu, edi	; zapamietaj dlugosc tekstu
	push edi	; char zajmuje 1 bajt
	call _malloc
	add esp, 4	; zwolnienia pamieci zgodnie ze standardem C
; w eax adres wynikowego tekstu
	mov edi, eax	;aby uzyc movsb
	mov ecx, dlugosc_tekstu
	sub ecx, 6	; zmniejsz indeks o dlugosc dopisku
	rep movsb	; kopiowanie z *tekst do wydzielonego bloku pamieci
	mov ecx, dlugosc_tekstu	; przywroc ecx aby zapisac dalej
	sub ecx, 6
; edi jest zwiekszone po poprzednim rozkazie  REPNZ
	mov esi, offset blad
	mov ecx, 6	; zapisz do ecx rozmiar dopisku
	rep movsb	; dopisz dopisek "B³¹d." edi jest ustawione po poprzednim MOVSB
	pop edi
	pop esi
	pop ebx
	pop ebp
	ret
_komunikat ENDP
END
