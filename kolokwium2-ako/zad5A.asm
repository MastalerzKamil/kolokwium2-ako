.686
.model flat
public _szyfruj

.data
klucz		dd 52525252h
dzielnik	db 2 

.code
_szyfruj PROC
	push ebp
	mov ebp, esp
	push ebx
	push edi
	push esi
	push edx

	mov esi, [ebp+8]	; *tekst

	mov al, 0	; do porownania czy koniec tekstu
	cld
	mov ecx, 0
	mov edi, esi
ptl:
	lodsb	; zaladuj kolejny znak do AL
	cmp al, 0
	jz koniec
	mov ebx, klucz
	xor al, bl	; szyfrowanie bajtu z tekstu zrodlowegop
	stosb	; przeslij wynik szyfrowania a nastepnie zwieksz adres
szyfruj:
; nie musze zapamietywac eax ze wzgledu na to, ze najpierw 
; przesylam AL do [esi] a potem szyfruje
	mov ebx, klucz	; przenies klucz szyfrujacy do ebx
	mov eax, 0
	shl ebx, 1
	adc al, 0	; dodaj z CF po przesunieciu
	bt ebx, 31	; sprawdz bit 30 (przed przesunieciem)
	adc al, 0	; dodaj do al zawartosc bitu 31 (30 przed przesunieciem)
	div dzielnik	; ah = reszta dzielenia bitow przez 2

	add klucz, eax	; dodanie reszty z klucza szyfrujacaego <=> uzupelnienie przesunietego bitu)
	jmp ptl
koniec:
	pop edx
	pop esi
	pop edi
	pop ebx
	pop ebp
	ret
_szyfruj ENDP
END