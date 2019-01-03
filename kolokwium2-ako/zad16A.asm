.686
.model flat
public _plus_jeden

.data

.code
_plus_jeden PROC
	push ebp
	mov ebp, esp
	push ebx
	push esi
	push edi

;odczytanie liczby w formacie double
	mov eax, [ebp+8]
	mov edx, [ebp+12]
; wpisanie 1 na pozycji o wadze 2^0 mantysy do EDI:ESI
	mov esi, 0
	mov edi, 00100000h
; wyodrebnienie pola wykladnika (11-bitowy)
; bit znaku liczby z zalozenia = 0
	mov ebx, edx
	shr ebx, 20
; obliczenie pierwotnego wykladnika potegi
	;mov ecx, 1075 ; dopisane wlasne
	;sub ecx, ebx
	sub ebx, 1023
; zerowanie wykladnika i bitu znaku
	and edx, 000fffffh
; dopisanie niejawnej jedynki 
	or edx, 00100000h

	; wlasny kod
	mov ecx, ebx
	shrd edi, esi, cl	; przesun 1 z EDI:ESI o zawartosc wykladnika
	add eax, esi	; zwieksz EDX:EAX (w tym kroku wykladnik wyciety)  o 1 z EDI:ESI
	adc edx, edi	; jesli byl CF do dodaj z CF 
					; poniewaz oznacza to, ze nie starczylo miejsca w mlodszych 32-bitach
	bt edx, 20	; sprawdz bit niejawnej jedynki. Sprawdzenie czy mantysa < 2
	jc dalej
	shrd edx, eax, 1	; mormalizacja mantysy
	adc eax, 1	; zaokraglenie mlodszej czesci
	add ebx, 1
dalej:
	and edx, 001FFFFFh	; zostaw tylko bity ulamkowe mantysy
	and eax, 0FFFFFFFFh
	add ebx, 1023	; przywroc znormalizowany wykladnik
	shl ebx, 20	; przywroc wykladnik na swoje miejsce ebx
	or edx, ebx

; zaladowanie obliczonej wartosci z EDX:EAX na wierzcholek stosu koprocesora
	push edx
	push eax
	fld qword PTR [esp]
	add esp, 8
	pop edi
	pop esi
	pop ebx
	pop ebp
	ret
_plus_jeden ENDP
END