.686
.model flat
public _miesz2float

.data
.code
_miesz2float PROC
	push ebp
	mov ebp, esp
	push ebx
	push esi
	push edi
	push ecx

	mov ebx, [ebp+8]	; p
	mov ecx, 0
szukaj_niejawnej_jedynki:
; szukaj niejawnej 1 aby obliczyc przesuniecie
	shl ebx, 1
	inc ecx
	jnc szukaj_niejawnej_jedynki
	dec ecx	; usun przesuniecie dla niejawnej jedynki
	push ecx	; zapamietaj o ile przesuniete bylo w szukaniu pierwszej jedynki od lewej
	cmp ecx, 23 ; niejawna jedynka ustawiona
	jz niejawna_na_miejscu
	jb niejawna_jedynka_lewo	; w tym przypadku niejawna jedynka w MIESZ32 znajduje sie w czesci calkowitej
;teraz przypadek gdy niejawna jedynka znajduje sie w czesci ulamkowej
	push eax
; wyliczenie znormalizowanego wykladnika dla liczby z niejawna jedynka w czesci ulamkowej
	mov eax, 127
	sub ecx, 23	; obliczenie przesuniecia
	sub eax, ecx
	xchg eax, ecx
	pop eax
	jmp koniec
niejawna_jedynka_lewo:
	push eax	; zapamietaj eax tymczasowo
	mov eax, 23
	sub eax, ecx	; eax = 23-miejsce_pierwszej_jedynki
	xchg eax, ecx
	pop eax
	add ecx, 127	; normailzacja wykladnika
	jmp koniec
niejawna_na_miejscu:
; obliczanie wartosci wykladnika
	push eax
	mov eax, 23
	sub eax, ecx	; wyliczeie przesuniecia na podstawie pozycji znalezionej jedynki
	xchg ecx, eax
	pop eax
	add ecx, 127	; normailzacja wykladnika
koniec:
	;mov ebx, [ebp+8]
	shr ebx, 8	; zrob miejesce na wykladnik (bez miejsca na znak)
	;shl ebx, 23 ; przesun ebx do poczatku mantysy
 	shl ecx, 24	; przesun znormalizowany wykladnik do bitu mlodszego niz znak
	or ebx, ecx	; zalozenie - liczba bez znaku
	shr ebx, 1	; zrob miejsce na znak. Zalozenie liczba bez znaku
	pop ecx	; zdejmij ze stosu znalezione miejsce niejawnej jedynki
	push ebx	; wrzuc na stos skonwertowana liczbe float
	fld dword PTR [esp]
	add esp, 4	; zwalnianie pamieci
	pop ecx
	pop edi
	pop esi
	pop ebx
	pop ebp
	ret
_miesz2float ENDP
END