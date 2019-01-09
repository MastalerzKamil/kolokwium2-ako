.686
.model flat
public _sortowanie

.data
n	dd	0

.code
_sortowanie PROC
	push ebp
	mov ebp, esp
	push ebx
	push edi
	push esi
	push ecx

	mov esi, [ebp+8]	; tabl
	mov ecx, [ebp+12]	; n
	mov n, ecx
	mov ecx, 0
	lea eax, [esi+ 8*ecx]	; mlodsza czesc pierwszej liczby
	lea edx, [esi+8*ecx+4]	; starsza czesc pierszej liczby
ptl_zewnetrzna:
	push ecx
	lea eax, [esi+8*ecx]	; mlodsza czesc liczby
	lea edx, [esi+8*ecx+4]	; starsza czesc liczby 
ptl_wewnetrzna:
	push edx
	mov edx, [edx]
	cmp edx, [esi+8*ecx+4]
	pop edx
	ja zamien_miejsca
	jmp sprawdz_mlodsze_czesci	; sytuacja gdy starsze czesci sa takie same i o 
								; nierowosci decyduje mlodsza czesc liczby
dalej:
	inc ecx
	cmp ecx, n
	jnz ptl_wewnetrzna
	pop ecx	; zdejmij iterator sprzed petli zewnetrznej
	inc ecx
	cmp ecx, n
	jnz ptl_zewnetrzna
	jmp znajdz_max
sprawdz_mlodsze_czesci:
	push eax
	mov eax, [eax]
	cmp eax, [esi+8*ecx]
	pop eax
	ja zamien_miejsca
	jmp dalej
zamien_miejsca:
	push esi	;zapamietaj adres poczatkowy
	push edi
	lea esi, [esi+8*ecx]	; adres z ktorego zamienic
	lea edi, [eax]	; adres z ktora liczba zamienic
; najpierw zamiana mlodszych czesci
	push eax
	push edx
	mov eax, [esi]	; pobierz najmlodsze czesci obu liczb
	mov edx, [edi]
	mov [edi], eax	;zapisz mlodsze czesci obu liczb (juz zamienione)
	mov [esi], edx

	mov eax, [esi+4]	; pobierz starsze czesci obu liczb
	mov edx, [edi+4]
	mov [esi+4], eax	; zapisz starsze czesci obu liczb (juz zamienione)
	mov [edi+4], edx

	pop edx
	pop eax
	pop edi
	pop esi
	jmp dalej
znajdz_max:
; zalozenie, ze ostatnia liczba to max
	dec ecx	; zmniejsz w celu nie wyjscia poza zakres tablicy
	mov eax, [esi+8*ecx]	; mlodsza czesc maxa
	mov edx, [esi+8*ecx+4]	; starsza czesc maxa

	pop ecx
	pop esi
	pop edi
	pop ebx
	pop ebp
	ret
_sortowanie ENDP
END