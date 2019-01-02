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
	sub ebx, 1023
; zerowanie wykladnika i bitu znaku
	and edx, 000fffffh
; dopisanie niejawnej jedynki 
	or edx, 00100000h

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