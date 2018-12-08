.686
.model flat
public _roznica

.data
.code
_roznica PROC
	push ebp
	mov ebp, esp
	push esi	; odkladanie zgodnie ze standardem C
	push edi
	push ebx

	mov esi, dword ptr [ebp+12]	; **odjemnik
	mov edi, dword ptr [ebp+8]	; *odjemna

	mov eax, [esi]	; w eax adres *odjemnik
	mov eax, [eax]	; wartosc odjemnika
	mov ebx, [edi]	; przenies wartosc pod adresem odjemnej
	sub eax, ebx	; wynik w eax

	pop ebx
	pop edi
	pop esi
	pop ebp
	ret
_roznica ENDP
END